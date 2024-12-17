import 'package:flutter/material.dart';

class BacsickScreen extends StatefulWidget {
  @override
  _BacsickScreenState createState() => _BacsickScreenState();
}

class _BacsickScreenState extends State<BacsickScreen> {
  // Danh sách chuyên khoa
  final List<Chuyenkhoa> chuyenkhoaList = [
    Chuyenkhoa(ten: 'Nội khoa', icon: Icons.local_hospital),
    Chuyenkhoa(ten: 'Da liễu', icon: Icons.spa),
    Chuyenkhoa(ten: 'Tiêu hóa', icon: Icons.local_hospital),
    Chuyenkhoa(ten: 'Nhi', icon: Icons.child_care),
    Chuyenkhoa(ten: 'Dinh dưỡng', icon: Icons.restaurant),
    Chuyenkhoa(ten: 'Dinh dưỡng', icon: Icons.restaurant),
    Chuyenkhoa(ten: 'Dinh dưỡng', icon: Icons.restaurant),
  ];

  // Danh sách bác sĩ (tách riêng)
  final List<Bacsi> bacsiList = [
    Bacsi(
      ten: 'BS. Trần Phú Thịnh',
      chuyenKhoa: 'Nội khoa',
      benhVien: 'Bệnh viện bình dân Hồ Chí Minh',
      danhGia: 4.8,
    ),
    Bacsi(
      ten: 'BS. Trần Phú Thịnh',
      chuyenKhoa: 'Nội khoa',
      benhVien: 'Bệnh viện bình dân Hồ Chí Minh',
      danhGia: 4.8,
    ),
    Bacsi(
      ten: 'BS. Trần Phú Thịnh',
      chuyenKhoa: 'Nội khoa',
      benhVien: 'Bệnh viện bình dân Hồ Chí Minh',
      danhGia: 4.8,
    ),
    Bacsi(
      ten: 'BS. Trần Phú Thịnh',
      chuyenKhoa: 'Nội khoa',
      benhVien: 'Bệnh viện bình dân Hồ Chí Minh',
      danhGia: 4.8,
    ),
    Bacsi(
      ten: 'Bs Vũ Khương An',
      chuyenKhoa: 'Nội khoa',
      benhVien: 'Bệnh viện bình dân Hồ Chí Minh',
      danhGia: 4.8,
    ),
    Bacsi(
      ten: 'Bs Ngô Ngọc Bình',
      chuyenKhoa: 'Da liễu',
      benhVien: 'Bệnh viện K',
      danhGia: 4.8,
    ),
    Bacsi(
      ten: 'Ths. Bs. Hà Vũ Thanh',
      chuyenKhoa: 'Da liễu',
      benhVien: 'Bệnh viện K',
      danhGia: 4.8,
    ),
    Bacsi(
      ten: 'BS. Trần Phú Thịnh',
      chuyenKhoa: 'Tiêu hóa',
      benhVien: 'Bệnh viện bình dân Hồ Chí Minh',
      danhGia: 4.8,
    ),
    Bacsi(
      ten: 'Bs Vũ Khương An',
      chuyenKhoa: 'Tiêu hóa',
      benhVien: 'Bệnh viện bình dân Hồ Chí Minh',
      danhGia: 4.8,
    ),
    Bacsi(
      ten: 'Hoàng Anh',
      chuyenKhoa: 'Nhi',
      benhVien: 'Bệnh viện K',
      danhGia: 4.8,
    ),
    Bacsi(
      ten: 'Hoàng Anh',
      chuyenKhoa: 'Dinh dưỡng',
      benhVien: 'Bệnh viện K',
      danhGia: 4.8,
    ),
  ];

  List<Bacsi> currentBacsiList = []; // Danh sách bác sĩ hiện tại

  @override
  void initState() {
    super.initState();
    // Hiển thị tất cả bác sĩ ban đầu
    currentBacsiList = List.from(bacsiList);
  }

  void filterBacsiByChuyenkhoa(String chuyenkhoaTen) {
    setState(() {
      // Lọc bác sĩ theo chuyên khoa
      currentBacsiList = bacsiList
          .where((bacsi) => bacsi.chuyenKhoa == chuyenkhoaTen)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    double screenHeight = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Bác sĩ chuyên khoa'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          // Horizontal list for specialties
          Container(
            height: 80.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal, // Cho phép cuộn ngang
              itemCount: chuyenkhoaList.length,
              itemBuilder: (context, index) {
                final chuyenkhoa = chuyenkhoaList[index];
                return GestureDetector(
                  onTap: () {
                    filterBacsiByChuyenkhoa(chuyenkhoa.ten);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(chuyenkhoa.icon, size: 50.0, color: Colors.blue),
                        SizedBox(height: 10.0),
                        Text(
                          chuyenkhoa.ten,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Divider(),
          // Vertical list for doctors
          Expanded(
            child: ListView.builder(
              itemCount: currentBacsiList.length,
              itemBuilder: (context, index) {
                final bacsi = currentBacsiList[index];
                return ListTile(
                  leading: CircleAvatar(
                    child: Icon(Icons.person),
                    backgroundColor: Colors.blue,
                  ),
                  title: Text(bacsi.ten),
                  subtitle: Text('${bacsi.chuyenKhoa} - ${bacsi.benhVien}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('${bacsi.danhGia} ⭐'),
                      IconButton(
                        icon: Icon(Icons.favorite_border),
                        onPressed: () {
                          // Thêm chức năng yêu thích
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Chuyenkhoa {
  final String ten;
  final IconData icon;

  Chuyenkhoa({
    required this.ten,
    required this.icon,
  });
}

class Bacsi {
  final String ten;
  final String chuyenKhoa;
  final String benhVien;
  final double danhGia;

  Bacsi({
    required this.ten,
    required this.chuyenKhoa,
    required this.benhVien,
    required this.danhGia,
  });
}
