import 'package:toikhoe/database/fetch_userID_password.dart';

Future<bool> insertUser(String name, String email, String password,
    String phone, String address, String role) async {
  if (conn == null) {
    print('Kết nối chưa được khởi tạo.');
    return false; // Trả về false nếu kết nối chưa được thiết lập
  }

  try {
    // Thực hiện truy vấn chèn dữ liệu vào bảng Users
    await conn!.query(
      "INSERT INTO Users (name, email, password, phone, address, role) "
      "VALUES (?, ?, ?, ?, ?, ?)",
      [name, email, password, phone, address, role],
    );

    print('Thêm người dùng thành công: email = $email');
    return true; // Trả về true nếu chèn thành công
  } catch (e) {
    print('Lỗi khi thêm người dùng: $e');
    return false; // Trả về false nếu có lỗi
  }
}
