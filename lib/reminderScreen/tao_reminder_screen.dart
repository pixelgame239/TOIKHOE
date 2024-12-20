import 'package:flutter/material.dart';
import 'lich_do_duong_huyet_screen.dart';
import 'lich_do_huyet_ap_Screen.dart';
import 'lich_kham_screen.dart';
import 'lich_tap_the_duc_screen.dart';
import 'lich_uong_nuoc_screen.dart';
import 'lich_uong_thuoc_screen.dart';

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
                    SectionTitle(title: "Sức khỏe"),
                    ReminderItem(
                      icon: Icons.calendar_today,
                      color: Colors.blue,
                      text: "Đặt lịch nhắc khám",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LichKhamScreen()),
                        );
                      },
                    ),
                    ReminderItem(
                      icon: Icons.medication,
                      color: Colors.green,
                      text: "Đặt lịch nhắc uống thuốc",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LichUongThuocScreen()),
                        );
                      },
                    ),
                    ReminderItem(
                      icon: Icons.favorite,
                      color: Colors.red,
                      text: "Đặt lịch đo huyết áp",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LichDoHuyetApScreen()),
                        );
                      },
                    ),
                    ReminderItem(
                      icon: Icons.directions_run,
                      color: Colors.purple,
                      text: "Đặt lịch tập thể dục",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ExerciseReminderScreen()),
                        );
                      },
                    ),
                    ReminderItem(
                      icon: Icons.monitor_heart,
                      color: Colors.cyan,
                      text: "Đặt lịch đo đường huyết",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LichDoDuongHuyetScreen()),
                        );
                      },
                    ),

                    SectionTitle(title: "Dinh dưỡng"),
                    ReminderItem(
                      icon: Icons.water_drop,
                      color: Colors.blueAccent,
                      text: "Đặt lịch uống nước",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LichUongNuocScreen()),
                        );
                      },
                    ),
                    ReminderItem(
                      icon: Icons.restaurant,
                      color: Colors.orange,
                      text: "Đặt lịch ăn uống",
                      onTap: () => _navigateTo(context, "Đặt lịch ăn uống"),
                    ),

                    SectionTitle(title: "Cơ thể"),
                    ReminderItem(
                      icon: Icons.calendar_month,
                      color: Colors.pink,
                      text: "Đặt lịch nhắc chu kỳ",
                      onTap: () => _navigateTo(context, "Đặt lịch nhắc chu kỳ"),
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

  void _navigateTo(BuildContext context, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 1,
            centerTitle: true,
            iconTheme: const IconThemeData(color: Colors.black),
            title: Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
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
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }
}

class ReminderItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String text;
  final VoidCallback onTap;

  const ReminderItem({
    required this.icon,
    required this.color,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
              backgroundColor: color.withOpacity(0.2),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
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
