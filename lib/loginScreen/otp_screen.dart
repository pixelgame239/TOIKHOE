import 'package:flutter/material.dart';
import 'package:toikhoe/MainScreen/home_screen.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
    final List<TextEditingController> _otpControllers =
      List.generate(6, (index) => TextEditingController());
    String getOTPString() {
    return _otpControllers.map((controller) => controller.text).join();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter your OTP'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(6, (index) {
              return SizedBox(
                width: 35,
                height: 50,
                child: TextField(
                  controller: _otpControllers[index],
                  keyboardType: TextInputType.number,
                  maxLength: 1,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    counterText: '',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.blue),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  onChanged: (value) {
                    if (value.length == 1 && RegExp(r'^[0-9]$').hasMatch(value)) {
                      if (index < 5) {
                        FocusScope.of(context).nextFocus();
                      }
                    } else if (value.isEmpty && index > 0) {
                      FocusScope.of(context).previousFocus();
                    }
                  },
                ),
              );
            }),
          ),
          TextButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
            }, 
            child: Text('Xác nhận'))
        ],
      ),
    );
  }
}