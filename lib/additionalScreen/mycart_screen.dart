import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toikhoe/model/order_model.dart';
import 'package:toikhoe/riverpod/user_riverpod.dart';

class MyCartScreen extends ConsumerStatefulWidget {
  const MyCartScreen({super.key});

  @override
  ConsumerState<MyCartScreen> createState() => MyCartScreenState();
}

class MyCartScreenState extends ConsumerState<MyCartScreen> {
  @override
  void initState() {
    super.initState();
    int userID = ref.read(userProvider).first.userId;
    ref.read(ordersProvider.notifier).fetchuserOrders(userID);
  }

  @override
  Widget build(BuildContext context) {
    final orders = ref.watch(ordersProvider);

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
                          trailing: IntrinsicWidth(
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {

                                  },
                                  icon: const Icon(Icons.remove),
                                ),
                                SizedBox(
                                  width: 20,
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
                                IconButton(
                                  onPressed: () {

                                  },
                                  icon: const Icon(Icons.add),
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
                    Row(
                      children: [
                        Checkbox(value: true, onChanged: (bool? value) {  },),
                        const Text('Tất cả'),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Tổng thanh toán: đ',
                          style: const TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ],
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
