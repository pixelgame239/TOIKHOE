import 'package:flutter/material.dart';

class AddReminderScreen extends StatefulWidget {
  @override
  State<AddReminderScreen> createState() => _AddReminderScreenState();
}

class _AddReminderScreenState extends State<AddReminderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Tạo lịch nhắc',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section: Sức khỏe
                    SectionTitle(title: "Sức khỏe"),
                    ReminderItem(
                      icon: Icons.calendar_today,
                      color: Colors.blue,
                      text: "Đặt lịch nhắc khám",
                    ),
                    ReminderItem(
                      icon: Icons.medication,
                      color: Colors.green,
                      text: "Đặt lịch nhắc uống thuốc",
                    ),
                    ReminderItem(
                      icon: Icons.favorite,
                      color: Colors.red,
                      text: "Đặt lịch đo huyết áp",
                    ),
                    ReminderItem(
                      icon: Icons.directions_run,
                      color: Colors.purple,
                      text: "Đặt lịch tập thể dục",
                    ),
                    ReminderItem(
                      icon: Icons.monitor_heart,
                      color: Colors.cyan,
                      text: "Đặt lịch đo đường huyết",
                    ),

                    // Section: Dinh dưỡng
                    SectionTitle(title: "Dinh dưỡng"),
                    ReminderItem(
                      icon: Icons.water_drop,
                      color: Colors.blueAccent,
                      text: "Đặt lịch ống nước",
                    ),
                    ReminderItem(
                      icon: Icons.restaurant,
                      color: Colors.orange,
                      text: "Đặt lịch ăn uống",
                    ),

                    // Section: Cơ thể
                    SectionTitle(title: "Cơ thể"),
                    ReminderItem(
                      icon: Icons.calendar_month,
                      color: Colors.pink,
                      text: "Đặt lịch nhắc chu kỳ",
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class SectionTitle extends StatefulWidget {
  final String title;

  SectionTitle({required this.title});

  @override
  State<SectionTitle> createState() => _SectionTitleState();
}

class _SectionTitleState extends State<SectionTitle> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        widget.title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }
}

class ReminderItem extends StatefulWidget {
  final IconData icon;
  final Color color;
  final String text;

  ReminderItem({required this.icon, required this.color, required this.text});

  @override
  State<ReminderItem> createState() => _ReminderItemState();
}

class _ReminderItemState extends State<ReminderItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Xử lý khi nhấn vào mục
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: widget.color.withOpacity(0.2),
              child: Icon(widget.icon, color: widget.color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                widget.text,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
