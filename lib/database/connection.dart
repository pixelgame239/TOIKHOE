import 'package:mysql1/mysql1.dart';
// connect_db.dart
import 'dart:async';

Future<MySqlConnection?> connectToRDS() async {
  MySqlConnection? conn; // Khai báo biến kết nối, chưa khởi tạo

  // Thông tin kết nối
  final settings = ConnectionSettings(
    host:
        'database1.cfwaqesmyz1s.ap-southeast-1.rds.amazonaws.com', // Endpoint RDS
    port: 3306, // Cổng mặc định của MySQL
    user: 'admin', // Tên người dùng
    password: 'mypassword', // Mật khẩu
    db: 'testCody', // Tên cơ sở dữ liệu
  );

  try {
    // Tạo kết nối
    conn = await MySqlConnection.connect(settings);
    print('Kết nối thành công đến RDS.');
  } catch (e) {
    print('Lỗi kết nối hoặc truy vấn: $e');
  }
  return conn;
}



// connect_db.dart

class DatabaseService {
  static Future<MySqlConnection> getConnection() async {
    final settings = ConnectionSettings(
      host: 'database1.cfwaqesmyz1s.ap-southeast-1.rds.amazonaws.com',
      port: 3306,
      user: 'admin',
      password: 'mypassword',
      db: 'testCody',
    );
    return await MySqlConnection.connect(settings);
  }

  static Future<void> sendMessage(String senderId, String receiverId, String message) async {
    try {
      final conn = await getConnection();
      await conn.query(
        'INSERT INTO messages (sender_id, receiver_id, message) VALUES (?, ?, ?)',
        [senderId, receiverId, message],
      );
      await conn.close();
    } catch (e) {
      print('Failed to send message: $e');
    }
  }

  static Future<List<Map<String, dynamic>>> fetchMessages(String senderId, String receiverId) async {
    try {
      final conn = await getConnection();
      final results = await conn.query(
        '''
        SELECT sender_id, receiver_id, message, timestamp 
        FROM messages 
        WHERE (sender_id = ? AND receiver_id = ?) 
           OR (sender_id = ? AND receiver_id = ?)
        ORDER BY timestamp ASC
        ''',
        [senderId, receiverId, receiverId, senderId],
      );

      final messages = results.map((row) {
        return {
          'text': row['message'],
          'isSentByMe': row['sender_id'] == senderId,
          'timestamp': row['timestamp'],
        };
      }).toList();

      await conn.close();
      return messages;
    } catch (e) {
      print('Failed to fetch messages: $e');
      return [];
    }
  }

  static Future<List<Map<String, String>>> fetchotherUsers(int userId) async {
    try {
      final conn = await getConnection();
      final results = await conn.query('SELECT userId, name FROM Users where userID != ?',[userId]);
      final users = results.map((row) {
        return {
          'UserID': row['userId'].toString(),
          'name': row['name'].toString(),
        };
      }).toList();
      await conn.close();
      return users;
    } catch (e) {
      print('Error fetching users: $e');
      return [];
    }
  }

}


