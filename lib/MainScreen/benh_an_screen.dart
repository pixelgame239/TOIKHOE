import 'package:flutter/material.dart';
import 'package:toikhoe/mainScreen/them_benh_an_screen.dart';

class MedicalRecordsScreen extends StatelessWidget {
  const MedicalRecordsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bệnh án'),
      ),
      body: Center(
        child: Text('Bệnh án'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to another screen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  themBenhAnScreen(), // Replace with your target screen
            ),
          );
        },
        child: Icon(Icons.add), // Icon for the FAB
      ),
    );
  }
}


