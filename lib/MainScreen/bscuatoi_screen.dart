import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'bs_info_screen.dart'; // Import màn hình thông tin bác sĩ

class MyDoctorScreen extends StatefulWidget {
  @override
  State<MyDoctorScreen> createState() => _MyDoctorScreenState();
}

class _MyDoctorScreenState extends State<MyDoctorScreen> {
  final List<Map<String, String>> doctors = List.generate(6, (index) {
    return {
      'name': 'Bác sĩ Lê Công Định',
      'title': 'Consultant - Bệnh viện Bạch Mai',
      'rating': '4.2 (78 reviews)',
      'date': 'Hôm nay',
    };
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Bác sĩ của tôi',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.person, color: Colors.red),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: doctors.length,
        itemBuilder: (context, index) {
          final doctor = doctors[index];
          return Container(
            margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: 8),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 6,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: screenWidth * 0.08,
                  backgroundImage: AssetImage('assets/doctor_avatar.png'),
                ),
                SizedBox(width: screenWidth * 0.03),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        doctor['name']!,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: screenWidth * 0.04),
                      ),
                      SizedBox(height: 4),
                      Text(
                        doctor['title']!,
                        style: TextStyle(color: Colors.grey[600], fontSize: screenWidth * 0.035),
                      ),
                      SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: screenWidth * 0.04),
                          SizedBox(width: 4),
                          Text(
                            doctor['rating']!,
                            style: TextStyle(fontSize: screenWidth * 0.035),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: screenWidth * 0.02),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Điều hướng sang màn hình thông tin bác sĩ khi nhấn nút
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DoctorDetailScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        minimumSize: Size(screenWidth * 0.2, 36),
                      ),
                      child: FittedBox(
                        child: Text(
                          'Xem hồ sơ',
                          style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.03),
                        ),
                      ),
                    ),
                    SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(CupertinoIcons.chat_bubble,
                            color: Colors.grey, size: screenWidth * 0.06),
                        SizedBox(width: 4),
                        Text(
                          doctor['date']!,
                          style: TextStyle(fontSize: screenWidth * 0.03, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
