import 'package:campsite_fms_app_user/env.dart';
import 'package:campsite_fms_app_user/function/categoryList.dart';
import 'package:campsite_fms_app_user/function/getX/campDetailGetX.dart';
import 'package:campsite_fms_app_user/function/getX/categoryDeviceGetX.dart';
import 'package:campsite_fms_app_user/function/token/tokenFunction.dart';
import 'package:campsite_fms_app_user/screen/homePage/camp/myCamp.dart';
import 'package:campsite_fms_app_user/provider/idCollector.dart';
import 'package:campsite_fms_app_user/screen/reservation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:expand_widget/expand_widget.dart';

class CampDetailScreen extends StatefulWidget {
  @override
  CampDetailScreenState createState() => CampDetailScreenState();
}

class CampDetailScreenState extends State<CampDetailScreen> {
  final token = new FlutterSecureStorage();
  static final provider = new IdCollector();
  final tokenFunction = TokenFunction();

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
    final categoryDeviceController = Get.put(CategoryDeviceGetX());

    // print(Env.url + (controller.campDetailData['img_url'][0]['img_url']));
    // controller.getData();
    // controller.selectedCampId = item['id'];
    return Scaffold(
      appBar: AppBar(
        title: Text('캠핑장 세부정보'),
        backgroundColor: Color(0xFF00A963),
      ),
      body: SingleChildScrollView(
        child: GetBuilder<CampDetailGetX>(
          builder: (_) {
            return Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        controller.campDetailData['name'].toString(),
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    title: new CachedNetworkImage(
                      imageBuilder:
                          (BuildContext context, ImageProvider imageProvider) {
                        return Container(
                          height: 300,
                          decoration: BoxDecoration(
                            // border: Border.all(width: 0.5, color: Colors.black12),
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                              image: imageProvider,
                            ),
                          ),
                        );
                      },
                      imageUrl: Env.url +
                          controller.campDetailData['img_url'][0]['img_url'],
                      placeholder: (context, url) => Container(
                        height: 100,
                        child: SizedBox(
                          height: 100,
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          new Icon(Icons.error),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        '주소: ',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        controller.campDetailData['address'],
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        '연락처: ',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        controller.campDetailData['telephone'],
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        '<소개>',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Column(
                    children: <Widget>[
                      SizedBox(
                        width: 380,
                        child: ExpandText(
                          controller.campDetailData['description'] +
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam suscipit risus pulvinar, hendrerit nisi quis, vehicula ante. Morbi ut diam elit. Praesent non justo sodales, auctor lacus id, congue massa. Duis ac odio dui. Sed sed egestas metus. Donec hendrerit velit magna. Vivamus elementum, nulla ac tempor euismod, erat nunc mollis diam, nec consequat nisl ex eu tellus. Curabitur fringilla enim at lorem pulvinar, id ornare tellus aliquam. Cras eget nibh tempor lacus aliquam rutrum.',
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.justify,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 125,
                  ),
                  // SizedBox(
                  //   width: 400,
                  //   height: 50,
                  //   child: RaisedButton(
                  //     shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(15)),
                  //     color: Color(0xFF00A963),
                  //     onPressed: () => {},
                  //     child: Text(
                  //       '예약하기',
                  //       style: TextStyle(color: Colors.white),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        height: 50,
        width: 400,
        child: FloatingActionButton.extended(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          onPressed: () {
            // categoryDeviceController.apiDetailData();
            Future.delayed(Duration(milliseconds: 1000), () {
              // Do something
            });
            Get.to(CategoryList());
            // controller.selectedCampId = controller.campDetailData['id'];
            // controller.getData();
            // Get.to(ReservationScreen(),
            // arguments: controller.campDetailData['id']);
          },
          label: const Text('객실선택',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          backgroundColor: Color(0xFF00A963),
        ),
      ),
    );
  }
}
