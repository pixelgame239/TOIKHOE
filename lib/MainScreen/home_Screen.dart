import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toikhoe/MainScreen/home_element.dart';
import 'package:toikhoe/MainScreen/tmdt_screen.dart';
import 'package:toikhoe/additionalScreen/mycart_screen.dart';
import 'package:toikhoe/additionalScreen/notification_screen.dart';
import 'package:toikhoe/additionalScreen/profile_screen.dart';
import 'package:toikhoe/database/fetch_products.dart';
import 'package:toikhoe/model/product_model.dart';

class HomeScreen extends ConsumerStatefulWidget {
  HomeScreen({super.key});
  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int currentIndex = 0;
  bool showNavi = true;
  double last_position = 0;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(onScroll);
    super.initState();
  }

  Widget? _screen(int currentIndex){
    if (currentIndex == 0) {
      return  const HomeElement();
    } else if (currentIndex == 4) {
      return const TMDTScreen();
    } else {
      // You can add more conditions if needed for other screens
      return Container(); // Return an empty container for other indexes
    }
  }

  void onScroll() {
    if (scrollController.offset > last_position &&
        scrollController.offset > 0) {
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
    final productList = ref.read(ListProduct);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.account_circle, color: Colors.white),
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => ProfileScreen())),
        ),
        title: const Text(
          'Chào mừng\n ABC XYZ',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyCartScreen()));
            },
            icon: Icon(Icons.shopping_cart, color: Colors.white),
          ),
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const NotiScreen()));
            },
          ),
        ],
      ),
      body: currentIndex == 4
      ? _screen(currentIndex)
      : SingleChildScrollView(
        child: _screen(currentIndex),
        controller: scrollController,
      ),
      bottomNavigationBar: Visibility(
        visible: showNavi,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          currentIndex: currentIndex,
          onTap: (index) async {
            setState(() {
              currentIndex = index;

            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang chủ'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_3), label: 'Bác sĩ'),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.calendar_badge_plus),
                label: 'Đặt lịch khám'),
            BottomNavigationBarItem(
                icon: Icon(Icons.message), label: 'Tin nhắn'),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopify), label: 'Sàn TMĐT'),
          ],
        ),
      ),
    );
  }
}
