import 'package:flutter/material.dart';
import 'package:toikhoe/database/insert_data.dart';
import 'package:toikhoe/loginScreen/otp_screen.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController provinceController = TextEditingController();
  String status = 'active'; // Mặc định là active
  String role = 'Patient'; // Mặc định là Patient

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isLoading = false;

  bool isPasswordValid(String password) {
    final regex = RegExp(r'^(?=.*[!@#\$%\^&\*])(?=.*[0-9]).{7,}$');
    return regex.hasMatch(password);
  }

  void registerUser() async {
    String name = widget.nameController.text.trim();
    String email = widget.emailController.text.trim();
    String phone = widget.phoneController.text.trim();
    String pass = widget.passController.text.trim();
    String confirmPass = widget.confirmController.text.trim();
    String address = widget.addressController.text.trim();
    String province = widget.provinceController.text.trim();
    String status = widget.status;
    String role = widget.role;

    if (!isPasswordValid(pass)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              "Mật khẩu phải có ít nhất 7 ký tự, bao gồm ký tự đặc biệt và chữ số"),
          duration: Duration(seconds: 5),
        ),
      );
      return;
    }

    if (pass != confirmPass) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Mật khẩu không khớp")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      bool isInserted = await insertUser(
        name,
        email,
        pass,
        phone,
        address,
        status,
        role,
        province,
      );

      if (isInserted) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => OtpScreen()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Đăng ký thất bại")),
        );
      }
    } catch (e) {
      print("Lỗi đăng ký: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Đã có lỗi xảy ra, vui lòng thử lại")),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đăng ký tài khoản'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextFormField(
                controller: widget.nameController,
                decoration: const InputDecoration(label: Text('Họ và tên')),
              ),
              TextFormField(
                controller: widget.emailController,
                decoration: const InputDecoration(label: Text('Email')),
              ),
              TextFormField(
                controller: widget.phoneController,
                decoration: const InputDecoration(label: Text('Số điện thoại')),
              ),
              TextFormField(
                controller: widget.passController,
                decoration: const InputDecoration(label: Text('Mật khẩu')),
                obscureText: true,
              ),
              TextFormField(
                controller: widget.confirmController,
                decoration:
                    const InputDecoration(label: Text('Xác nhận mật khẩu')),
                obscureText: true,
              ),
              TextFormField(
                controller: widget.addressController,
                decoration: const InputDecoration(label: Text('Địa chỉ')),
              ),
              TextFormField(
                controller: widget.provinceController,
                decoration:
                    const InputDecoration(label: Text('Tỉnh/Thành phố')),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  onPressed: _isLoading ? null : registerUser,
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Đăng ký'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
