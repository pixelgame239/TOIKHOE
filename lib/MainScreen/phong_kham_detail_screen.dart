import 'package:flutter/material.dart';

class phongKhamDetailScreen extends StatelessWidget {
  final String name;
  final String reviews;
  final String phone;
  final String email;
  final String? description;

  phongKhamDetailScreen({
    required this.name,
    required this.reviews,
    required this.phone,
    required this.email,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chi tiết phòng khám"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
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
            // Hình ảnh
            Center(
              child: Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage('https://via.placeholder.com/400'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),

            // Tên phòng khám
            Text(
              name,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),

            // Số lượng review
            Row(
              children: [
                Icon(Icons.star, color: Colors.orange, size: 16),
                SizedBox(width: 5),
                Text("$reviews Google reviews"),
              ],
            ),
            SizedBox(height: 16),

            // Số điện thoại
            Row(
              children: [
                Icon(Icons.phone, size: 20),
                SizedBox(width: 10),
                Text(phone, style: TextStyle(fontSize: 16)),
              ],
            ),
            SizedBox(height: 8),

            // Email
            Row(
              children: [
                Icon(Icons.email, size: 20),
                SizedBox(width: 10),
                Text(email, style: TextStyle(fontSize: 16)),
              ],
            ),
            SizedBox(height: 16),

            // Mô tả
            Text(
              "Mô tả:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              description ?? "Không có mô tả",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
