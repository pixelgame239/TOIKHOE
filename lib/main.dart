// import 'dart:convert';
// import 'dart:developer';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:toikhoe/MainScreen/homeScreen.dart';
// import 'package:zalo_flutter/zalo_flutter.dart';

// void main() => runApp(const MyApp());

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({
//     Key? key,
//   }) : super(key: key);

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _indexReset = -1;
//   ValueKey<String> _key = const ValueKey<String>('');
//   String _accessToken = '';
//   String? _refreshToken;

//   @override
//   void initState() {
//     super.initState();
//     _initZaloFlutter();
//   }

//   Future<void> _initZaloFlutter() async {
//     if (Platform.isAndroid) {
//       final String? hashKey = await ZaloFlutter.getHashKeyAndroid();
//       log('HashKey: $hashKey');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _key,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 const CircleAvatar(
//                   child: Text('Cody Health'),
//                 ),
//                 const Padding(padding: EdgeInsets.only(bottom: 100)),
//                 TextFormField(
//                   initialValue: 'Nhập email:',
//                 ),
//                 TextButton(onPressed: () async{
//                   final Map<dynamic, dynamic>? data = await ZaloFlutter.login(
//                       refreshToken: _refreshToken,
//                     );
//                     try {
//                       // print("login: $data");
//                       if (data?['isSuccess'] == true) {

//                         _accessToken = (data?["data"]["accessToken"] as String?)!;
//                         _refreshToken =
//                             data?["data"]["refreshToken"] as String?;
//                         final Map<dynamic, dynamic>? userData = await ZaloFlutter.getUserProfile(accessToken: data?["data"]["accessToken"]);
//                         print('userData: $userData');
//                         Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(profile: userData)));
//                       }
//                       //Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
//                     } catch (e) {
//                       print("error login: $e");
//                     }
//                 }, child: Row(
//                   children: [
//                     Icon(Icons.login),
//                     Text('Đăng nhập bằng Zalo')
//                   ],
//                 )),
//                 CommonButton(
//                   text: 'Đăng nhập bằng Zalo',
//                   onPressed: () async {
//                     final Map<dynamic, dynamic>? data = await ZaloFlutter.login(
//                       refreshToken: _refreshToken,
                      
//                     );
//                     try {
//                       print("login: $data");
//                       if (data?['isSuccess'] == true) {
//                         _accessToken = (data?["data"]["accessToken"] as String?)!;
//                         _refreshToken =
//                             data?["data"]["refreshToken"] as String?;
//                       }
//                       final userData = await ZaloFlutter.getUserProfile(accessToken: _accessToken);
//                       Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(profile: userData)));
//                     } catch (e) {
//                       print("login: $e");
//                     }
//                     return data;
//                   },
//                 ),
//                 CommonButton(
//                   text: 'logout',
//                   onPressed: () async {
//                     _accessToken = '';
//                     _refreshToken = null;
//                     await ZaloFlutter.logout();

//                     _indexReset++;
//                     _key = ValueKey<String>(_indexReset.toString());
//                     setState(() {});
//                     return null;
//                   },
//                 ),
//                 CommonButton(
//                   text: 'validateRefreshToken',
//                   onPressed: () async {
//                     final bool data = await ZaloFlutter.validateRefreshToken(
//                       refreshToken: _refreshToken ?? '',
//                     );
//                     return data.toString();
//                   },
//                 ),
//                 CommonButton(
//                   text: 'getUserProfile',
//                   onPressed: () async {
//                     final Map<dynamic, dynamic>? profile =
//                         await ZaloFlutter.getUserProfile(
//                       accessToken: _accessToken ?? '',
//                     );
//                     return profile;
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class CommonButton extends StatefulWidget {
//   const CommonButton({
//     Key? key,
//     required this.text,
//     required this.onPressed,
//     this.color = Colors.blue,
//   }) : super(key: key);

//   final String text;
//   final Future<dynamic> Function() onPressed;
//   final Color color;

//   @override
//   _CommonButtonState createState() => _CommonButtonState();
// }

// class _CommonButtonState extends State<CommonButton> {
//   String? result;

//   @override
//   Widget build(BuildContext context) {
//     final Widget childText = Text(
//       widget.text,
//       style: const TextStyle(
//         color: Colors.white,
//         fontWeight: FontWeight.bold,
//       ),
//     );

//     final Widget button = MaterialButton(
//       minWidth: double.infinity,
//       height: 40,
//       color: widget.color,
//       padding: const EdgeInsets.all(16),
//       onPressed: () async {
//         _showLoading(context);
//         final DateTime time = DateTime.now();
//         print('[$time][commonButton] ${widget.text}');
//         final dynamic data = await widget.onPressed();
//         if (data == null) {
//           result = 'null';
//         } else if (data is String) {
//           result = data;
//         } else if (data is Map) {
//           result = jsonEncode(data);
//         }
//         setState(() {});
//       },
//       shape: const StadiumBorder(),
//       child: childText,
//     );

//     Widget showResult(String? text) {
//       if (text == null) {
//         return Container();
//       }
//       String data;
//       try {
//         final Map<String, dynamic>? object =
//             jsonDecode(text) as Map<String, dynamic>?;
//         data = const JsonEncoder.withIndent('  ').convert(object);
//       } catch (e) {
//         data = text;
//       }
//       return Text(data);
//     }

//     return Padding(
//       padding: const EdgeInsets.all(6.0),
//       child: Column(
//         children: <Widget>[
//           button,
//           showResult(result),
//         ],
//       ),
//     );
//   }

//   Future<void> _showLoading(BuildContext context) async {
//     await showDialog<void>(
//       context: context,
//       barrierDismissible: false,
//       builder: (_) {
//         return const Center(
//           child: CircularProgressIndicator(),
//         );
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:toikhoe/loginScreen/loginScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}