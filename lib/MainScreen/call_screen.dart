import 'package:flutter/material.dart';

class DoctorCallScreen extends StatelessWidget {
  const DoctorCallScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Phần hiển thị hình ảnh bác sĩ
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Image.network(
                'https://via.placeholder.com/300', // Thay đường dẫn ảnh tại đây
                fit: BoxFit.contain,
              ),
            ),
          ),

          // Thanh nút chức năng
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Nút tắt/mở mic
                CircleAvatar(
                  backgroundColor: Colors.grey.shade200,
                  radius: 28,
                  child: IconButton(
                    icon: const Icon(Icons.mic_off, color: Colors.black54),
                    onPressed: () {
                      // Xử lý tắt/mở mic
                    },
                  ),
                ),

                // Nút gọi trung tâm
                CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 32,
                  child: IconButton(
                    icon: const Icon(Icons.call, color: Colors.white, size: 28),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),

                // Nút bật/tắt camera
                CircleAvatar(
                  backgroundColor: Colors.grey.shade200,
                  radius: 28,
                  child: IconButton(
                    icon: const Icon(Icons.videocam, color: Colors.black54),
                    onPressed: () {
                      // Xử lý bật/tắt camera
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
