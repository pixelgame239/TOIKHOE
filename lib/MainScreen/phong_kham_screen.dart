import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ClinicScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Phòng khám"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Nhập để tìm kiếm...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildCategoryButton("Gần đây", true),
                _buildCategoryButton("Răng hàm mặt", false),
                _buildCategoryButton("Siêu âm", false),
                _buildCategoryButton("Khoa nhi", false),
                _buildCategoryButton("Tài mũi họng", false),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return ClinicCard();
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang chủ'),
          BottomNavigationBarItem(icon: Icon(Icons.person_3), label: 'Bác sĩ'),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.calendar_badge_plus),
              label: 'Đặt lịch khám'),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Tin nhắn'),
          BottomNavigationBarItem(icon: Icon(Icons.shopify), label: 'Sàn TMĐT'),
        ],
      ),
    );
  }

  Widget _buildCategoryButton(String text, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? Colors.red : Colors.grey[300],
          foregroundColor: isSelected ? Colors.white : Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(text),
      ),
    );
  }
}

class ClinicCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage('https://via.placeholder.com/150'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "CODY HEALTH",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Icon(Icons.star, color: Colors.orange, size: 16),
                      Text(" 4.3"),
                    ],
                  ),
                  Text("2.859 Google review"),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(Icons.phone, size: 14),
                      SizedBox(width: 5),
                      Text("+84 012345678"),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.email, size: 14),
                      SizedBox(width: 5),
                      Text("Contact@medlife.com"),
                    ],
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Phòng khám Y học Cổ Truyền\nChăm sóc và chữa bệnh hiệu quả",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text("Xem chi tiết"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}