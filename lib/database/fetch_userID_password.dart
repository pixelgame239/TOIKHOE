import 'package:mysql1/mysql1.dart';
import 'package:toikhoe/database/connection.dart';

MySqlConnection? conn; // Khai báo biến kết nối

Future<void> initializeConnection() async {
  try {
    conn = await connectToRDS(); // Khởi tạo kết nối
    print('Kết nối thành công!');
  } catch (e) {
    print('Lỗi khi kết nối tới RDS: $e');
  }
}

Future<List<Map<String, String>>> fetchTaiKhoanInfo() async {
  List<Map<String, String>> accounts = [];

  if (conn == null) {
    print('Kết nối chưa được khởi tạo.');
    return accounts; // Trả về danh sách rỗng
  }

  try {
    // Sử dụng prepared statement để bảo vệ dữ liệu
    final result = await conn!.query("SELECT userID, password FROM Users");

    // Lưu trữ thông tin tài khoản vào danh sách
    for (var row in result) {
      accounts.add({
        'userID': row[0]?.toString() ?? '', // Chuyển đổi giá trị về String
        'password': row[1]?.toString() ?? '', // Chuyển đổi giá trị về String
      });
    }

    print('Lấy thông tin tài khoản thành công: $accounts');
  } catch (e) {
    print('Lỗi khi lấy thông tin tài khoản: $e');
  }

  return accounts;
}