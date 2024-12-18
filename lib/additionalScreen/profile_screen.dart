import 'package:flutter/material.dart';
import 'package:toikhoe/loginScreen/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hồ sơ'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(backgroundImage: AssetImage('assets/ZaloLogin.jpg'), radius: 50),
            Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TextFormField(
                  initialValue: 'Lil Doctor',
                  enabled: false,
                  decoration: const InputDecoration(icon: Icon(Icons.person_pin)),
                )
                ),
            Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TextFormField(
                  initialValue: '088888888',
                  enabled: false,
                  decoration: const InputDecoration(icon: Icon(Icons.calendar_today)),
                )
                ),
            Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TextFormField(
                  initialValue: '12/12/1212',
                  enabled: false,
                  decoration: const InputDecoration(icon: Icon(Icons.phone_android)),
                )
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
              child: ElevatedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                }, child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout,color: Colors.red,),
                    Text('Đăng xuất'),
                  ],
                )
                ),
            )
          ],
        ),
      ),
    );
  }
}