import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toikhoe/MainScreen/bac_si_screen.dart';
import 'package:toikhoe/MainScreen/home_element.dart';
import 'package:toikhoe/MainScreen/tmdt_screen.dart';
import 'package:toikhoe/additionalScreen/mycart_screen.dart';
import 'package:toikhoe/additionalScreen/notification_screen.dart';
import 'package:toikhoe/additionalScreen/profile_screen.dart';
import 'package:toikhoe/database/fetch_products.dart';
import 'package:toikhoe/model/navigationbar_control.dart';
import 'package:toikhoe/model/product_model.dart';
import 'package:toikhoe/riverpod/user_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int currentIndex = 0;
  double last_position = 0;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(_onScroll);
    super.initState();
    ref.read(showNaviProvider);
  }

  Widget? _screen(int currentIndex) {
    if (currentIndex == 0) {
      return const HomeElement();
    } else if (currentIndex == 4) {
      return const TMDTScreen();
    } else if (currentIndex == 1) {
      return const BacSiScreen();
    } else {
      // You can add more conditions if needed for other screens
      return Container(); // Return an empty container for other indexes
    }
  }

  void _onScroll() {
    if (scrollController.offset > last_position &&
        scrollController.offset > 0) {
      // User scrolling down
      if (ref.read(showNaviProvider.notifier).state) {
        ref.read(showNaviProvider.notifier).state = false;
      }
    } else if (scrollController.offset < last_position) {
      // User scrolling up
      if (!ref.read(showNaviProvider.notifier).state) {
        ref.read(showNaviProvider.notifier).state = true;
      }
    }
    last_position = scrollController.offset;
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider).isNotEmpty
        ? ref.watch(userProvider).first
        : null;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.account_circle, color: Colors.white),
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => ProfileScreen())),
        ),
        title: Text(
          user != null
              ? 'Chào mừng\n ${user.name}' // Hiển thị tên người dùng
              : 'Chào mừng\nQuý Khách', // Hiển thị giá trị mặc định nếu không có người dùng
          style: const TextStyle(
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
      body: Builder(
        builder: (context) {
          if (currentIndex == 4 || currentIndex == 1) {
            return _screen(currentIndex) ?? const SizedBox.shrink();
          } else {
            return SingleChildScrollView(
              controller: scrollController,
              child: _screen(currentIndex) ?? const SizedBox.shrink(),
            );
          }
        },
      ),

      // currentIndex == 4
      //     ? _screen(currentIndex)
      //     : ,
      bottomNavigationBar: Visibility(
        visible: ref.watch(showNaviProvider),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          currentIndex: currentIndex,
          onTap: (index) {
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
