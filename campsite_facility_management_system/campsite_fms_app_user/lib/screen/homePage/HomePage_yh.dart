// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:campsite_fms_app_user/env.dart';
// import 'package:campsite_fms_app_user/function/token/tokenFunction.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// // import 'package:campsite_fms_app_user/screen/homePage/camp/campListView.dart';
// import 'package:campsite_fms_app_user/function/getX/camplistGetX.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'dart:async';
// import 'package:get/get.dart';

// var list;

// class CampInfo {
//   final int campId;
//   final String campName;
//   final String imgLink;

//   CampInfo({this.campId, this.campName, this.imgLink});

// //캠핑장의 정보를 포함하는 인스턴스를 생성하여 반환하는 factory 생성자
//   factory CampInfo.fromJson(Map<String, dynamic> camping) {
//     return CampInfo(
//       campId: camping['id'],
//       campName: camping['name'],
//       imgLink: camping['img_url'],
//     );
//   }
// }

// class CampInfoList {
//   final List<CampInfo> camps;

//   CampInfoList({this.camps});

//   factory CampInfoList.fromJson(List<dynamic> campInfoList) {
//     List<CampInfo> camps = new List<CampInfo>();
//     camps = campInfoList.map((i) => CampInfo.fromJson(i)).toList();

//     return new CampInfoList(
//       camps: camps,
//     );
//   }
// }

// Future<Null> fetchCamp() async {
//   final response = await http.get(Env.url + '/api/campsite/user/list');
//   if (response.statusCode == 200) {
//     //final camping = json.decode(response.body);
//     //final camping = utf8.decode(nits)
//     list = CampInfoList.fromJson(json.decode(utf8.decode(response.bodyBytes)))
//         .camps;
//   }

//   throw Exception('Data Acqusitin Fail!');
// }

// class HomePage extends StatefulWidget {
//   @override
//   HomePageState createState() => HomePageState();
// }

// // Future<http.Response> fetchPost() {
// //   return http.get(Env.url + '/api/campsite/user/list');
// // }

// // Future<Post> fetchPost() async {
// //   final response = await http.get(Env.url + '/api/campsite/user/list');

// //   if (response.statusCode == 200) {
// //     // 만약 서버로의 요청이 성공하면, JSON을 파싱합니다.
// //     return Post.fromJson(json.decode(response.body));
// //   } else {
// //     // 만약 요청이 실패하면, 에러를 던집니다.
// //     throw Exception('Failed to load post');
// //   }
// // }

// class HomePageState extends State<HomePage> {
//   final token = new FlutterSecureStorage();
//   final tokenFunction = TokenFunction();

//   _check() async {
//     bool result = await tokenFunction.tokenCheck(context);
//     if (!result) {
//       Navigator.pushNamed(context, '/login');
//     }
//   }

//   var camp;

//   @override
//   void initState() {
//     super.initState();
//     camp = fetchCamp();
//     _check();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(CamplistGetX());
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: Color(0xFF00A963),
//           title: Text(
//             'MODAK MODAK',
//             style: TextStyle(fontFamily: 'HN'),
//           ),
//         ),
//         body: ListView.builder(
//           physics: BouncingScrollPhysics(),
//           itemCount: list.length == null ? 0 : list?.length,
//           itemBuilder: (context, index) {
//             if (index == 0) {
//               return Container();
//             } else {
//               return ListTile(
//                 leading: new CachedNetworkImage(
//                     //controller.campId
//                     imageUrl: Env.url + list[index]['imgLink']),
//                 title: list[index]['campName'], //camp name
//               );
//             }
//           },
//         )

//         // Container(
//         //   // child: Image.network(Env.url + '/api/campsite/user/list'),
//         //   color: Colors.amber,
//         //   height: 70,
//         //   //사진표시
//         // ),

//         // FutureBuilder(
//         //     future: fetchCamp(),
//         //     builder: (context, snapshot) {
//         //       if (snapshot.hasData) {
//         //         final campName = snapshot.data.campName;

//         //         return Column(
//         //           children: <Widget>[
//         //             Center(
//         //               child: Text(campName),
//         //             ),
//         //           ],
//         //         );
//         //       } else if (snapshot.hasError) {
//         //         return Text('$snapshot.error');
//         //       }

//         //       return CircularProgressIndicator();
//         //     })

//         );
//   }
// }
