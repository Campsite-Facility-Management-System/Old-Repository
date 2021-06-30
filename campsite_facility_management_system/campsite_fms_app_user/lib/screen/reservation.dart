import 'package:campsite_fms_app_user/env.dart';
import 'package:campsite_fms_app_user/function/categoryList.dart';
import 'package:campsite_fms_app_user/function/getX/campDetailGetX.dart';
import 'package:campsite_fms_app_user/function/token/tokenFunction.dart';
import 'package:campsite_fms_app_user/provider/idCollector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:campsite_fms_app_user/function/getX/reservationGetX.dart';
import 'package:intl/intl.dart';

class ReservationScreen extends StatefulWidget {
  @override
  ReservationScreenState createState() => ReservationScreenState();
}

class ReservationScreenState extends State<ReservationScreen> {
  final token = new FlutterSecureStorage();
  static final provider = new IdCollector();
  final tokenFunction = TokenFunction();
  TextEditingController adult_number = new TextEditingController();
  TextEditingController children_number = new TextEditingController();
  TextEditingController car_number = new TextEditingController();
  String startDate;
  String endDate;

  _check() async {
    bool result = await tokenFunction.tokenCheck(context);
    if (!result) {
      Navigator.pushNamed(context, '/login');
    }
  }

  @override
  void initState() {
    super.initState();
    _check();
  }

  @override
  Widget build(context) {
    final controller = Get.put(CampDetailGetX());
    final reservationController = Get.put(ReservationGetX());
    Future.delayed(Duration(milliseconds: 1000), () {
      // Do something
    });

    String _selectedDate = '';
    String _dateCount = '';
    String _range = '';
    String _rangeCount = '';

    void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
      /// The argument value will return the changed date as [DateTime] when the
      /// widget [SfDateRangeSelectionMode] set as single.
      ///
      /// The argument value will return the changed dates as [List<DateTime>]
      /// when the widget [SfDateRangeSelectionMode] set as multiple.
      ///
      /// The argument value will return the changed range as [PickerDateRange]
      /// when the widget [SfDateRangeSelectionMode] set as range.
      ///
      /// The argument value will return the changed ranges as
      /// [List<PickerDateRange] when the widget [SfDateRangeSelectionMode] set as
      /// multi range.
      setState(() {
        if (args.value is PickerDateRange) {
          _range =
              DateFormat('yyyyMMdd').format(args.value.startDate).toString() +
                  ' - ' +
                  DateFormat('yyyyMMdd')
                      .format(args.value.endDate ?? args.value.startDate)
                      .toString();
          print(_range);
          startDate =
              DateFormat('yyyyMMdd').format(args.value.startDate).toString();
          endDate = DateFormat('yyyyMMdd')
              .format(args.value.endDate ?? args.value.startDate)
              .toString();
        } else if (args.value is DateTime) {
          _selectedDate = args.value.toString();
        } else if (args.value is List<DateTime>) {
          _dateCount = args.value.length.toString();
        } else {
          _rangeCount = args.value.length.toString();
        }
      });

      // _postRequest() async {
      //   http.Response response = await http.post(url, headers: <String, String> {

      //   })
      // }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Reservation'),
        backgroundColor: Color(0xFF00A963),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 750,
          child: GetBuilder<ReservationGetX>(
            builder: (_) {
              return Form(
                child: Column(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // children: <Widget>[
                      //   Text('Selected date: ' + _selectedDate),
                      //   Text('Selected date count: ' + _dateCount),
                      //   Text('Selected range' + _range),
                      //   Text('Selected ranges count: ' + _rangeCount)
                      // ],
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      top: 80,
                      bottom: 0,
                      child: SfDateRangePicker(
                        view: DateRangePickerView.month,
                        selectionMode: DateRangePickerSelectionMode.range,
                        onSelectionChanged: _onSelectionChanged,
                        initialSelectedRange: PickerDateRange(
                          DateTime.now().subtract(const Duration(days: 4)),
                          DateTime.now().add(const Duration(days: 3)),
                        ),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 20,
                        ),
                        Text('성인 인원수'),
                      ],
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: '성인 인원수'),
                      controller: adult_number,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 20,
                        ),
                        Text('어린아 인원수'),
                      ],
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: '어린이 인원수'),
                      controller: children_number,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 20,
                        ),
                        Text('차량 수'),
                      ],
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: '차량수'),
                      controller: car_number,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 20,
                        ),
                        Text('이용요금'),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 20,
                        ),
                        Text(reservationController.price.toString() + '원'),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
      // body: SingleChildScrollView(child: GetBuilder<CampDetailGetX>(
      //   builder: (_) {
      //     return Container(
      //         child: Column(
      //       children: <Widget>[],
      //     ));
      //   },
      // )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        height: 50,
        width: 400,
        child: FloatingActionButton.extended(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          onPressed: () {
            reservationController.adult_number = adult_number.text;
            reservationController.children_number = children_number.text;
            reservationController.car_number = car_number.text;
            reservationController.start_time = startDate;
            reservationController.end_time = endDate;
            reservationController.reservation();
          },
          label: const Text('예약하기',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          backgroundColor: Color(0xFF00A963),
        ),
      ),
    );
  }
}
