import 'package:flutter/material.dart';
import 'package:toikhoe/MainScreen/home_screen.dart';
import 'package:toikhoe/database/lay_ID_matKhau.dart';
import 'package:toikhoe/loginScreen/register_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController userController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String errorMessage = '';
  bool valid = true;

  @override
  void initState() {
    super.initState();
    initializeConnection(); // Khởi tạo kết nối RDS
  }

  Future<bool> authenticateUser(String userName, String password) async {
    List<Map<String, String>> accounts = await fetchTaiKhoanInfo();

    // Kiểm tra tài khoản và mật khẩu
    for (var account in accounts) {
      if (account['ID'] == userName && account['matKhau'] == password) {
        return true; // Đăng nhập thành công
      }
    }
    return false; // Đăng nhập thất bại
  }

  void validateAndLogin() async {
    String userName = widget.userController.text.trim();
    String password = widget.passController.text.trim();

    // Kiểm tra đầu vào
    if (userName.isEmpty || password.isEmpty) {
      setState(() {
        errorMessage = 'Tài khoản và mật khẩu không được để trống';
        valid = false;
      });
      return;
    }

    // Kiểm tra đăng nhập
    bool isAuthenticated = await authenticateUser(userName, password);
    if (isAuthenticated) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } else {
      setState(() {
        errorMessage = 'Sai tài khoản hoặc mật khẩu';
        valid = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: widget.userController,
                decoration: const InputDecoration(
                  labelText: 'Tài khoản',
                  hintText: 'Nhập tên tài khoản',
                ),
              ),
              TextFormField(
                controller: widget.passController,
                obscureText: true,
                obscuringCharacter: '•',
                decoration: InputDecoration(
                  labelText: 'Mật khẩu',
                  hintText: 'Nhập mật khẩu',
                  errorText: valid ? null : errorMessage,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: validateAndLogin,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
                child: const Text('Đăng nhập'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Chưa có tài khoản?'),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterScreen()));
                    },
                    child: const Text(
                      'Đăng ký',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
