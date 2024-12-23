import 'package:toikhoe/database/fetch_userID_password.dart';

Future<List<Map<String, dynamic>>> fetchAllBacSi() async {
  List<Map<String, dynamic>> doctors = [];
  if (conn == null) {
    print('Kết nối chưa được khởi tạo.');
    return doctors; // Trả về danh sách rỗng
  }

  try {
    // Thực hiện truy vấn để lấy toàn bộ dữ liệu từ bảng BacSi
    final result = await conn!.query("SELECT * FROM BacSi");

    // Lưu trữ dữ liệu từng bản ghi vào danh sách
    for (var row in result) {
      doctors.add(row.fields);
    }

    print('Lấy toàn bộ thông tin bác sĩ thành công: $doctors');
  } catch (e) {
    print('Lỗi khi lấy thông tin bác sĩ: $e');
  }

  return doctors;
}
