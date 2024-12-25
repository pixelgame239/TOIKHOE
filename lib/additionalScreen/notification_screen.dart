import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotiScreen extends StatefulWidget {
  const NotiScreen({super.key});

  @override
  State<NotiScreen> createState() => _NotiScreenState();
}

class _NotiScreenState extends State<NotiScreen> {
  int _itemCount = 5;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Thông báo'),),
      body: _itemCount==0
      ? const Center(child: Text('Bạn không có thông báo nào'),)
      : ListView.builder(
        itemCount: _itemCount,
        itemBuilder: (context,index){
          return Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: ListTile(
              tileColor: Colors.blueGrey[50],
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.elliptical(15, 15))),
              title: const Text('Bạn có thông báo mới!'),
              trailing: IconButton(
              icon: const Icon(CupertinoIcons.clear_circled, color: Colors.red,), 
              onPressed: () {
                _itemCount--;
                setState(() {
                });
              },
              ),
            ),
          );
        }
      ),
    );
  }
}