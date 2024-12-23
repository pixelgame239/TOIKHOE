import 'package:flutter/material.dart';
import 'package:toikhoe/MainScreen/home_Screen.dart';
import 'package:toikhoe/loginScreen/login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
