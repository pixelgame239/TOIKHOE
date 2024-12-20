import 'package:flutter/material.dart';

class LichKhamScreen extends StatefulWidget {
  @override
  State<LichKhamScreen> createState() =>
      _LichKhamScreenState();
}

class _LichKhamScreenState
    extends State<LichKhamScreen> {
  bool notifyBefore = false;
  bool repeatDaily = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Đặt lịch nhắc khám',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context); // Trở về giao diện trước
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tiêu đề
            SectionTitle(title: 'Tiêu đề'),
            InputField(
              label: 'Tiêu đề',
              hintText: 'Tiêu đề',
            ),

            // Bác sĩ
            SectionTitle(title: 'Bác sĩ'),
            InputField(
              label: 'Họ và tên bác sĩ',
              hintText: 'Họ và tên bác sĩ',
            ),
            InputField(
              label: 'Khoa làm việc',
              hintText: 'Khoa làm việc của bác sĩ',
            ),

            // Thời gian
            SectionTitle(title: 'Thời gian'),
            InputField(
              label: 'Ngày đặt lịch khám',
              hintText: 'Ngày đặt lịch khám',
            ),
            InputField(
              label: 'Giờ khám',
              hintText: 'Giờ khám',
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Báo trước',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Switch(
                  value: notifyBefore,
                  onChanged: (value) {
                    setState(() {
                      notifyBefore = value;
                    });
                  },
                  activeColor: Colors.green,
                ),
              ],
            ),

            // Địa chỉ khám
            SectionTitle(title: 'Địa chỉ khám'),
            InputField(
              label: 'Địa chỉ khám bệnh',
              hintText: 'Địa chỉ khám bệnh',
            ),

            // Ghi chú
            SectionTitle(title: 'Ghi chú'),
            InputField(
              label: 'Ghi chú',
              hintText: 'Những điều chú ý (Tối đa 500 ký tự)',
              maxLines: 3,
            ),

            // Lặp lại hàng ngày
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Lặp lại hàng ngày',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Switch(
                  value: repeatDaily,
                  onChanged: (value) {
                    setState(() {
                      repeatDaily = value;
                    });
                  },
                  activeColor: Colors.green,
                ),
              ],
            ),

            // Nút hành động
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: const BorderSide(color: Colors.grey),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Hủy',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Xử lý tạo lịch nhắc
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Tạo lịch nhắc',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }
}

class InputField extends StatelessWidget {
  final String label;
  final String hintText;
  final int maxLines;

  const InputField({
    required this.label,
    required this.hintText,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
