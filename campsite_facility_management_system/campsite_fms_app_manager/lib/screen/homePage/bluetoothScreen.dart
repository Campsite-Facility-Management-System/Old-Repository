// import 'package:flutter/material.dart';
// import 'package:flutter_blue/flutter_blue.dart';

// class BluetoothScreen extends StatefulWidget {
//   @override
//   BluetoothScreenState createState() => BluetoothScreenState();
// }

// class BluetoothScreenState extends State<BluetoothScreen> {
//   bool _isScanning = false;

//   scan() {
//     if (!_isScanning) {
//       flutterBlue.startScan(timeout: Duration(seconds: 4));

//       print("블루투스 스캔 시작");
//       // Listen to scan results
//       var subscription = flutterBlue.scanResults.listen((results) {
//         // do something with scan results
//         for (ScanResult r in results) {
//           print('스캔데이터: ${r.device.name} found! rssi: ${r.rssi}');
//           print('테스트: ' + r.advertisementData.serviceUuids.toString());
//         }
//       });
//       _isScanning = true;
//     } else {
//       flutterBlue.stopScan();
//       print("블루투스 스캔 종료");
//       _isScanning = false;
//     }
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     scan();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Widget buildItem(ScanResult s) {
//       return ListTile(
//         leading: Text(s.rssi.toString()),
//         title: Text(s.device.name),
//         subtitle: Text(s.device.id.id),
//       );
//     }

//     Widget buildList(List<ScanResult> scanResults) {
//       for (ScanResult sr in scanResults) {
//         print(sr.device.id.id);
//         print(sr.rssi.toString());
//       }

//       return Column(
//         children: scanResults.map((v) => buildItem(v)).toList(),
//       );
//     }

//     Widget buildBody() {
//       return SingleChildScrollView(
//         child: StreamBuilder<List<ScanResult>>(
//             stream: FlutterBlue.instance.scanResults,
//             initialData: [],
//             builder: (c, snapshot) {
//               return buildList(snapshot.data);
//             }),
//       );
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('디바이스 검색(블루투스)'),
//         backgroundColor: Colors.green,
//       ),
//       body: buildBody(),
//     );
//   }
// }
