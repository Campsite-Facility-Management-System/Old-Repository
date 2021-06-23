import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:campsite_fms_app_manager/getX/setDeviceGetX.dart';
import 'package:campsite_fms_app_manager/model/homePage/bluetoothList.dart';
import 'package:campsite_fms_app_manager/screen/homePage/setDeviceWifiScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:permission_handler/permission_handler.dart';

class SearchDeviceScreen extends StatefulWidget {
  final bool start;
  const SearchDeviceScreen({this.start = true});

  @override
  SearchDeviceScreenState createState() => SearchDeviceScreenState();
}

class SearchDeviceScreenState extends State<SearchDeviceScreen> {
  StreamSubscription<BluetoothDiscoveryResult> streamSubscription;
  List<BluetoothDiscoveryResult> results = List<BluetoothDiscoveryResult>();
  bool isDiscovering;
  BluetoothConnection connection;

  SearchDeviceScreenState();

  @override
  void initState() {
    super.initState();
    _checkPermissions();
    isDiscovering = widget.start;
    if (isDiscovering) {
      _startDiscovery();
    }
  }

  _checkPermissions() async {
    if (Platform.isAndroid) {
      if (await Permission.contacts.request().isGranted) {}
      Map<Permission, PermissionStatus> statuses =
          await [Permission.location].request();
      print(statuses[Permission.location]);
    }
  }

  void _restartDiscovery() {
    setState(() {
      results.clear();
      isDiscovering = true;
    });

    _startDiscovery();
  }

  _startDiscovery() async {
    print("검색 시작");
    streamSubscription =
        FlutterBluetoothSerial.instance.startDiscovery().listen((r) {
      setState(() {
        results.add(r);
      });
    });

    print(streamSubscription);

    streamSubscription.onDone(() {
      setState(() {
        isDiscovering = false;
      });
    });
  }

  connect(String address) async {
    try {
      connection = await BluetoothConnection.toAddress(address);
      print('커넥트 결과: Connected to the device');

      try {
        connection.output.add(utf8.encode('abc' + '\r\n'));
        await connection.output.allSent;

        print(".......");
        connection.input.listen((Uint8List data) {
          //Data entry point
          print('수신 데이터: ' + Utf8Decoder().convert(data));

          return Utf8Decoder().convert(data);
        });
      } catch (exception) {
        print("수신 오류");
        print(exception);
      }
    } catch (exception) {
      print('커넥트 결과: Cannot connect, exception occured');
    }
  }

  Future send(Uint8List data) async {
    connection.output.add(data);
    await connection.output.allSent;

    // connection.output.add(utf8.encode(data + '\r\n'));
    // await connection.output.allSent;
  }

  @override
  void dispose() {
    // Avoid memory leak (`setState` after dispose) and cancel discovery
    print("검색 종료");
    streamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SetDeviceGetX());
    return Scaffold(
      appBar: AppBar(
        title: isDiscovering
            ? Text('Discovering devices')
            : Text('Discovered devices'),
        actions: <Widget>[
          isDiscovering
              ? FittedBox(
                  child: Container(
                    margin: new EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                )
              : IconButton(
                  icon: Icon(Icons.replay),
                  onPressed: _restartDiscovery,
                )
        ],
      ),
      body: ListView.builder(
        itemCount: results.length,
        itemBuilder: (BuildContext context, index) {
          BluetoothDiscoveryResult result = results[index];
          return BluetoothList(
            device: result.device,
            rssi: result.rssi,
            onTap: () {
              controller.connect(result.device.address);
              Get.to(SetDeviceWifiScreen());
            },
            onLongPress: () async {
              try {
                bool bonded = false;
                if (result.device.isBonded) {
                  print('Unbonding from ${result.device.address}...');
                  await FlutterBluetoothSerial.instance
                      .removeDeviceBondWithAddress(result.device.address);
                  print('Unbonding from ${result.device.address} has succed');
                } else {
                  print('Bonding with ${result.device.address}...');
                  bonded = await FlutterBluetoothSerial.instance
                      .bondDeviceAtAddress(result.device.address);
                  print(
                      'Bonding with ${result.device.address} has ${bonded ? 'succed' : 'failed'}.');
                }
                setState(() {
                  results[results.indexOf(result)] = BluetoothDiscoveryResult(
                      device: BluetoothDevice(
                        name: result.device.name ?? '',
                        address: result.device.address,
                        type: result.device.type,
                        bondState: bonded
                            ? BluetoothBondState.bonded
                            : BluetoothBondState.none,
                      ),
                      rssi: result.rssi);
                });
              } catch (ex) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Error occured while bonding'),
                      content: Text("${ex.toString()}"),
                      actions: <Widget>[
                        new FlatButton(
                          child: new Text("Close"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              }
            },
          );
        },
      ),
    );
  }
}
