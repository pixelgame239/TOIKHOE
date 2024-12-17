import 'package:flutter/material.dart';
import 'package:toikhoe/mainScreen/bsck_Screen.dart';

class ToiKhoeHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToiKhoe Home',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.account_circle, color: Colors.white),
          onPressed: () {},
        ),
        title: Text(
          'Chào mừng\n ABC XYZ',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.notifications, color: Colors.white),
              onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // GridView for Top Menu Options
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              height: 200,
              child: GridView.count(
                crossAxisCount: 4,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                children: [
                  HomeMenuItem('Bác sĩ chuyên khoa', Icons.local_hospital,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BacsickScreen(),
                        ),
                      );
                    },
                  ),
                  HomeMenuItem('Bác sĩ yêu thích', Icons.favorite),
                  HomeMenuItem('Bác sĩ của tôi', Icons.person),
                  HomeMenuItem('Lịch nhắc', Icons.calendar_today),
                  HomeMenuItem('Phòng khám', Icons.meeting_room),
                  HomeMenuItem('Hỏi bác sĩ', Icons.chat),
                  HomeMenuItem('Dịch vụ tại nhà', Icons.home),
                  HomeMenuItem('Xem thêm', Icons.more_horiz),
                ],
              ),
            ),

            // Health News Section
            SectionHeader(title: 'Tin tức sức khỏe mới nhất'),
            HealthNewsCard(
              title: 'Khỏe đẹp',
              description: '60 giây sống khỏe mỗi ngày - Bạn đã sẵn sàng?',
            ),
            HealthNewsCard(
              title: 'Bí quyết sống khỏe',
              description: '9 lợi ích từ việc chạy bộ',
            ),

            // Doctor Q&A Section
            SectionHeader(title: 'Hỏi đáp với bác sĩ'),
            QnACard(
                title: 'Da liễu',
                content:
                'Chào bác sĩ, em đi khám da liễu cách đây 2 tuần ...',
                doctor: 'BS. Nguyễn Ngọc Anh'),
            QnACard(
                title: 'Sản Phụ Khoa',
                content:
                'Chào bác sĩ em hỏi ... em canh ngày rụng trứng ...',
                doctor: 'BS. Phạm Nhật Vượng'),
            QnACard(
                title: 'Nội khoa',
                content: 'Cháu năm nay 18 tuổi ... xin bác sĩ tư vấn ...',
                doctor: 'BS. Nguyễn Ngọc Anh'),

            // Health Check Section
            SectionHeader(title: 'Kiểm tra sức khỏe'),
            HealthCheckCard(
              title: 'Khám sức khỏe toàn diện dành cho mọi người',
              price: '1.490.000đ',
              buttonText: 'Xem ngay',
            ),

            // Medical Record Section
            SectionHeader(title: 'Bệnh án'),
            MedicalRecordCard(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: 2,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Bác sĩ'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang chủ'),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Tin nhắn'),
          BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'Tiện ích'),
        ],
      ),
    );
  } //BuildContext
} // HomeScreen

// Custom Widgets

class HomeMenuItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;

  HomeMenuItem(this.title, this.icon, {this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 35, color: Colors.blue),
          SizedBox(height: 5),
          Text(title,
              textAlign: TextAlign.center, style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
} // HomeMenuItem

class SectionHeader extends StatelessWidget {
  final String title;

  SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
      ),
    );
  }
} //SectionHeader

class HealthNewsCard extends StatelessWidget {
  final String title;
  final String description;

  HealthNewsCard({required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 50,
        height: 50,
        color: Colors.grey[300],
      ),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(description),
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
    );
  }
} //HealthNewCard

class QnACard extends StatelessWidget {
  final String title;
  final String content;
  final String doctor;

  QnACard({required this.title, required this.content, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: ListTile(
        title: Text(title,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.blueAccent)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5),
            Text(content, maxLines: 2, overflow: TextOverflow.ellipsis),
            SizedBox(height: 5),
            Text('Đã được trả lời bởi $doctor',
                style: TextStyle(color: Colors.green)),
          ],
        ),
      ),
    );
  }
} //QnACard

class HealthCheckCard extends StatelessWidget {
  final String title;
  final String price;
  final String buttonText;

  HealthCheckCard(
      {required this.title, required this.price, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListTile(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(price, style: TextStyle(color: Colors.red)),
        trailing: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          child: Text(buttonText),
        ),
      ),
    );
  }
} //HealthCheckCard

class MedicalRecordCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text('Phiên khám & Chẩn đoán',
                style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('Xem chi tiết bệnh án'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
    );
  }
} //MedicalRecordCard

