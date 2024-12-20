import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_zalo/flutter_zalo.dart';
import 'package:toikhoe/database/connection.dart';
import 'package:toikhoe/database/getBsprofile.dart';
import 'package:toikhoe/loginScreen/register_screen.dart';
import 'package:toikhoe/mainScreen/home_Screen.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);
  TextEditingController userController = TextEditingController();
  TextEditingController passController = TextEditingController();
  String errorPass = '';
  bool valid = true;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<LoginScreen> {
  // FlutterZalo flutterZalo = FlutterZalo();

  @override
  void initState() {
    super.initState();
    // flutterZalo.init();
  }
  void validateLogin(String userName, String password){
    if(password.length <6){
      widget.errorPass='Mật khẩu cần phải có ít nhất 6 ký tự';
      widget.valid=false;
      setState(() {
      });
    }
    else{
      widget.errorPass ='';
      widget.valid=true;
      setState(() {
      });
    }
  }
  // showMessage(String msg) {
  //   ScaffoldMessenger.of(context).clearSnackBars();
  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //     content: Text(msg),
  //   ));
  //   print(msg);
  // }

  // void logIn() async {
  //   bool? result = await flutterZalo.logIn();
  //   if(result!){
  //     showMessage("Logged in");
  //     final userData = await getProfile();
  //     Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
  //   }
  //   else{
  //     showMessage('Failed to log in');
  //   }
  // }

  // void isAccessTokenValid() async {
  //   bool? isValid = await flutterZalo.isAccessTokenValid();
  //   showMessage("Is access token valid:\n$isValid");
  // }

  // void getAccessToken() async {
  //   String? accessToken = await flutterZalo.getAccessToken();
  //   showMessage("Access Token:\n$accessToken");
  // }

  // void refreshAccessToken() async {
  //   bool? isRefreshed = await flutterZalo.refreshAccessToken();
  //   showMessage("Refreshed access token:\n$isRefreshed");
  // }

  // Future<Map<String, dynamic>> getProfile() async {
  //   Map<String, dynamic>? profile = await flutterZalo.getProfile();
  //   showMessage("Profile:\n$profile");
  //   return profile!;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                TextFormField(
                  controller: widget.userController,
                decoration: const InputDecoration(label: Text('Tài khoản'), hintText: 'Nhập tên tài khoản'),
                ),
              TextFormField(
                  controller: widget.passController,
                  obscureText: true,
                  obscuringCharacter: '•',
                  decoration: InputDecoration(label: const Text('Mật khẩu'), hintText: 'Nhập mật khẩu', 
                  errorText: widget.valid
                  ? null
                  : widget.errorPass
                  ),
                ),
                const SizedBox(),
                TextButton(onPressed: ()async{
                  connectToRDS();
                  validateLogin(widget.userController.text, widget.passController.text);
                  if(widget.valid==true){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                  }
                },
                style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.blueAccent), fixedSize: WidgetStateProperty.all(Size(500, 20))),
                child: const Text('Đăng nhập', style: TextStyle(color: Colors.white),),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Chưa có tài khoản?'),
                    TextButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterScreen()));
                    }, child: const Text('Đăng ký', style: TextStyle(color: Colors.blue),))
                  ],
                )
                ]
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(20),
            //   child: TextButton(
            //     onPressed: (){
        
            //     }, 
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         SizedBox(
            //           height: 20,
            //           child: Image.asset('assets/GoogleLogin.png', fit: BoxFit.cover)
            //         ),
            //         const Text(' Đăng nhập bằng Google')
            //       ],
            //     )
            //     ),
            //   ),
            // Padding(
            //   padding: const EdgeInsets.all(20),
            //   child: TextButton(
            //     style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.white)),
            //     onPressed: (){
            //       Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
            //     },
            //     // onPressed: logIn,
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         SizedBox(
            //           height: 20,
            //           child: Image.asset('assets/ZaloLogin.jpg', fit: BoxFit.cover)
            //         ),
            //         const Text(' Đăng nhập bằng Zalo')
            //       ],
            //     )
            //     ),
            // ),
          ],
        ),
      ),
    );
  }
}