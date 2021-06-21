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
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  final tokenFuntion = TokenFunction();

  _check() async {
    bool result = await tokenFuntion.tokenCheck(context);
    if (!result) {
      Navigator.pushNamed(context, '/login');
    }
  }

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => MainFunction(1)));
    });

    return null;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _check();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ElectricGraphGetX());
    return RefreshIndicator(
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.green,
            title: Text('기기정보'),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                ElectricInfo(),
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
      ),
      onRefresh: refreshList,
      key: refreshKey,
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
