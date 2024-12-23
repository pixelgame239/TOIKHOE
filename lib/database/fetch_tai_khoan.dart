import 'package:toikhoe/database/connection.dart'; // Đảm bảo import file quản lý kết nối cơ sở dữ liệu

Future<List<Map<String, dynamic>>> fetchAllTaiKhoan() async {
  List<Map<String, dynamic>> accounts = [];
  final conn = await connectToRDS(); // Gọi hàm khởi tạo kết nối

  if (conn == null) {
    print('Kết nối chưa được khởi tạo.');
    return accounts; // Trả về danh sách rỗng
  }

  try {
    // Thực hiện truy vấn để lấy toàn bộ dữ liệu từ bảng Users
    final result = await conn.query("SELECT * FROM Users");

    // Lưu trữ dữ liệu từng bản ghi vào danh sách
    for (var row in result) {
      accounts.add(row.fields);
    }

    print(
        'Lấy toàn bộ thông tin tài khoản thành công: ${accounts.length} tài khoản.');
  } catch (e) {
    print('Lỗi khi lấy thông tin tài khoản: $e');
  } finally {
    await conn.close(); // Đóng kết nối sau khi sử dụng
  }

  return accounts;
}
