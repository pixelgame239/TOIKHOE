import 'package:flutter/material.dart';

class VerifyScreen extends StatefulWidget {
  final String email; // Email được truyền từ màn hình đăng ký

  VerifyScreen({required this.email});

  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final _otpController = TextEditingController();

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  Future<void> _verifyOtp() async {
    final otp = _otpController.text.trim();
    // TODO: Xác thực mã OTP từ backend hoặc bộ nhớ cục bộ
    if (otp == "123456") { // Giả lập mã OTP hợp lệ
      print("OTP verified for email: ${widget.email}");
      // TODO: Lưu dữ liệu người dùng vào database sau khi xác thực thành công
      _saveUserToDatabase();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid OTP. Please try again.')),
      );
    }
  }

  Future<void> _saveUserToDatabase() async {
    // TODO: Gửi dữ liệu người dùng đã xác thực đến backend
    print("User data saved to database!");
    Navigator.pop(context); // Quay lại màn hình chính
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify Email OTP'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Enter the OTP sent to ${widget.email}:'),
            TextFormField(
              controller: _otpController,
              decoration: InputDecoration(labelText: 'OTP'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the OTP';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _verifyOtp,
              child: Text('Verify'),
            ),
          ],
        ),
      ),
    );
  }
}
