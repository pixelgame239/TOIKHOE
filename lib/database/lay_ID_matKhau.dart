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
    // Thực hiện truy vấn để lấy ID và mật khẩu từ bảng TaiKhoan
    final result = await conn!.query("SELECT ID, matKhau FROM TaiKhoan");

    // Lưu trữ thông tin tài khoản vào danh sách
    for (var row in result) {
      accounts.add({
        'ID': row['ID'] as String,
        'matKhau': row['matKhau'] as String,
      });
    }

    print('Lấy thông tin tài khoản thành công: $accounts');
  } catch (e) {
    print('Lỗi khi lấy thông tin tài khoản: $e');
  }

  return accounts;
}
