import 'package:flutter/material.dart';

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
      favoriteDoctors.removeAt(index); // Xóa bác sĩ tại vị trí index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Bác sĩ yêu thích',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite, color: Colors.red),
            onPressed: () {},
          ),
        ],
      ),
      body: favoriteDoctors.isEmpty
          ? Center(child: Text('Không có bác sĩ yêu thích nào.'))
          : ListView.builder(
        itemCount: favoriteDoctors.length,
        itemBuilder: (context, index) {
          final doctor = favoriteDoctors[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage:
                    AssetImage('assets/ZaloLogin.jpg'), // Thay ảnh phù hợp
                    radius: 20,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          doctor['name']!,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        SizedBox(height: 4),
                        Text(
                          doctor['title']!,
                          style: TextStyle(
                              fontSize: 14, color: Colors.grey[600]),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: Icon(Icons.star,
                                  color: Colors.amber, size: 16),
                            ),
                            SizedBox(width: 4),
                            Text(doctor['rating']!,
                                 overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                                ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            minimumSize: Size(40, 18),
                          ),
                          child: Text(
                            'Xem hồ sơ',
                            style:
                            TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                        SizedBox(height: 8),
                        IconButton(
                          icon: Icon(Icons.favorite, color: Colors.red),
                          onPressed: () {
                            removeDoctor(index); // Xóa bác sĩ khỏi danh sách
                          },
                        ),
                      ],
                    ),
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
