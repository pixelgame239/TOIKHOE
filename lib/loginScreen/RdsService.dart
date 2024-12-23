import 'package:mysql1/mysql1.dart';

class RdsService {
  Future<MySqlConnection?> connectToRDS() async {
    MySqlConnection? conn;

    final settings = ConnectionSettings(
      host: 'database1.cfwaqesmyz1s.ap-southeast-1.rds.amazonaws.com', // Endpoint RDS
      port: 3306, // Cổng MySQL mặc định
      user: 'admin', // Tên người dùng
      password: 'mypassword', // Mật khẩu
      db: 'testCody', // Tên cơ sở dữ liệu
    );

    try {
      conn = await MySqlConnection.connect(settings);
      print('Kết nối thành công đến RDS.');
    } catch (e) {
      print('Lỗi kết nối hoặc truy vấn: $e');
    }
    return conn;
  }

  Future<void> registerUser(
      String name, String email, String phone, String address, String province, String role, String password) async {
    final conn = await connectToRDS(); // Kết nối tới RDS
    if (conn != null) {
      try {
        // Thực hiện câu lệnh INSERT vào bảng Users
        await conn.query(
          'INSERT INTO Users (name, email, phone_number, address, status, role, province, password) VALUES (?, ?, ?, ?, ?, ?, ?, ?)',
          [name, email, phone, address, 'active', role, province, password],
        );
        print('Dữ liệu đã được lưu vào cơ sở dữ liệu!');
      } catch (e) {
        print('Lỗi khi lưu dữ liệu: $e');
      } finally {
        await conn.close(); // Đóng kết nối sau khi hoàn tất
      }
    }
  }
}
