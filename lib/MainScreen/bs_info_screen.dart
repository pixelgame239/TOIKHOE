import 'package:flutter/material.dart';
import 'package:toikhoe/model/bacsi_model.dart';

class DoctorDetailScreen extends StatefulWidget {
  final BacsiProfile currDoc;
  DoctorDetailScreen({Key? key, required this.currDoc}) : super(key: key);

  @override
  State<DoctorDetailScreen> createState() => _DoctorDetailScreenState();
}

class _DoctorDetailScreenState extends State<DoctorDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.black,
            size: 30,
          ),
          onPressed: () {
            // Xử lý khi nhấn nút
            Navigator.pop(context);
          },
        ),
        title: Text(
          widget.currDoc.chuyenmon,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 1,
        actions: const [
          Icon(Icons.favorite_border, color: Colors.red),
          SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Phần thông tin bác sĩ
            buildDoctorInfoSection(),
            const Divider(height: 1, thickness: 1),
            // Phần Tiểu sử
            buildSectionHeader('Tiểu sử'),
            buildSectionContent(
                'Chuyên sâu về các bệnh lý mũi xoang, phẫu thuật nội soi mũi xoang và nền sọ\n'
                    'Chuyên sâu các bệnh lý Tai, Tai thần kinh và phẫu thuật Tai.'),
            const Divider(height: 1, thickness: 1),
            // Phần Địa chỉ công tác
            buildSectionHeader('Địa chỉ công tác'),
            buildSectionContent(
                '78 Đường Giải Phóng, Phương Mai, Đống Đa, Hà Nội'),
            // Bản đồ (placeholder)
            buildMapSection(),
            const Divider(height: 1, thickness: 1),
            // Phần đánh giá
            buildReviewSection(),
          ],
        ),
      ),
      bottomNavigationBar: buildBottomBar(),
    );
  }

  // Thông tin bác sĩ
  Widget buildDoctorInfoSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage('assets/ZaloLogin.jpg'), // Avatar bác sĩ
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bác sĩ ${widget.currDoc.hoten}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.currDoc.chuyenmon,
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 8),
                Row(
                  children: const [
                    Icon(Icons.local_hospital, size: 20, color: Colors.red),
                    SizedBox(width: 4),
                    Text('Bệnh viện Bạch Mai'),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: const [
                    Icon(Icons.access_time, size: 20, color: Colors.blue),
                    SizedBox(width: 4),
                    Text('8:00 a.m - 18:00 p.m'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Tiêu đề Section
  Widget buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
      ),
    );
  }

  // Nội dung Section
  Widget buildSectionContent(String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        content,
        style: const TextStyle(fontSize: 14, color: Colors.black87, height: 1.5),
      ),
    );
  }

  // Bản đồ Section
  Widget buildMapSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey[300],
          image: const DecorationImage(
            image: NetworkImage(
                'https://via.placeholder.com/350x150.png?text=Google+Map'), // Placeholder map image
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  // Phần đánh giá
  Widget buildReviewSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSectionHeader('Đánh giá (78)'),
        buildRatingStars(),
        const Divider(height: 1),
        ...List.generate(3, (index) => buildReviewItem()),
      ],
    );
  }

  // Xếp hạng sao
  Widget buildRatingStars() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: const [
          Icon(Icons.star, color: Colors.amber, size: 20),
          Icon(Icons.star, color: Colors.amber, size: 20),
          Icon(Icons.star, color: Colors.amber, size: 20),
          Icon(Icons.star, color: Colors.amber, size: 20),
          Icon(Icons.star_half, color: Colors.amber, size: 20),
          SizedBox(width: 8),
          Text('4.2', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  // Item đánh giá
  Widget buildReviewItem() {
    return ListTile(
      leading: const CircleAvatar(
        backgroundImage: AssetImage('assets/ZaloLogin.jpg'), // Avatar người đánh giá
      ),
      title: const Text(
        'Duc Quynh Tran',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.star, size: 16, color: Colors.amber),
              Icon(Icons.star, size: 16, color: Colors.amber),
              Icon(Icons.star, size: 16, color: Colors.amber),
              Icon(Icons.star, size: 16, color: Colors.amber),
              Icon(Icons.star, size: 16, color: Colors.amber),
            ],
          ),
          SizedBox(height: 4),
          Text('Bác sĩ rất tuyệt vời. Chân thành cảm ơn những lời tư vấn của bác sĩ!!'),
        ],
      ),
      trailing: const Text('Hôm nay', style: TextStyle(color: Colors.grey)),
    );
  }

  // Bottom Bar
  Widget buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(12),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 12)),
              child: const Text(
                'Đặt lịch hẹn',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(width: 16),
          CircleAvatar(
            backgroundColor: Colors.grey[200],
            child: IconButton(
              icon: const Icon(Icons.chat, color: Colors.blue),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
