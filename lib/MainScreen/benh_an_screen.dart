import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:toikhoe/MainScreen/benh_an_detail_screen.dart';
import 'package:toikhoe/database/insert_benh_an.dart';
import 'package:toikhoe/mainScreen/them_benh_an_screen.dart';

class MedicalRecordsScreen extends StatefulWidget {
  const MedicalRecordsScreen({super.key});

  @override
  _MedicalRecordsScreenState createState() => _MedicalRecordsScreenState();
}

class _MedicalRecordsScreenState extends State<MedicalRecordsScreen> {
  List<Map<String, dynamic>> _medicalRecords = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadMedicalRecords();
  }

  String _formatDate(dynamic date) {
    if (date == null) return 'Không có';
    try {
      if (date is DateTime) {
        return DateFormat('dd/MM/yyyy').format(date);
      }
      final parsedDate = DateTime.parse(date);
      return DateFormat('dd/MM/yyyy').format(parsedDate);
    } catch (e) {
      return 'Sai định dạng';
    }
  }

  Future<void> _loadMedicalRecords() async {
    setState(() {
      _isLoading = true;
    });

    final records = await fetchBenhAn();

    setState(() {
      _medicalRecords = records;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Bệnh án'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _medicalRecords.isEmpty
              ? Center(child: Text('Không có bệnh án nào.'))
              : ListView.builder(
                  itemCount: _medicalRecords.length,
                  itemBuilder: (context, index) {
                    final record = _medicalRecords[index];
                    return Card(
                      child: ListTile(
                        title: Text(record['ten']),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Ngày sinh: ${_formatDate(record['ngay_sinh'])}',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.black87),
                            ),
                            Text(
                              'Giới tính: ${record['gioi_tinh'] ?? 'Không có'}',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.black87),
                            ),
                            Text(
                              'Số thẻ BHYT: ${record['so_the_bhyt'] ?? 'Không có'}',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.black87),
                            ),
                            Text(
                              'Chẩn đoán vào viện: ${record['chan_doan_vao_vien'] ?? 'Chưa có'}',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.black87),
                            ),
                          ],
                        ),
                        onTap: () {
                          // Chuyển đến màn hình chi tiết bệnh án
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  BenhAnDetailScreen(record: record),
                            ),
                          );
                        },
                        trailing: Text(record['tinh_thanh_pho'] ?? ''),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => themBenhAnScreen(),
            ),
          ).then((_) {
            _loadMedicalRecords(); // Reload dữ liệu sau khi thêm bệnh án mới
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
