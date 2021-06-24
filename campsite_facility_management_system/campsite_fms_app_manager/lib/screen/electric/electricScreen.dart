import 'package:campsite_fms_app_manager/function/mainFunction.dart';
import 'package:campsite_fms_app_manager/function/token/tokenFunction.dart';
import 'package:campsite_fms_app_manager/getX/electricGraphGetX.dart';
import 'package:campsite_fms_app_manager/model/electric/electricGraph.dart';
import 'package:campsite_fms_app_manager/model/electric/electricInfo.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ElectricScreen extends StatefulWidget {
  @override
  ElectricScreenState createState() => ElectricScreenState();
}

class ElectricScreenState extends State<ElectricScreen> {
  final tokenFuntion = TokenFunction();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ElectricGraphGetX());
    controller.loop();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.green,
          title: Text('기기정보'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              GetBuilder<ElectricGraphGetX>(
                builder: (_) {
                  return Container(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  left: 40, right: 70, top: 10, bottom: 10),
                              width: 150,
                              height: 200,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 0.5, color: Colors.white),
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.deviceName != null
                                        ? controller.deviceName
                                        : 'loading',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30),
                                    textAlign: TextAlign.left,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '<uuid>',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Text(
                                    controller.uuid != null
                                        ? controller.uuid
                                        : 'loading',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Transform.scale(
                                scale: 4.0,
                                child: Switch(
                                  value: controller.isSwitched,
                                  activeColor: Colors.green,
                                  activeTrackColor: Colors.lightGreen,
                                  onChanged: (value) {
                                    setState(() {
                                      controller.isSwitched = value;

                                      controller.apichangeStatus();
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  left: 20, right: 20, top: 10, bottom: 10),
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 0.5, color: Colors.grey),
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.grey[300],
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.electrical_services_outlined),
                                      SizedBox(width: 5),
                                      Text(
                                        '사용량',
                                        style: TextStyle(fontSize: 25),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    controller.usage.toString() + "kW",
                                    style: TextStyle(fontSize: 30),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  left: 10, right: 20, top: 10, bottom: 10),
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 0.5, color: Colors.grey),
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.grey[300],
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.money_rounded),
                                      SizedBox(width: 5),
                                      Text(
                                        '예상요금',
                                        style: TextStyle(fontSize: 25),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    controller.charge.toString() + "원",
                                    style: TextStyle(fontSize: 30),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),

              // ElectricInfo(),
              SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 30),
                child: Text('전력 사용량 그래프'),
              ),
              SizedBox(
                height: 10,
              ),
              GetBuilder<ElectricGraphGetX>(builder: (_) {
                return AspectRatio(
                  aspectRatio: 1.5,
                  child: Container(
                    margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: Padding(
                      padding: EdgeInsets.only(right: 15, top: 20),
                      child: LineChart(
                        usageChart(controller.makeSpot(), controller.max,
                            controller.leftTitle, context),
                      ),
                    ),
                  ),
                );
                ;
              })
            ],
          ),
        ),
      ),
    );
  }
}

LineChartData usageChart(spotList, max, leftTitle, context) {
  return LineChartData(
    gridData: FlGridData(
      show: false,
      drawVerticalLine: true,
      getDrawingHorizontalLine: (value) {
        return FlLine(
          color: Colors.white,
          strokeWidth: 1,
        );
      },
      getDrawingVerticalLine: (value) {
        return FlLine(
          color: Colors.white,
          strokeWidth: 1,
        );
      },
    ),
    titlesData: FlTitlesData(
      leftTitles: SideTitles(
        showTitles: true,
        reservedSize: 30,
        getTextStyles: (value) => const TextStyle(
          color: Colors.black,
          fontSize: 14,
        ),
        margin: 10,
        interval: 1,
        getTitles: (value) {
          if (value.toInt() == 0) {
            return '0';
          }

          if (value.toInt() == max.toInt()) {
            return max.toString();
          }

          return '';
        },
      ),
    ),
    borderData: FlBorderData(
      show: true,
      border: Border.all(color: Colors.green, width: 1),
    ),
    minX: 0,
    maxX: 13,
    minY: -2,
    maxY: max * 1.2,
    lineBarsData: [
      LineChartBarData(
        spots: spotList,
        isCurved: true,
        barWidth: 5,
        dotData: FlDotData(
          show: true,
        ),
        belowBarData: BarAreaData(
          show: false,
        ),
      )
    ],
  );
}
