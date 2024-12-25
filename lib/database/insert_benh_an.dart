import 'package:toikhoe/database/fetch_userID_password.dart';

Future<bool> insertBenhAn(
    String ten,
    int danTocId, // Thay đổi thành ID của dân tộc
    DateTime ngaySinh,
    String gioiTinh,
    int diaChiId, // Thay đổi thành ID của địa chỉ
    String soTheBHYT,
    DateTime? ngayNhapVien,
    DateTime? ngayRaVien,
    String chanDoanVaoVien,
    String chanDoanRaVien,
    String lyDoVaoVien,
    String tomTatQuaTrinhBenhLy) async {
  if (conn == null) {
    print('Kết nối chưa được khởi tạo.');
    return false; // Trả về false nếu kết nối chưa được thiết lập
  }

  // Kiểm tra dữ liệu đầu vào
  if (ten.isEmpty || ngaySinh == null || gioiTinh.isEmpty) {
    print('Dữ liệu bắt buộc không hợp lệ.');
    return false;
  }

  try {
    // Thực hiện truy vấn chèn dữ liệu vào bảng BenhAn
    await conn!.query(
      "INSERT INTO BenhAn (ten, dan_toc_id, ngay_sinh, gioi_tinh, dia_chi_id, so_the_bhyt, "
      "ngay_nhap_vien, ngay_ra_vien, chan_doan_vao_vien, chan_doan_ra_vien, "
      "ly_do_vao_vien, tom_tat_qua_trinh_benh_ly) "
      "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
      [
        ten,
        danTocId,
        ngaySinh.toIso8601String(),
        gioiTinh,
        diaChiId,
        soTheBHYT,
        ngayNhapVien?.toIso8601String(),
        ngayRaVien?.toIso8601String(),
        chanDoanVaoVien,
        chanDoanRaVien,
        lyDoVaoVien,
        tomTatQuaTrinhBenhLy,
      ],
    );

    print('Thêm bệnh án thành công: tên bệnh nhân = $ten');
    return true; // Trả về true nếu chèn thành công
  } catch (e) {
    print('Lỗi khi thêm bệnh án: $e'); // Log lỗi
    return false; // Trả về false nếu có lỗi
  }
}
