import 'package:flutter/material.dart';
import 'package:toikhoe/loginScreen/login_screen.dart'; // Import Login Screen
import 'package:toikhoe/loginScreen/register_screen.dart'; // Import Register Screen


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      initialRoute: '/login', // Màn hình mặc định khi chạy ứng dụng
      routes: {
        '/login': (context) => LoginScreen(), // Định nghĩa route cho LoginScreen
        '/register': (context) => RegisterPage(), // Định nghĩa route cho RegisterPage
      },

    );
  }
}
