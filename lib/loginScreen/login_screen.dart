import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toikhoe/MainScreen/home_screen.dart';
import 'package:toikhoe/database/fetch_tai_khoan.dart';
import 'package:toikhoe/database/fetch_userID_password.dart';
import 'package:toikhoe/loginScreen/register_screen.dart';
import 'package:toikhoe/riverpod/user_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController userController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  String errorMessage = '';
  bool valid = true;
  bool isLoading = false;
  Map<String, int> loginAttempts = {};

  @override
  void initState() {
    super.initState();
    initializeConnection();
  }

  void setUserToProvider(Map<String, String> userInfo) {
    final user = User(
      userId: int.parse(userInfo['user_id'] ?? '0'),
      name: userInfo['name'] ?? '',
      email: userInfo['email'] ?? '',
      phoneNumber: userInfo['phone_number'] ?? '',
      address: userInfo['address'] ?? '',
      status: userInfo['status'] ?? '',
      role: userInfo['role'] ?? '',
      province: userInfo['province'] ?? '',
      password: userInfo['password'] ?? '',
    );

    ref.read(userProvider.notifier).addUser(user);
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
        if (account['phone_number'] == userName) {
          if (account['password'] == password) {
            loginAttempts.remove(userName);
            return "success";
          } else {
            loginAttempts[userName] = (loginAttempts[userName] ?? 0) + 1;

            if (loginAttempts[userName]! >= 5) {
              return "account_locked";
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
      // Lấy thông tin người dùng từ database
      final userInfo = await fetchUserByPhoneNumber(userName);

      if (userInfo != null) {
        // Kiểm tra mật khẩu
        if (userInfo['password'] == password) {
          // Lưu thông tin người dùng vào Riverpod
          final user = User.fromJson(userInfo);
          ref.read(userProvider.notifier).addUser(user);

          print("Thông tin người dùng sau khi đăng nhập: ${user.toJson()}");

          // Chuyển đến màn hình chính
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        } else {
          setState(() {
            errorMessage = 'Sai mật khẩu';
            valid = false;
          });
        }
      } else {
        setState(() {
          errorMessage = 'Tài khoản không tồn tại';
          valid = false;
        });
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
                              builder: (context) => RegisterPage()));
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
