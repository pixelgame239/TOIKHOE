import 'package:flutter/material.dart';

class LichUongThuocScreen extends StatefulWidget {
  @override
  State<LichUongThuocScreen> createState() => _LichUongThuocScreenState();
}

class _LichUongThuocScreenState extends State<LichUongThuocScreen> {
  bool repeatDaily = false;
  bool takeWhenHungry = false;
  bool takeWhenFull = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Đặt lịch nhắc uống thuốc',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cụm Tiêu đề
            BorderedSection(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionTitle(title: 'Tiêu đề'),
                  InputField(
                    label: 'Tiêu đề',
                    hintText: 'Tiêu đề',
                  ),
                ],
              ),
            ),

            // Cụm Loại thuốc
            BorderedSection(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionTitle(title: 'Loại thuốc'),
                  InputField(
                    label: 'Tên loại thuốc',
                    hintText: 'Tên loại thuốc',
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Xử lý chọn ảnh
                    },
                    icon: const Icon(Icons.photo_library),
                    label: const Text('Chọn ảnh từ thư viện'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Cụm Thời gian
            BorderedSection(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionTitle(title: 'Thời gian'),
                  InputField(
                    label: 'Ngày đặt lịch uống',
                    hintText: 'Ngày đặt lịch uống',
                  ),
                  InputField(
                    label: 'Thời gian uống',
                    hintText: '00:00',
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CheckboxListTile(
                          value: takeWhenHungry,
                          onChanged: (value) {
                            setState(() {
                              takeWhenHungry = value!;
                            });
                          },
                          title: const Text('Uống trước ăn'),
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      ),
                      Expanded(
                        child: CheckboxListTile(
                          value: takeWhenFull,
                          onChanged: (value) {
                            setState(() {
                              takeWhenFull = value!;
                            });
                          },
                          title: const Text('Uống sau ăn'),
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      ),
                    ],
                  ),
                  InputField(
                    label: 'Số ngày thực hiện',
                    hintText: '0 ngày',
                  ),
                  InputField(
                    label: 'Liều lượng',
                    hintText: 'Ví dụ: 1 viên, 0.5ml',
                  ),
                ],
              ),
            ),

            // Cụm Ghi chú
            BorderedSection(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionTitle(title: 'Ghi chú'),
                  InputField(
                    label: 'Ghi chú',
                    hintText: 'Ví dụ: Dùng sau khi ăn',
                    maxLines: 3,
                  ),
                ],
              ),
            ),

            // Cụm Lặp lại hàng ngày
            BorderedSection(
              child: Row(
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
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
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
      padding: const EdgeInsets.symmetric(vertical: 8.0),
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

class BorderedSection extends StatelessWidget {
  final Widget child;

  const BorderedSection({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: child,
    );
  }
}
