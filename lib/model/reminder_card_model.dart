import 'package:flutter/material.dart';

class ReminderCard extends StatelessWidget {
  final String title;
  final String date;
  final String time;
  final String nextTime;
  final IconData icon;
  final bool isActive;

  const ReminderCard({
    Key? key,
    required this.title,
    required this.date,
    required this.time,
    required this.nextTime,
    required this.icon,
    required this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon phần bên trái
          CircleAvatar(
            radius: 24,
            backgroundColor: Colors.green.withOpacity(0.2),
            child: Icon(icon, color: Colors.green, size: 28),
          ),
          SizedBox(width: 12),
          // Thông tin chính
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Thời gian đặt lịch nhắc:',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                    Text(
                      date,
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Thời gian:',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                    Text(
                      time,
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Lịch nhắc sẽ đến sau:',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                    Text(
                      nextTime,
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Divider(height: 20),
                // Trạng thái Toggle
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tạm dừng/Hoạt động',
                      style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                    ),
                    Switch(
                      value: isActive,
                      activeColor: Colors.green,
                      onChanged: (value) {
                        // Xử lý chuyển trạng thái
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Nút tùy chọn (3 chấm dọc)
          SizedBox(width: 4),
          Icon(Icons.more_vert, color: Colors.grey),
        ],
      ),
    );
  }
}
