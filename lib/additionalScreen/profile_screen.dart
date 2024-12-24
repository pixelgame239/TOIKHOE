import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toikhoe/loginScreen/login_screen.dart';
import 'package:toikhoe/riverpod/user_riverpod.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Lấy thông tin người dùng từ Riverpod
    final user = ref.watch(userProvider).isNotEmpty
        ? ref.watch(userProvider).first
        : null;

    if (user == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Hồ sơ'),
        ),
        body: const Center(
          child: Text('Không có thông tin người dùng'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hồ sơ'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('assets/ZaloLogin.jpg'),
                radius: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TextFormField(
                  initialValue: user.name, // Hiển thị name từ Riverpod
                  enabled: false,
                  decoration:
                      const InputDecoration(icon: Icon(Icons.person_pin)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TextFormField(
                  initialValue: user.email, // Hiển thị email từ Riverpod
                  enabled: false,
                  decoration: const InputDecoration(icon: Icon(Icons.email)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TextFormField(
                  initialValue: user.phoneNumber, // Hiển thị phone từ Riverpod
                  enabled: false,
                  decoration:
                      const InputDecoration(icon: Icon(Icons.phone_android)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TextFormField(
                  initialValue: user.address, // Hiển thị address từ Riverpod
                  enabled: false,
                  decoration:
                      const InputDecoration(icon: Icon(Icons.location_on)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TextFormField(
                  initialValue: user.role, // Hiển thị role từ Riverpod
                  enabled: false,
                  decoration:
                      const InputDecoration(icon: Icon(Icons.account_circle)),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
                child: ElevatedButton(
                  onPressed: () {
                    // Reset the user state (log out)
                    ref.read(userProvider.notifier).logOut();

                    // Navigate to the login screen
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.logout,
                        color: Colors.red,
                      ),
                      Text('Đăng xuất'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
