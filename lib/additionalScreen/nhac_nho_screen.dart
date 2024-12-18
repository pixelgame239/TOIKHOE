import 'package:flutter/material.dart';
import 'package:toikhoe/MainScreen/home_Screen.dart';
import 'package:toikhoe/model/reminder_card_model.dart';

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
        title: Text('Lịch nhắc',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 30,
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          },
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: Center(
        child: ReminderCard(
          title: 'Uống thuốc',
          date: '12/12/2024',
          time: '8:00',
          nextTime: '2 giờ 21 phút',
          icon: Icons.medical_services,
          isActive: true,
        ),
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
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blueAccent.withOpacity(0.2),
          child: Icon(icon, color: Colors.blue),
        ),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(
          'Thời gian đặt lịch: $time\nLịch nhắc sẽ diễn ra: $next',
          style: TextStyle(fontSize: 12),
        ),
        trailing: Switch(
          value: isActive,
          onChanged: (value) {},
          activeColor: Colors.green,
        ),
      ),
    );
  }
}
