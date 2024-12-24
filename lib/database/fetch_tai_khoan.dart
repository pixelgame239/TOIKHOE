import 'package:toikhoe/database/fetch_userID_password.dart';

Future<List<Map<String, dynamic>>> fetchAllTaiKhoan() async {
  List<Map<String, dynamic>> accounts = [];
  if (conn == null) {
    print('Kết nối chưa được khởi tạo.');
    return accounts; // Trả về danh sách rỗng
  }

  try {
    // Thực hiện truy vấn để lấy toàn bộ dữ liệu từ bảng TaiKhoan
    final result = await conn!.query("SELECT * FROM Users");

    // Lưu trữ dữ liệu từng bản ghi vào danh sách
    for (var row in result) {
      accounts.add(row.fields);
    }

    print('Lấy toàn bộ thông tin tài khoản thành công: $accounts');
  } catch (e) {
    print('Lỗi khi lấy thông tin tài khoản: $e');
  }

  return accounts;
}

Future<Map<String, dynamic>?> fetchUserByPhoneNumber(String phoneNumber) async {
  if (conn == null) {
    print('Kết nối cơ sở dữ liệu chưa được khởi tạo.');
    return null;
  }

  try {
    final result = await conn!.query(
      "SELECT * FROM Users WHERE phone_number = ?",
      [phoneNumber],
    );

    if (result.isNotEmpty) {
      return result.first.fields; // Trả về bản ghi đầu tiên
    }
  } catch (e) {
    print('Lỗi khi lấy thông tin người dùng: $e');
  }
  return null; // Trả về null nếu không tìm thấy
}
