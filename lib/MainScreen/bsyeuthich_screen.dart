import 'package:flutter/material.dart';
import 'package:toikhoe/database/getBsprofile.dart';
import 'package:toikhoe/model/bacsi_model.dart';
import 'bs_info_screen.dart'; // Import màn hình thông tin bác sĩ

class FavoriteDoctorsScreen extends StatefulWidget {
  @override
  _FavoriteDoctorsScreenState createState() => _FavoriteDoctorsScreenState();
}

class _FavoriteDoctorsScreenState extends State<FavoriteDoctorsScreen> {
  List<Map<String, String>> favoriteDoctors = [
    {
      'name': 'Bác sĩ Lê Công Định',
      'title': 'Consultant - Bệnh viện Bạch Mai',
      'rating': '4.2 (78 reviews)',
    },
    {
      'name': 'Bác sĩ Nguyễn Văn A',
      'title': 'Chuyên khoa Nhi - Bệnh viện Nhi Đồng 1',
      'rating': '4.8 (120 reviews)',
    },
    {
      'name': 'Bác sĩ Trần Thị B',
      'title': 'Chuyên khoa Tim mạch - Bệnh viện Tim Hà Nội',
      'rating': '4.5 (98 reviews)',
    },
    {
      'name': 'Bác sĩ Phạm Văn C',
      'title': 'Bác sĩ Nội khoa - Bệnh viện Chợ Rẫy',
      'rating': '4.7 (110 reviews)',
    },
    {
      'name': 'Bác sĩ Hoàng Thị D',
      'title': 'Chuyên khoa Da liễu - Bệnh viện Da liễu Trung ương',
      'rating': '4.3 (85 reviews)',
    },
  ];

  void removeDoctor(int index) {
    setState(() {
      favoriteDoctors.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Bác sĩ yêu thích',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: favoriteDoctors.isEmpty
          ? const Center(
              child: Text(
                'Không có bác sĩ yêu thích nào.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: favoriteDoctors.length,
              itemBuilder: (context, index) {
                final doctor = favoriteDoctors[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Avatar
                        const CircleAvatar(
                          backgroundImage: AssetImage('assets/ZaloLogin.jpg'),
                          radius: 30,
                        ),
                        const SizedBox(width: 12),
                        // Thông tin bác sĩ
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                doctor['name']!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                doctor['title']!,
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey[600]),
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(Icons.star,
                                      color: Colors.orange, size: 16),
                                  const SizedBox(width: 4),
                                  Text(
                                    doctor['rating']!,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            // Nút Xem hồ sơ
                            ElevatedButton.icon(
                              onPressed: () async {
                                List<BacsiProfile> allDoc=[];
                                await profileBS(allDoc);
                                print(allDoc[index].hoten);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DoctorDetailScreen(currDoc: allDoc[index],),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 6),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              label: const Text(
                                'Xem hồ sơ',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            const SizedBox(height: 8),
                            // Icon tim
                            GestureDetector(
                              onTap: () {
                                removeDoctor(index);
                              },
                              child: const Icon(
                                Icons.favorite,
                                color: Colors.red,
                                size: 28,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
