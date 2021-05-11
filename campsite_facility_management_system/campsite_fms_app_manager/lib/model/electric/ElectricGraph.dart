import 'dart:async';

import 'package:campsite_fms_app_manager/env.dart';
import 'package:campsite_fms_app_manager/model/electric/graphData.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

class ElectricGraph extends StatefulWidget {
  @override
  ElectricGraphState createState() => ElectricGraphState();
}

class ElectricGraphState extends State<ElectricGraph> {
  final token = new FlutterSecureStorage();
  Map gd;
  List<FlSpot> spot = List();
  List<int> leftTitle = List();

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
    // print("data: " + data.toString());
    setState(() {
      gd = jsonDecode(data) as Map;
      spot = makeSpot();
      // print(spot.toString());
      for (int i = 0; i < 5; i++) {
        leftTitle.add((gd["max"] / 4 * i).round());
      }
      Provider.of<GraphData>(context, listen: true).setMax(gd["max"]);
      Provider.of<GraphData>(context, listen: true).setElectricity(spot);
    });
  }

  List<FlSpot> makeSpot() {
    List<FlSpot> spotList = [];
    for (int i = 1; i < 13; i++) {
      spotList.add(
          FlSpot(i.toDouble(), gd["electricity"][12 - i]["watt"].toDouble()));
    }
    return spotList;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
    const duration = const Duration(seconds: 10);
    new Timer.periodic(duration, (Timer t) => _getData());
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
            usageChart(
                makeSpot(),
                Provider.of<GraphData>(context, listen: true).max,
                leftTitle,
                context),
          ),
        ),
      ),
    );
  }
}

LineChartData usageChart(list, max, leftTitle, context) {
  List<dynamic> l = List();
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
    // extraLinesData: VerticalLine(),
    // titlesData: FlTitlesData(
    //   show: true,
    //   bottomTitles: SideTitles(
    //     showTitles: true,
    //     reservedSize: 22,
    //     getTitles: (value) {},
    //   ),
    //   leftTitles:
    // SideTitles(
    //   showTitles: true,
    //   getTitles: (value) {
    //     print(value);
    //     if (value.toInt() == leftTitle[0]) {
    //       return value.toString();
    //     } else if (value.toInt() == leftTitle[1]) {
    //       return value.toString();
    //     } else if (value.toInt() == leftTitle[2]) {
    //       return value.toString();
    //     } else if (value.toInt() == leftTitle[3]) {
    //       return value.toString();
    //     } else if (value.toInt() == leftTitle[4]) {
    //       return value.toString();
    //     }
    //   },
    // ),
    // ),
    borderData: FlBorderData(
      show: true,
      border: Border.all(color: Colors.green, width: 1),
    ),
    minX: 0,
    maxX: 13,
    minY: -5,
    maxY: Provider.of<GraphData>(context, listen: true).max * 1.2,
    lineBarsData: [
      LineChartBarData(
        spots: Provider.of<GraphData>(context, listen: true).electricity,
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
