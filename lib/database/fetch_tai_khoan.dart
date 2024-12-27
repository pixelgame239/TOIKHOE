import 'package:toikhoe/database/fetch_userID_password.dart';

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
      // In ra dữ liệu để kiểm tra
      print("Thông tin người dùng: ${result.first.fields}");
      return result.first.fields; // Trả về bản ghi đầu tiên
    }
  } catch (e) {
    print('Lỗi khi lấy thông tin người dùng: $e');
  } finally {
    await closeConnection(); // Đóng kết nối sau khi hoàn tất
  }
  return null; // Trả về null nếu không tìm thấy
}
