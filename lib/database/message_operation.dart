 import 'package:mysql1/mysql1.dart';
import 'package:toikhoe/database/connection.dart';

Future<List<Map<String, dynamic>>> fetchMessages(int senderId, int receiverId) async {
    try {
      MySqlConnection? conn = await connectToRDS();
      if(conn!=null){
         final results = await conn.query(
        // '''
        // SELECT sender_id, receiver_id, message, timestamp 
        // FROM messages 
        // WHERE (sender_id = ? AND receiver_id = ?) 
        // ORDER BY timestamp ASC
        // ''',
        '''
        SELECT sender_id, receiver_id, message, timestamp 
        FROM messages 
        WHERE (sender_id = ? AND receiver_id = ?) 
           OR (sender_id = ? AND receiver_id = ?)
        ORDER BY timestamp ASC
        ''',
        // [senderId, receiverId],
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
      }
      else{
        return [];
      }
    } catch (e) {
      print('Failed to fetch messages: $e');
      return [];
    }
  }
Future<void> sendMessage(int senderId, int receiverId, String message) async {
    try {
      MySqlConnection? conn = await connectToRDS();
      if(conn!=null){
        await conn.query(
        'INSERT INTO messages (sender_id, receiver_id, message) VALUES (?, ?, ?)',
        [senderId, receiverId, message],
      );
      await conn.close();
      }
    } catch (e) {
      print('Failed to send message: $e');
    }
  }
  Future<List<Map<dynamic, dynamic>>> fetchotherUsers(int userId) async {
    try {
      MySqlConnection? conn = await connectToRDS();
      if(conn!=null){
         final results = await conn.query('SELECT userId, name FROM Users where userID != ?',[userId]);
      final users = results.map((row) {
        return {
          'UserID': row['userId'],
          'name': row['name'].toString(),
        };
      }).toList();
      await conn.close();
      return users;
      }
    else{
      return [];
    }
    } catch (e) {
      print('Error fetching users: $e');
      return [];
    }
  }
