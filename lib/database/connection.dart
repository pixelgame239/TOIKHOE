import 'package:mysql1/mysql1.dart';

Future<MySqlConnection?> connectToRDS() async {
  MySqlConnection? conn; // Khai báo biến kết nối, chưa khởi tạo

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
    conn = await MySqlConnection.connect(settings);
    print('Kết nối thành công đến RDS.');

    // Thực hiện truy vấn
    final result = await conn.query("SELECT * FROM BacSi");

    // Duyệt qua kết quả và in trường 'ID'
    for (var row in result) {
      print(row['ID']);
    }
  } catch (e) {
  } finally {
    // Đảm bảo đóng kết nối nếu đã mở
    if (conn != null) {
      await conn.close();
    }
  }

  return conn;
}
