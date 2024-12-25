import 'package:toikhoe/database/fetch_userID_password.dart';

Future<bool> insertBenhAn(
    String ten,
    int? danTocId, // ID của dân tộc
    DateTime ngaySinh,
    int? tuoi, // Tuổi, nếu cần lưu trữ
    String gioiTinh,
    int?
        soNhaId, // ID cho số nhà (hoặc địa chỉ đầy đủ nếu đã tách bảng địa chỉ)
    String? thonPho, // Thêm thông tin thôn, phố
    String? xaPhuong, // Xã, phường
    String? huyen, // Huyện
    String? tinhThanhPho, // Tỉnh, thành phố
    String? soTheBHYT,
    DateTime? ngayNhapVien,
    DateTime? ngayRaVien,
    String? chanDoanVaoVien,
    String? chanDoanRaVien,
    String? lyDoVaoVien,
    String? tomTatQuaTrinhBenhLy) async {
  if (conn == null) {
    print('Kết nối chưa được khởi tạo.');
    return false; // Trả về false nếu kết nối chưa được thiết lập
  }

  // Kiểm tra dữ liệu bắt buộc
  if (ten.isEmpty || gioiTinh.isEmpty || ngaySinh == null) {
    print('Dữ liệu bắt buộc không hợp lệ.');
    return false;
  }

  try {
    // Thực hiện truy vấn chèn dữ liệu vào bảng BenhAn
    await conn!.query(
      "INSERT INTO BenhAn (ten, dan_toc, ngay_sinh, tuoi, gioi_tinh, so_nha, thon_pho, xa_phuong, huyen, tinh_thanh_pho, so_the_bhyt, "
      "ngay_nhap_vien, ngay_ra_vien, chan_doan_vao_vien, chan_doan_ra_vien, "
      "ly_do_vao_vien, tom_tat_qua_trinh_benh_ly) "
      "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
      [
        ten,
        danTocId,
        ngaySinh.toIso8601String(),
        tuoi,
        gioiTinh,
        soNhaId,
        thonPho,
        xaPhuong,
        huyen,
        tinhThanhPho,
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

Future<List<Map<String, dynamic>>> fetchBenhAn() async {
  List<Map<String, dynamic>> records = [];
  if (conn == null) {
    print('Kết nối chưa được khởi tạo.');
    return records; // Trả về danh sách rỗng
  }

  try {
    // Thực hiện truy vấn để lấy toàn bộ dữ liệu từ bảng BenhAn
    final result = await conn!.query("SELECT * FROM BenhAn");

    // Lưu trữ dữ liệu từng bản ghi vào danh sách
    for (var row in result) {
      records.add(row.fields);
    }

    print('Lấy toàn bộ thông tin bệnh án thành công: $records');
  } catch (e) {
    print('Lỗi khi lấy thông tin bệnh án: $e');
  }

  return records;
}
