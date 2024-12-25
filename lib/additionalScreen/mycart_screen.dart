import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toikhoe/MainScreen/product_detail_screen.dart';
import 'package:toikhoe/model/order_model.dart';
import 'package:toikhoe/model/product_model.dart';
import 'package:toikhoe/riverpod/user_riverpod.dart';

class MyCartScreen extends ConsumerStatefulWidget {
  const MyCartScreen({super.key});

  @override
  ConsumerState<MyCartScreen> createState() => MyCartScreenState();
}

class MyCartScreenState extends ConsumerState<MyCartScreen> {
  @override
  void initState(){
    super.initState();
    int userID = ref.read(userProvider).first.userId;
    ref.read(ordersProvider.notifier).fetchuserOrders(userID);
  }
  @override
  Widget build(BuildContext context) {
    final orders = ref.watch(ordersProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Giỏ hàng của tôi'),),
      body: orders.length==0
      ?Center(child: Text('Chưa có đơn hàng nào'),)
      : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: orders.length, 
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Image(image: AssetImage('assets/ZaloLogin.jpg')),
                    title: Text(orders[index].productName),
                    trailing: Text(orders[index].totalAmount.toString(), style: TextStyle(color: Colors.red),),
                    onTap: (){
                      Product curProduct = ref.watch(listProductProvider).singleWhere((singProduct)=>singProduct.productID ==orders[index].productID);
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>ProductDetailScreen(curProduct: curProduct)));
                    }
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