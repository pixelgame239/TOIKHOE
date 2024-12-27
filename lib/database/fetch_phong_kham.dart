import 'package:toikhoe/database/connection.dart';

Future<List<Map<String, dynamic>>> fetchPhongKham() async {
  try {
    final conn = await connectToRDS();
    if (conn == null) {
      print('Kết nối chưa được khởi tạo.');
      return [];
    }

    final result = await conn.query("SELECT * FROM phong_kham");
    final clinics = result
        .map((row) => {
              'id_phong_kham': row['id_phong_kham'],
              'ten_phong_kham': row['ten_phong_kham'],
              'so_luong_review': row['so_luong_review'],
              'sdt': row['sdt'],
              'email': row['email'],
              'mo_ta': row['mo_ta'],
            })
        .toList();

    // Đóng kết nối sau khi sử dụng
    await conn.close();
    return clinics;
  } catch (e) {
    print('Lỗi khi lấy thông tin phòng khám: $e');
    return [];
  }
}
