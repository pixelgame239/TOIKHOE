import 'package:flutter/material.dart';
import 'package:toikhoe/reminderScreen/tao_reminder_screen.dart';

class ReminderApp extends StatefulWidget {
  @override
  State<ReminderApp> createState() => _ReminderAppState();
}

class _ReminderAppState extends State<ReminderApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Roboto'),
      debugShowCheckedModeBanner: false,
      home: ReminderScreen(),
    );
  }
}

class ReminderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lịch nhắc',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 24,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          // Danh sách lịch nhắc
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              children: [
                ReminderItem(
                  title: 'Uống thuốc',
                  time: '8:00',
                  next: '2 giờ 21 phút',
                  icon: Icons.medical_services,
                  isActive: true,
                ),
                ReminderItem(
                  title: 'Khám sức khỏe',
                  time: '9:00',
                  next: '1 giờ 15 phút',
                  icon: Icons.calendar_today,
                  isActive: false,
                ),
                ReminderItem(
                  title: 'Uống nước',
                  time: '10:00',
                  next: '3 giờ 45 phút',
                  icon: Icons.water_drop,
                  isActive: true,
                ),
                ReminderItem(
                  title: 'Đo huyết áp',
                  time: '11:00',
                  next: '4 giờ 10 phút',
                  icon: Icons.monitor_heart,
                  isActive: true,
                ),
                ReminderItem(
                  title: 'Chạy bộ',
                  time: '6:00',
                  next: '5 giờ 00 phút',
                  icon: Icons.directions_run,
                  isActive: false,
                ),
              ],
            ),
          ),
          // Nút Tạo lịch nhắc
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddReminderScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 14),
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
          ),
        ],
      ),
    );
  }
}

class ReminderItem extends StatelessWidget {
  final String title;
  final String time;
  final String next;
  final IconData icon;
  final bool isActive;

  const ReminderItem({
    required this.title,
    required this.time,
    required this.next,
    required this.icon,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blueAccent.withOpacity(0.2),
          child: Icon(icon, color: Colors.blue),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(
          'Thời gian đặt lịch: $time\nLịch nhắc sẽ diễn ra: $next',
          style: const TextStyle(fontSize: 12),
        ),
        trailing: Switch(
          value: isActive,
          onChanged: (value) {
            // Xử lý bật/tắt
          },
          activeColor: Colors.green,
        ),
      ),
    );
  }
}

