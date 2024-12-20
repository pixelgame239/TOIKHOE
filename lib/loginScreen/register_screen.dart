import 'package:flutter/material.dart';
import 'package:toikhoe/database/insert_data.dart';
import 'package:toikhoe/loginScreen/otp_screen.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});
  TextEditingController phoneController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  TextEditingController homeController = TextEditingController();
  TextEditingController queQuanController = TextEditingController();

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isLoading = false;

  void registerUser() async {
    String phone = widget.phoneController.text.trim();
    String pass = widget.passController.text.trim();
    String confirmPass = widget.confirmController.text.trim();
    String home = widget.homeController.text.trim();
    String queQuan = widget.queQuanController.text.trim();

    // Kiểm tra mật khẩu và xác nhận mật khẩu
    if (pass != confirmPass) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Mật khẩu không khớp")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Gọi hàm insertTaiKhoan để thêm tài khoản vào cơ sở dữ liệu
      bool isInserted = await insertTaiKhoan(
        int.parse(
            phone), // Sử dụng số điện thoại làm ID (hoặc bạn có thể sử dụng phương thức tạo ID tự động)
        pass,
        phone, // Hoặc bạn có thể thêm tên người dùng vào trường này
        '1990-01-01', // Ngày sinh mặc định hoặc lấy từ input
        queQuan,
        home,
        phone,
      );

      if (isInserted) {
        // Chuyển đến màn hình OTP sau khi đăng ký thành công
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => OtpScreen()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Đăng ký thất bại")),
        );
      }
    } catch (e) {
      print("Lỗi đăng ký: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Đã có lỗi xảy ra, vui lòng thử lại")),
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
        title: Text('Đăng ký tài khoản'),
      ),
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
                obscureText: true,
              ),
              TextFormField(
                controller: widget.confirmController,
                decoration:
                    const InputDecoration(label: Text('Xác nhận mật khẩu')),
                obscureText: true,
              ),
              TextFormField(
                controller: widget.homeController,
                decoration: const InputDecoration(label: Text('Địa chỉ')),
              ),
              TextFormField(
                controller: widget.queQuanController,
                decoration: const InputDecoration(label: Text('Quê quán')),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  onPressed: _isLoading
                      ? null
                      : registerUser, // Disable button when loading
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
