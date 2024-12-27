import 'package:mysql1/mysql1.dart';
import 'package:toikhoe/database/connection.dart';
import 'package:toikhoe/database/fetch_userID_password.dart';

Future<List<Map<String, dynamic>>> fetchUsersAndDoctors() async {
  final conn = await connectToRDS();

  if (conn == null) {
    print('Không thể kết nối đến cơ sở dữ liệu.');
    return [];
  }

  try {
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
        Doctors.location,
        Doctors.isFavourited
      FROM Users
      LEFT JOIN Doctors ON Users.UserID = Doctors.userID
    ''');

    return results.map((row) {
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
        'isFavourited': row['isFavourited'],
      };
    }).toList();
  } catch (e) {
    print('Lỗi khi lấy dữ liệu: $e');
    return [];
  } finally {
    await conn.close();
    print('Kết nối đã được đóng.');
  }
}

Future<List<Map<String, dynamic>>> fetchFavouriteDoctors() async {
  final conn = await connectToRDS();

  if (conn == null) {
    print('Không thể kết nối đến cơ sở dữ liệu.');
    return [];
  }

  try {
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
        Doctors.location,
        Doctors.isFavourited
      FROM Users
      LEFT JOIN Doctors ON Users.UserID = Doctors.userID
      WHERE Doctors.isFavourited = 1
    ''');

    return results.map((row) {
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
        'isFavourited': row['isFavourited'],
      };
    }).toList();
  } catch (e) {
    print('Lỗi khi lấy dữ liệu: $e');
    return [];
  } finally {
    await conn.close();
    print('Kết nối đã được đóng.');
  }
}

Future<List<Map<String, dynamic>>> fetchDoctors() async {
  final conn = await connectToRDS();

  if (conn == null) {
    print('Không thể kết nối đến cơ sở dữ liệu.');
    return [];
  }

  try {
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
        Doctors.location,
        Doctors.isFavourited
      FROM Users
      LEFT JOIN Doctors ON Users.UserID = Doctors.userID
      WHERE Users.role = 'Doctor'
    ''');

    return results.map((row) {
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
        'isFavourited': row['isFavourited'],
      };
    }).toList();
  } catch (e) {
    print('Lỗi khi lấy dữ liệu: $e');
    return [];
  } finally {
    await closeConnection();
    print('Kết nối đã được đóng.');
  }
}
