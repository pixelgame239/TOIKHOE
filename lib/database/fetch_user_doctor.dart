import 'package:mysql1/mysql1.dart';
import 'package:toikhoe/database/connection.dart';

Future<List<Map<String, dynamic>>> fetchUsersAndDoctors() async {
  // Kết nối đến cơ sở dữ liệu
  final conn = await connectToRDS(); // Sử dụng hàm kết nối đã viết trước đó

  if (conn == null) {
    print('Không thể kết nối đến cơ sở dữ liệu.');
    return [];
  }

  try {
    // Thực hiện truy vấn JOIN giữa bảng Users và Doctors
    final results = await conn.query('''
      SELECT 
        Users.UserID,
        Users.name,
        Users.email,
        Users.phone_number,
        Users.address,
        Users.status,
        Users.role,
        Users.province,
        Doctors.doctorID,
        Doctors.specialization,
        Doctors.experience,
        Doctors.working_hours,
        Doctors.location
      FROM Users
      LEFT JOIN Doctors ON Users.UserID = Doctors.userID
    ''');

    // Chuyển đổi kết quả thành danh sách các map
    List<Map<String, dynamic>> data = results.map((row) {
      return {
        'UserID': row['UserID'],
        'name': row['name'],
        'email': row['email'],
        'phone_number': row['phone_number'],
        'address': row['address'],
        'status': row['status'],
        'role': row['role'],
        'province': row['province'],
        'doctorID': row['doctorID'],
        'specialization': row['specialization'],
        'experience': row['experience'],
        'working_hours': row['working_hours'],
        'location': row['location'],
      };
    }).toList();
    print(data);

    return data;
  } catch (e) {
    print('Lỗi khi lấy dữ liệu: $e');
    return [];
  }

  // finally {
  //   // Đóng kết nối sau khi truy vấn xong
  //   await conn.close();
  //   print('Kết nối đã được đóng.');
  // }
}
