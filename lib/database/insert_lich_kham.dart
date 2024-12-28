import 'package:intl/intl.dart';
import 'package:toikhoe/database/connection.dart';
import 'package:toikhoe/database/fetch_userID_password.dart';

Future<bool> insertLichKhamBenh(
    DateTime thoiGianDatLich, int userID, String diaChi) async {
  conn = await connectToRDS(); // Khởi tạo kết nối
  if (conn == null) {
    print('Kết nối chưa được khởi tạo.');
    return false; // Trả về false nếu kết nối chưa được thiết lập
  }

  try {
    // Tách `NgayDatLich` và `GioDatLich` từ `thoiGianDatLich`
    String ngayDatLich = DateFormat('yyyy-MM-dd').format(thoiGianDatLich);
    String gioDatLich = DateFormat('HH:mm:ss').format(thoiGianDatLich);

    // Thực hiện truy vấn chèn dữ liệu vào bảng LichKhamBenh
    await conn!.query(
      "INSERT INTO LichKhamBenh (NgayDatLich, GioDatLich, UserID, DiaChi) "
      "VALUES (?, ?, ?, ?)",
      [ngayDatLich, gioDatLich, userID, diaChi],
    );

    print('Thêm lịch khám bệnh thành công cho UserID = $userID');
    await closeConnection(); // Đóng kết nối sau khi thêm thành công
    return true; // Trả về true nếu chèn thành công
  } catch (e) {
    print('Lỗi khi thêm lịch khám bệnh: $e');
    return false; // Trả về false nếu có lỗi
  }
}
