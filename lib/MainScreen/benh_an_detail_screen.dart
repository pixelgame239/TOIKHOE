import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BenhAnDetailScreen extends StatelessWidget {
  final Map<String, dynamic> record;

  const BenhAnDetailScreen({Key? key, required this.record}) : super(key: key);

  String _formatDate(dynamic date) {
    if (date == null) return 'Không có';
    try {
      if (date is DateTime) {
        return DateFormat('dd/MM/yyyy').format(date);
      }
      final parsedDate = DateTime.parse(date.toString());
      return DateFormat('dd/MM/yyyy').format(parsedDate);
    } catch (e) {
      return 'Sai định dạng';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chi tiết bệnh án'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('Tên bệnh nhân:', record['ten']),
            _buildDetailRow('Dân tộc:', record['dan_toc'] ?? 'Không có'),
            _buildDetailRow('Ngày sinh:', _formatDate(record['ngay_sinh'])),
            _buildDetailRow('Tuổi:', record['tuoi']?.toString() ?? 'Không có'),
            _buildDetailRow('Giới tính:', record['gioi_tinh']),
            _buildDetailRow('Số nhà:', record['so_nha'] ?? 'Không có'),
            _buildDetailRow('Thôn/phố:', record['thon_pho'] ?? 'Không có'),
            _buildDetailRow('Xã/phường:', record['xa_phuong'] ?? 'Không có'),
            _buildDetailRow('Huyện:', record['huyen'] ?? 'Không có'),
            _buildDetailRow(
                'Tỉnh/Thành phố:', record['tinh_thanh_pho'] ?? 'Không có'),
            _buildDetailRow(
                'Số thẻ BHYT:', record['so_the_bhyt'] ?? 'Không có'),
            _buildDetailRow(
                'Ngày nhập viện:', _formatDate(record['ngay_nhap_vien'])),
            _buildDetailRow(
                'Ngày ra viện:', _formatDate(record['ngay_ra_vien'])),
            _buildDetailRow('Chẩn đoán vào viện:',
                record['chan_doan_vao_vien'] ?? 'Không có'),
            _buildDetailRow('Chẩn đoán ra viện:',
                record['chan_doan_ra_vien'] ?? 'Không có'),
            _buildDetailRow(
                'Lý do vào viện:', record['ly_do_vao_vien'] ?? 'Không có'),
            _buildDetailRow('Tóm tắt quá trình bệnh lý:',
                record['tom_tat_qua_trinh_benh_ly'] ?? 'Không có'),
            _buildDetailRow('Ngày tạo:', _formatDate(record['ngay_tao'])),
            _buildDetailRow(
                'Ngày cập nhật:', _formatDate(record['ngay_cap_nhat'])),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(value?.toString() ?? 'Không có'),
          ),
        ],
      ),
    );
  }
}
