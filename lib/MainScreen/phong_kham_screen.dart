import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toikhoe/MainScreen/phong_kham_detail_screen.dart';
import 'package:toikhoe/database/fetch_phong_kham.dart';

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
              onChanged: (value) {
                // Thêm logic tìm kiếm tại đây
              },
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
                _buildCategoryButton("Tai mũi họng", false),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: fetchPhongKham(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Lỗi: ${snapshot.error}"));
                } else if (snapshot.hasData) {
                  final clinics = snapshot.data!;
                  return ListView.builder(
                    itemCount: clinics.length,
                    itemBuilder: (context, index) {
                      final clinic = clinics[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClinicCard(
                          name: clinic['ten_phong_kham'],
                          reviews: clinic['so_luong_review'].toString(),
                          phone: clinic['sdt'],
                          email: clinic['email'],
                          description: clinic['mo_ta'],
                        ),
                      );
                    },
                  );
                } else {
                  return Center(child: Text("Không có dữ liệu."));
                }
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
  final String name;
  final String reviews;
  final String phone;
  final String email;
  final String? description;

  ClinicCard({
    required this.name,
    required this.reviews,
    required this.phone,
    required this.email,
    this.description,
  });

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
                      Expanded(
                        child: Text(
                          name,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.orange, size: 16),
                      SizedBox(width: 5),
                      Text(" ${reviews} Google review"),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.phone, size: 14),
                      SizedBox(width: 5),
                      Text(phone),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.email, size: 14),
                      SizedBox(width: 5),
                      Text(email),
                    ],
                  ),
                  SizedBox(height: 5),
                  Text(
                    description ?? "Không có mô tả",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => phongKhamDetailScreen(
                              name: name,
                              reviews: reviews,
                              phone: phone,
                              email: email,
                              description: description,
                            ),
                          ),
                        );
                      },
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
