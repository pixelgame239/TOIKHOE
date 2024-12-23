import 'package:flutter/material.dart';

class LichDoHuyetApScreen extends StatefulWidget {
  @override
  State<LichDoHuyetApScreen> createState() => _LichDoHuyetApScreenState();
}

class _LichDoHuyetApScreenState extends State<LichDoHuyetApScreen> {
  bool notifyBefore = false;
  bool repeatDaily = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Đặt lịch nhắc đo huyết áp',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
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
                    hintText: 'Nhập tiêu đề',
                  ),
                ],
              ),
            ),

            // Cụm Số lần đo
            BorderedSection(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionTitle(title: 'Số lần đo'),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Số lần đo',
                      hintText: 'Nhập số lần đo',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    items: ['1 lần/ngày', '2 lần/ngày', '3 lần/ngày']
                        .map((value) => DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            ))
                        .toList(),
                    onChanged: (value) {
                      // Xử lý khi chọn số lần đo
                    },
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
                    label: 'Ngày đặt lịch',
                    hintText: 'yyyy/mm/dd',
                  ),
                  InputField(
                    label: 'Ngày bắt đầu',
                    hintText: 'yyyy/mm/dd',
                  ),
                  InputField(
                    label: 'Giờ bắt đầu',
                    hintText: '00:00',
                  ),
                  InputField(
                    label: 'Thời gian cách giữa 2 lần',
                    hintText: 'Nhập thời gian (HH:mm)',
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Báo trước',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
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
                    hintText: 'Ví dụ: Đo huyết áp khi nghỉ ngơi',
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
