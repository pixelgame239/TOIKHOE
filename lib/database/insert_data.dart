import 'package:toikhoe/database/lay_ID_matKhau.dart';

Future<bool> insertTaiKhoan(int id, String matKhau, String hoTen,
    String ngaySinh, String queQuan, String diaChi, String soDienThoai) async {
  if (conn == null) {
    print('Kết nối chưa được khởi tạo.');
    return false; // Trả về false nếu kết nối chưa được thiết lập
  }

  try {
    // Thực hiện truy vấn chèn dữ liệu vào bảng TaiKhoan
    await conn!.query(
      "INSERT INTO TaiKhoan (ID, matKhau, hoTen, ngaySinh, queQuan, diaChi, soDienThoai) "
      "VALUES (?, ?, ?, ?, ?, ?, ?)",
      [id, matKhau, hoTen, ngaySinh, queQuan, diaChi, soDienThoai],
    );

    print('Thêm tài khoản thành công: ID = $id');
    return true; // Trả về true nếu chèn thành công
  } catch (e) {
    print('Lỗi khi thêm tài khoản: $e');
    return false; // Trả về false nếu có lỗi
  }
}
