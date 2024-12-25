import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toikhoe/MainScreen/product_detail_screen.dart';
import 'package:toikhoe/database/fetch_products.dart';
import 'package:toikhoe/model/order_model.dart';
import 'package:toikhoe/model/product_model.dart';
import 'package:toikhoe/riverpod/user_riverpod.dart';

class MyCartScreen extends ConsumerStatefulWidget {
  const MyCartScreen({super.key});

  @override
  ConsumerState<MyCartScreen> createState() => MyCartScreenState();
}

class MyCartScreenState extends ConsumerState<MyCartScreen> {
  double allOrdersTotalAmount = 0;
  @override
  void initState() {
    super.initState();
    int userID = ref.read(userProvider).first.userId;
    ref.read(ordersProvider.notifier).fetchuserOrders(userID);
  }

  @override
  Widget build(BuildContext context) {
    final orders = ref.watch(ordersProvider);
    for(var order in orders){
      allOrdersTotalAmount+=order.totalAmount;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giỏ hàng'),
        actions: [
          TextButton(
            onPressed: () {
              // Thực hiện sửa toàn bộ
            },
            child: const Text(
              'Sửa',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: orders.isEmpty
          ? const Center(
        child: Text('Chưa có sản phẩm trong giỏ hàng'),
      )
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: Card(
                    child: Column(
                      children: [
                        // Tích chọn sản phẩm
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: true,
                                  onChanged: (bool? value) {

                                  },
                                ),
                                Text(
                                  "Cửa hàng",
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed: () {

                              },
                              icon: const Icon(Icons.delete, color: Colors.grey),
                            ),
                          ],
                        ),
                        // Thông tin sản phẩm
                        ListTile(
                          onTap: () async{
                            Product curProduct = await fetchSingleProduct(order.productID);
                              Navigator.push(context,MaterialPageRoute(builder: (context)=>ProductDetailScreen(curProduct: curProduct)));
                          },
                          horizontalTitleGap: 5,
                          leading: Image.asset(
                            'assets/ZaloLogin.jpg',
                            fit: BoxFit.cover,
                            width: 60,
                            height: 60,
                          ),
                          title: Text(
                            order.productName,
                            style: const TextStyle(fontSize: 14),
                          ),
                          subtitle: Text(
                            '${order.totalAmount.toString()} USD',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: SizedBox(
                            width: 80,
                            child: Row(
                              children: [
                                Flexible(
                                  child: IconButton(
                                    onPressed: () {
                                                            
                                    },
                                    icon: const Icon(Icons.remove, size: 20,),
                                  ),
                                ),
                                Flexible(
                                  child: TextField(
                                    textAlign: TextAlign.center,
                                    controller: TextEditingController(
                                      text: order.quantity.toString(),
                                    ),
                                    keyboardType: TextInputType.number,
                                    onSubmitted: (value) {
                                      int newQuantity = int.tryParse(value) ?? 1;         
                                    },
                                  ),
                                ),
                                Flexible(
                                  child: IconButton(
                                    onPressed: () {
                                                            
                                    },
                                    icon: const Icon(Icons.add, size: 20,),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // Tổng tiền và nút mua hàng
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(child: Checkbox(value: true, onChanged: (bool? value) {  },)),
                    const Text('Tất cả'),
                    Flexible(
                      child: Text(
                        'Tổng thanh toán: ${allOrdersTotalAmount} USD',
                        style: const TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    // Xử lý thanh toán
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 32.0),
                    backgroundColor: Colors.red,
                  ),
                  child: const Text(
                    'Mua hàng',
                    style: TextStyle(fontSize: 16, color: Colors.white),
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
