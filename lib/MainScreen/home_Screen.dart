import 'package:flutter/material.dart';
import 'package:toikhoe/MainScreen/home_element.dart';
import 'package:toikhoe/additionalScreen/notification_screen.dart';
import 'package:toikhoe/additionalScreen/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex=2;
  bool showNavi = true;
  double last_position = 0;
  ScrollController scrollController = ScrollController();
  @override
  void initState(){
    scrollController.addListener(onScroll);
    super.initState();
  }
  Widget? _screen(int currentIndex){
    if(currentIndex==2){
      return const HomeElement();      
    }
    else{

    }
  }
  void onScroll(){
    if (scrollController.offset > last_position && scrollController.offset > 0) {
      // User scrolling down
      if (showNavi) {
        setState(() {
          showNavi = false;
        });
      }
    } else if (scrollController.offset < last_position) {
      // User scrolling up
      if (!showNavi) {
        setState(() {
          showNavi = true;
        });
      }
    }
    last_position = scrollController.offset;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.account_circle, color: Colors.white),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileScreen())),
        ),
        title: const Text(
          'Chào mừng\n ABC XYZ',
          style:  TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: [
          IconButton(
              icon: const Icon(Icons.notifications, color: Colors.white),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const NotiScreen()));
              }),
        ],
      ),
      body: SingleChildScrollView(child: _screen(currentIndex), controller: scrollController,),
      bottomNavigationBar: Visibility(
        visible: showNavi,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          currentIndex: currentIndex,
          onTap:(index){
            setState(() {
              currentIndex =index;
            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Bác sĩ'),
            BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang chủ'),
            BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Tin nhắn'),
            BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'Tiện ích'),
          ],
        ),
      ),
    );
  } } // HomeScreen
