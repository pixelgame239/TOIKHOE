import 'package:flutter/material.dart';
import 'package:flutter_zalo/flutter_zalo.dart';
import 'package:toikhoe/MainScreen/homeScreen.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FlutterZalo flutterZalo = FlutterZalo();

  @override
  void initState() {
    super.initState();
    flutterZalo.init();
  }

  showMessage(String msg) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
    ));
    print(msg);
  }

  void logIn() async {
    bool? result = await flutterZalo.logIn();
    if(result!){
      showMessage("Logged in");
      final userData = await getProfile();
      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(profile: userData)));
    }
    else{
      showMessage('Failed to log in');
    }
  }

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

  Future<Map<String, dynamic>> getProfile() async {
    Map<String, dynamic>? profile = await flutterZalo.getProfile();
    showMessage("Profile:\n$profile");
    return profile!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20),
                ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextButton(
                  style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.white)),
                  onPressed: logIn,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                        child: Image.asset('assets/ZaloLogin.jpg', fit: BoxFit.cover)
                      ),
                      const Text(' Đăng nhập bằng Zalo')
                    ],
                  )
                  ),
              ),
              const VerticalDivider(),
            ],
          ),
        ),
      ),
    );
  }
}