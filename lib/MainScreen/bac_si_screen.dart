import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toikhoe/MainScreen/bac_si_detail_screen.dart';
// Import hàm fetch từ file fetch_bac_si.dart
import 'package:toikhoe/database/fetch_user_doctor.dart'; // Import file chứa hàm fetchUsersAndDoctors

// onTap ListTile của BacSiScreen dẫn tới màn hình mới hiển thị toàn bộ
class BacSiScreen extends ConsumerStatefulWidget {
  const BacSiScreen({super.key});

  @override
  ConsumerState<BacSiScreen> createState() => _BacSiScreenState();
}

class _BacSiScreenState extends ConsumerState<BacSiScreen> {
  late Future<List<Map<String, dynamic>>> _usersAndDoctorsFuture;

  @override
  void initState() {
    super.initState();
    // Gọi hàm fetchUsersAndDoctors từ file fetch_user_doctor.dart
    _usersAndDoctorsFuture = fetchUsersAndDoctors();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder<List<Map<String, dynamic>>>(
        future: _usersAndDoctorsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Lỗi: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Không có dữ liệu.'));
          } else {
            // Lọc dữ liệu bác sĩ từ kết quả
            final doctors = snapshot.data!
                .where((user) => user['role'] == 'Doctor') // Lọc chỉ bác sĩ
                .toList();

            if (doctors.isEmpty) {
              return const Center(child: Text('Không tìm thấy bác sĩ nào.'));
            }

            return Scrollbar(
              child: ListView.builder(
                itemCount: doctors.length,
                itemBuilder: (context, index) {
                  final doctor = doctors[index];
                  return Card(
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ListTile(
                      leading: CircleAvatar(
                        child:
                            doctor['name'] != null && doctor['name']!.isNotEmpty
                                ? Text(doctor['name']![0])
                                : const Icon(Icons.person),
                      ),
                      title: Text(doctor['name'] ?? 'Không rõ'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(doctor['specialization'] ?? 'Chưa rõ'),
                          Text(
                            doctor['experience'] != null
                                ? '${doctor['experience']} năm kinh nghiệm'
                                : 'Kinh nghiệm chưa cập nhật',
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BacSiDetailScreen(
                              doctorData: doctor,
                            ),
                          ),
                        );
                      },

                      isThreeLine: true, // Cho phép hiển thị 3 dòng
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
