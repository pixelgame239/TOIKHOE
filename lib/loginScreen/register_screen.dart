import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});
  TextEditingController phoneController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  TextEditingController homeController = TextEditingController();

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Đăng ký tài khoản'),),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextFormField(
                controller: widget.phoneController,
                decoration: const InputDecoration(label: Text('Số điện thoại')),
              ),
              TextFormField(
                controller: widget.passController,
                decoration: const InputDecoration(label: Text('Mật khẩu')),
              ),
              TextFormField(
                controller: widget.confirmController,
                decoration: const InputDecoration(label: Text('Xác nhận mật khẩu')),
              ),
              TextFormField(
                controller: widget.homeController,
                decoration: const InputDecoration(label: Text('Quê quán')),
              ),
              Padding(padding: 
                EdgeInsets.only(top: 20),
                child: TextButton(
                  onPressed: (){}, 
                child: Text('Đăng ký')),
              )
            ],
          ),
        ),
      ),
    );
  }
}