import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class CheckGetX extends GetxController {
  StreamSubscription<BluetoothDiscoveryResult> streamSubscription;
  List<BluetoothDiscoveryResult> results = List<BluetoothDiscoveryResult>();
  bool isDiscovering;
  BluetoothConnection connection;

  @override
  onInit() {
    super.onInit();
    _checkPermissions();
  }

  _checkPermissions() async {
    if (Platform.isAndroid) {
      if (await Permission.contacts.request().isGranted) {}
      Map<Permission, PermissionStatus> statuses =
          await [Permission.location].request();
      print(statuses[Permission.location]);
    }
  }

  scan(String option, String myAddress) async {
    print("검색 시작");
    streamSubscription =
        FlutterBluetoothSerial.instance.startDiscovery().listen((r) {
      // results.add(r);
      if (r.device.address == myAddress) {
        connect(option, r.device.address);
      }
    });

    print(streamSubscription);

    streamSubscription.onDone(() {
      isDiscovering = false;
    });
  }

  connect(String option, String address) async {
    try {
      connection = await BluetoothConnection.toAddress(address);
      print('커넥트 결과: Connected to the device');

      try {
        connection.output.add(utf8.encode(option + '\r\n'));
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
}
