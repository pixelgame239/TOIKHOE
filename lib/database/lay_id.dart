
import 'package:mysql1/mysql1.dart';

Future<String> lay_id() async {
  // Thông tin kết nối
  final settings = ConnectionSettings(
    host:
        'database1.cfwaqesmyz1s.ap-southeast-1.rds.amazonaws.com', // Endpoint RDS
    port: 3306, // Cổng mặc định của MySQL
    user: 'admin', // Tên người dùng
    password: 'mypassword', // Mật khẩu
    db: 'test', // Tên cơ sở dữ liệu
  );

  try {
    // Tạo kết nối
    final conn = await MySqlConnection.connect(settings);
    final result = await conn.query("""

select * from BacSi


""");
    // Duyệt qua kết quả và in trường 'hoTen'
    for (var row in result) {
      print(row['ID']);
    }

    // Ví dụ: Lấy dữ liệu từ bảng
    print('Connected');
    // Đóng kết nối
    await conn.close();
  } catch (e) {
    print('Lỗi kết nối: $e');
  }
  return "";
}