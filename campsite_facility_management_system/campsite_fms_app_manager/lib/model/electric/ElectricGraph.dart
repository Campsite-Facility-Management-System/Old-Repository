// import 'dart:async';

// import 'package:campsite_fms_app_manager/env.dart';
// import 'package:campsite_fms_app_manager/function/token/tokenFunction.dart';
// import 'package:campsite_fms_app_manager/model/electric/graphData.dart';
// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:provider/provider.dart';

// class ElectricGraph extends StatefulWidget {
//   @override
//   ElectricGraphState createState() => ElectricGraphState();
// }

// class ElectricGraphState extends State<ElectricGraph> {
//   final token = new FlutterSecureStorage();
//   final tokenFunction = new TokenFunction();
//   Map graphData;
//   List<FlSpot> spot = List();
//   List<int> leftTitle = List();

//   // Future<Null> _getData() async {
//   //   tokenFunction.tokenCheck(context);

//   //   var url = Env.url + '/api/device/manager/energy/chart';
//   //   String value = await token.read(key: 'token');
//   //   String myToken = ("Bearer " + value);

//   //   var response = await http.post(url, headers: {
//   //     'Authorization': myToken,
//   //   }, body: {
//   //     'device_id': '1',
//   //   });
//   //   var data = utf8.decode(response.bodyBytes);
//   //   // print("data: " + data.toString());
//   //   graphData = jsonDecode(data) as Map;
//   //   spot = makeSpot();
//   //   // print(spot.toString());
//   //   for (int i = 0; i < 5; i++) {
//   //     leftTitle.add((graphData["max"] / 4 * i).round());
//   //   }
//   //   Provider.of<GraphData>(context, listen: true).setMax(graphData["max"]);
//   //   Provider.of<GraphData>(context, listen: true).setElectricity(spot);

//   //   // print(spot);
//   //   setState(() {});
//   // }

//   // List<FlSpot> makeSpot() {
//   //   List<FlSpot> spotList = [];
//   //   if (graphData == null) {
//   //     for (int i = 0; i < 13; i++) spotList.add(FlSpot(i.toDouble(), 0.0));
//   //     return spotList;
//   //   }

//   //   for (int i = 1; i < 13; i++) {
//   //     spotList.add(FlSpot(
//   //         i.toDouble(), graphData["electricity"][12 - i]["watt"].toDouble()));
//   //   }
//   //   return spotList;
//   // }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AspectRatio(
//       aspectRatio: 1.5,
//       child: Container(
//         margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
//         child: Padding(
//           padding: EdgeInsets.only(right: 15, top: 20),
//           child: LineChart(
//             usageChart(
//                 makeSpot(),
//                 Provider.of<GraphData>(context, listen: true).max,
//                 leftTitle,
//                 context),
//           ),
//         ),
//       ),
//     );
//   }
// }

// LineChartData usageChart(list, max, leftTitle, context) {
//   return LineChartData(
//     gridData: FlGridData(
//       show: false,
//       drawVerticalLine: true,
//       getDrawingHorizontalLine: (value) {
//         return FlLine(
//           color: Colors.white,
//           strokeWidth: 1,
//         );
//       },
//       getDrawingVerticalLine: (value) {
//         return FlLine(
//           color: Colors.white,
//           strokeWidth: 1,
//         );
//       },
//     ),
//     titlesData: FlTitlesData(
//       leftTitles: SideTitles(
//         showTitles: true,
//         reservedSize: 30,
//         getTextStyles: (value) => const TextStyle(
//           color: Colors.black,
//           fontSize: 14,
//         ),
//         margin: 10,
//         interval: 1,
//         getTitles: (value) {
//           if (value.toInt() == 0) {
//             return '0';
//           }

//           if (value.toInt() ==
//               Provider.of<GraphData>(context, listen: true).max.toInt()) {
//             return Provider.of<GraphData>(context, listen: true).max.toString();
//           }

//           if (value.toInt() ==
//               Provider.of<GraphData>(context, listen: true).max.toInt()) {
//             return Provider.of<GraphData>(context, listen: true).max.toString();
//           }

//           return '';
//         },
//       ),
//     ),
//     borderData: FlBorderData(
//       show: true,
//       border: Border.all(color: Colors.green, width: 1),
//     ),
//     minX: 0,
//     maxX: 13,
//     minY: -2,
//     maxY: Provider.of<GraphData>(context, listen: true).max * 1.2,
//     lineBarsData: [
//       LineChartBarData(
//         spots: Provider.of<GraphData>(context, listen: true).electricity,
//         isCurved: true,
//         barWidth: 5,
//         dotData: FlDotData(
//           show: true,
//         ),
//         belowBarData: BarAreaData(
//           show: false,
//         ),
//       )
//     ],
//   );
// }
