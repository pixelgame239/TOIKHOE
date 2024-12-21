import 'package:flutter/material.dart';
import 'package:toikhoe/MainScreen/home_screen.dart';
import 'package:toikhoe/database/fetch_userID_password.dart';
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
  bool isLoading = false;
  Map<String, int> loginAttempts =
      {}; // Theo dõi số lần đăng nhập sai theo tài khoản

  @override
  void initState() {
    super.initState();
    initializeConnection(); // Khởi tạo kết nối RDS
  }

  Future<String> authenticateUser(String userName, String password) async {
    try {
      List<Map<String, String>> accounts = await fetchTaiKhoanInfo().timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw Exception(
              'Kết nối tới cơ sở dữ liệu bị chậm. Vui lòng thử lại.');
        },
      );

      for (var account in accounts) {
        if (account['userID'] == userName) {
          if (account['password'] == password) {
            loginAttempts
                .remove(userName); // Xóa số lần đăng nhập sai nếu thành công
            return "success";
          } else {
            // Thêm logic giới hạn số lần đăng nhập sai
            loginAttempts[userName] = (loginAttempts[userName] ?? 0) + 1;

            if (loginAttempts[userName]! >= 5) {
              return "account_locked"; // Khóa tài khoản sau 5 lần sai
            }
            return "wrong_password";
          }
        }
      }
      return "user_not_found";
    } catch (e) {
      print("Lỗi khi xác thực người dùng: $e");
      return "error";
    }
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

    setState(() {
      isLoading = true;
    });

    try {
      String authResult = await authenticateUser(userName, password);

      if (authResult == "success") {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } else if (authResult == "wrong_password") {
        setState(() {
          errorMessage = 'Sai mật khẩu';
          valid = false;
        });
      } else if (authResult == "user_not_found") {
        setState(() {
          errorMessage = 'Tài khoản không tồn tại';
          valid = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Lỗi kết nối tới máy chủ. Vui lòng thử lại sau!')),
        );
      }
    } catch (e) {
      print("Lỗi đăng nhập: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Đã xảy ra lỗi không xác định. Vui lòng thử lại!')),
      );
    } finally {
      setState(() {
        isLoading = false;
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
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              TextFormField(
                controller: widget.passController,
                obscureText: true,
                obscuringCharacter: '•',
                decoration: InputDecoration(
                  labelText: 'Mật khẩu',
                  hintText: 'Nhập mật khẩu',
                  prefixIcon: const Icon(Icons.lock),
                  errorText: valid ? null : errorMessage,
                ),
              ),
              const SizedBox(height: 20),
              isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
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
