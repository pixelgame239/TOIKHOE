import 'package:flutter/material.dart';

class BacSiDetailScreen extends StatelessWidget {
  final Map<String, dynamic> doctorData;

  const BacSiDetailScreen({super.key, required this.doctorData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(doctorData['name'] ?? 'Thông tin bác sĩ'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/ZaloLogin.jpg'),
              ),
            ),
            const SizedBox(height: 16),
            // Hiển thị tên bác sĩ
            Text(
              'Thông tin bác sĩ',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            buildInfoRow('Tên:', doctorData['name']),
            buildInfoRow('Email:', doctorData['email']),
            buildInfoRow('Số điện thoại:', doctorData['phone_number']),
            buildInfoRow('Địa chỉ:', doctorData['address']),
            buildInfoRow('Tỉnh/Thành phố:', doctorData['province']),
            // buildInfoRow('Vai trò:', doctorData['role']),
            // buildInfoRow('Trạng thái:', doctorData['status']),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            // Hiển thị thông tin bác sĩ (Doctors table)
            Text(
              'Thông tin chuyên môn',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            buildInfoRow('Mã bác sĩ:', doctorData['doctorID']),
            buildInfoRow('Chuyên môn:', doctorData['specialization']),
            buildInfoRow(
                'Kinh nghiệm:',
                doctorData['experience'] != null
                    ? '${doctorData['experience']} năm'
                    : null),
            buildInfoRow('Giờ làm việc:', doctorData['working_hours']),
            buildInfoRow('Địa điểm:', doctorData['location']),
          ],
        ),
      ),
    );
  }

  // Hàm xây dựng hàng thông tin
  Widget buildInfoRow(String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value != null ? value.toString() : 'Chưa cập nhật',
              style: const TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
