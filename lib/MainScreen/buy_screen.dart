import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toikhoe/database/fetch_orders.dart';
import 'package:toikhoe/model/order_model.dart';
import 'package:toikhoe/model/product_model.dart';
import 'package:toikhoe/riverpod/user_riverpod.dart';

class BuyScreen extends ConsumerStatefulWidget {
  const BuyScreen(
      {super.key, required this.buyProducts, required this.isCart});
  final List<OrderModel> buyProducts;
  final bool isCart;

  @override
  ConsumerState<BuyScreen> createState() => _BuyScreenState();
}

class _BuyScreenState extends ConsumerState<BuyScreen> {
  bool isBought = false;
  @override
  Widget build(BuildContext context) {
    final user = ref.read(userProvider).first;
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) async{
        if(didPop){
        result = isBought;
        if(result!=true&&widget.isCart==false){
          await deleteOrder(widget.buyProducts[0].orderID, ref);
        }
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Thanh toán')),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Địa chỉ giao hàng
              Card(
                margin: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.red),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(user.name,
                                style:
                                    const TextStyle(fontWeight: FontWeight.bold)),
                            Text(user.address,
                                style: const TextStyle(color: Colors.grey)),
                          ],
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios,
                          size: 16, color: Colors.grey),
                    ],
                  ),
                ),
              ),
              const Divider(thickness: 1),
      
              // Sản phẩm mua
              Column(
                children: 
                  List.generate(widget.buyProducts.length, (index){
                  final singleOrder = widget.buyProducts[index];
                  return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Image.asset(
                          'assets/ZaloLogin.jpg', // Replace with product image path
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                        title: Text(singleOrder.productName),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Số lượng: ${singleOrder.quantity}'),
                            Text('Đơn giá: ${singleOrder.unitPrice} đ',
                                style: const TextStyle(color: Colors.red)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16.0, bottom: 8.0),
                        child: Row(
                          children: [
                            Flexible(
                              child: Checkbox(
                                value: false,
                                onChanged: (value) {
                                  // Xử lý bảo hiểm (nếu cần)
                                },
                              ),
                            ),
                            Flexible(
                                child: const Text('Bảo hiểm thiết bị điện tử')),
                            Flexible(
                              child: Text('+ 0 đ',
                                  style: const TextStyle(color: Colors.red)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
                  })
              ),
      
              const Divider(thickness: 1),
      
              // Phương thức vận chuyển
              Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: const Text('Phương thức vận chuyển'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      const Text('Đảm bảo nhận hàng từ ',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
      
              // Phương thức thanh toán
              Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: const Text('Phương thức thanh toán'),
                  subtitle: Text('Ví điện tử'),
                  trailing: const Icon(Icons.arrow_forward_ios,
                      size: 16, color: Colors.grey),
                ),
              ),
      
              const Divider(thickness: 1),
      
              // Chi tiết thanh toán
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Tổng tiền hàng'),
                        Text('${widget.buyProducts[0].quantity} đ'),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Phí vận chuyển'),
                        const Text('0đ'),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Giảm giá'),
                        const Text('0đ', style: TextStyle(color: Colors.red)),
                      ],
                    ),
                    const Divider(thickness: 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Tổng thanh toán',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(
                          '${widget.buyProducts[0].quantity} đ', // Adjust total based on discounts/shipping
                          style: const TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
      
              const Divider(thickness: 1),
      
              // Nút đặt hàng
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Xử lý đặt hàng
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: Colors.red,
                  ),
                  child: const Text('Đặt hàng',
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
