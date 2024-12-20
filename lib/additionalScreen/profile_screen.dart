import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import thư viện intl
import 'package:toikhoe/database/connection.dart';
import 'package:toikhoe/database/fetch_tai_khoan.dart';
import 'package:toikhoe/loginScreen/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<List<Map<String, dynamic>>> accountsFuture;

  @override
  void initState() {
    super.initState();
    accountsFuture = fetchAllTaiKhoan(); // Gọi hàm lấy tất cả dữ liệu tài khoản
  }

  // Hàm format lại ngày sinh
  String formatDate(dynamic date) {
    if (date == null) {
      return 'Không có ngày sinh';
    }

    try {
      // Kiểm tra nếu date là DateTime, nếu đúng thì sử dụng DateFormat để định dạng
      if (date is DateTime) {
        return DateFormat('dd/MM/yyyy').format(date);
      } else if (date is String && date.isNotEmpty) {
        // Nếu ngày là String, chuyển thành DateTime và định dạng
        DateTime parsedDate = DateTime.parse(date);
        return DateFormat('dd/MM/yyyy').format(parsedDate);
      }
      return 'Ngày không hợp lệ';
    } catch (e) {
      return 'Ngày không hợp lệ';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hồ sơ'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder<List<Map<String, dynamic>>>(
          // Lấy dữ liệu bất đồng bộ
          future: accountsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Lỗi: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('Không có dữ liệu'));
            } else {
              // Hiển thị dữ liệu khi lấy thành công
              var account =
                  snapshot.data![0]; // Lấy thông tin tài khoản đầu tiên

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/ZaloLogin.jpg'),
                    radius: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: TextFormField(
                      initialValue: account['hoTen'] ?? 'Không có tên',
                      enabled: false,
                      decoration:
                          const InputDecoration(icon: Icon(Icons.person_pin)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: TextFormField(
                      initialValue:
                          account['soDienThoai'] ?? 'Không có số điện thoại',
                      enabled: false,
                      decoration: const InputDecoration(
                          icon: Icon(Icons.phone_android)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: TextFormField(
                      initialValue: formatDate(
                          account['ngaySinh']), // Định dạng ngày sinh
                      enabled: false,
                      decoration: const InputDecoration(
                          icon: Icon(Icons.calendar_today)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
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
              );
            }
          },
        ),
      ),
    );
  }
}
