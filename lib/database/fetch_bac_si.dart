import 'package:toikhoe/database/connection.dart';
import 'package:toikhoe/database/fetch_userID_password.dart';

Future<List<Map<String, dynamic>>> fetchAllDoctors() async {
  try {
    final conn = await connectToRDS();
    if (conn == null) {
      print('Kết nối chưa được khởi tạo.');
      return [];
    }

    final result = await conn.query("SELECT * FROM Doctors");
    return result
        .map((row) => {
              'doctorID': row['doctorID'],
              'userID': row['userID'],
              'specialization': row['specialization'],
              'experience': row['experience'],
              'working_hours': row['working_hours'],
              'location': row['location'],
              'isFavourited': row['isFavourited'],
            })
        .toList();
  } catch (e) {
    print('Lỗi khi lấy thông tin bác sĩ: $e');
    return [];
  }
}
