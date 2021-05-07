import 'package:campsite_fms_app_manager/env.dart';
import 'package:campsite_fms_app_manager/model/electric/graphData.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ElectricGraph extends StatefulWidget {
  @override
  ElectricGraphState createState() => ElectricGraphState();
}

class ElectricGraphState extends State<ElectricGraph> {
  final token = new FlutterSecureStorage();
  Map gd;
  List<FlSpot> spot;

  Future<Null> _getData() async {
    var url = Env.url + '/api/device/manager/energy/chart';
    String value = await token.read(key: 'token');
    String myToken = ("Bearer " + value);

    var response = await http.post(url, headers: {
      'Authorization': myToken,
    }, body: {
      'device_id': '1',
    });
    var data = utf8.decode(response.bodyBytes);
    print("data: " + data.toString());
    setState(() {
      gd = jsonDecode(data) as Map;
      spot = makeSpot();
      print(spot.toString());
    });
  }

  List<FlSpot> makeSpot() {
    List<FlSpot> spotList = [];
    for (int i = 1; i < 13; i++) {
      spotList.add(FlSpot(
          (13.0 - i).toDouble(), gd["electricity"][12 - i]["watt"].toDouble()));
    }
    return spotList;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.5,
      child: Container(
        margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Padding(
          padding: EdgeInsets.only(right: 15, top: 20),
          child: LineChart(
            usageChart(makeSpot(), gd["max"]),
          ),
        ),
      ),
    );
  }
}

LineChartData usageChart(list, max) {
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
      show: true,
      bottomTitles: SideTitles(
        showTitles: true,
        reservedSize: 22,
        getTitles: (value) {},
      ),
      leftTitles: SideTitles(
        showTitles: true,
        getTitles: (value) {
          var l = (30000 / 5).toStringAsFixed(0);

          if (value.toString().split('.')[0] == l.toString()) {
            print('value: ' + value.toString().split('.')[0]);
            return l;
          } else if (value.toString().split('.')[0] == (l * 2).toString()) {
            print('value: ' + value.toString().split('.')[0]);
            return l * 2;
          } else if (value.toString().split('.')[0] == (l * 3).toString()) {
            print('value: ' + value.toString().split('.')[0]);
            return l * 3;
          }
        },
      ),
    ),
    borderData: FlBorderData(
      show: true,
      border: Border.all(color: Colors.green, width: 1),
    ),
    minX: 0,
    maxX: 13,
    minY: 0,
    maxY: max * 1.5,
    lineBarsData: [
      LineChartBarData(
        spots: list,
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
