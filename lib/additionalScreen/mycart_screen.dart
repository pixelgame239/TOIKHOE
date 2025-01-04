import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toikhoe/MainScreen/buy_screen.dart';
import 'package:toikhoe/MainScreen/product_detail_screen.dart';
import 'package:toikhoe/database/fetch_orders.dart';
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
  List<bool> checkOrders = [];
  bool checkAllOrders= false;
  List<OrderModel> buyProducts=[];
  @override
  void initState() {
    super.initState();
    int userID = ref.read(userProvider).first.userId;
    ref.read(ordersProvider.notifier).fetchuserOrders(userID);
    checkOrders =List<bool>.generate(ref.read(ordersProvider).length,(index)=>false);
  }

  @override
  Widget build(BuildContext context) {
    final orders = ref.watch(ordersProvider);
    // for(var order in orders){
    //   allOrdersTotalAmount+=order.totalAmount;
    // }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giỏ hàng'),
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
                                  value: checkOrders[index],
                                  onChanged: (value) {
                                    checkOrders[index]  = value!;
                                    if(checkOrders.every((checked)=>checked==true)){
                                      checkAllOrders=true;
                                      setState(() {
                                      });
                                    }
                                    else{
                                      checkAllOrders=false;
                                      setState(() {
                                      });
                                    }
                                    if(checkOrders[index]==true){
                                      setState(() {
                                        buyProducts.add(order);
                                        allOrdersTotalAmount+=order.totalAmount;
                                      });
                                    }
                                    else if(checkOrders[index]==false){
                                      setState(() {
                                        buyProducts.removeWhere((item)=>item.orderID==order.orderID);
                                        allOrdersTotalAmount-=order.totalAmount;
                                      });
                                    }
                                  },
                                ),
                                const Text(
                                  "Cửa hàng",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed: () {
                                showDialog(context: context, builder: (context)=>AlertDialog(
                                  title: const Text('Bạn có đồng ý xoá sản phẩm này khỏi giỏ hàng'),
                                        actions: [
                                          TextButton(onPressed: () async{
                                            await deleteOrder(order.orderID, ref);
                                            checkOrders.length = ref.read(ordersProvider).length;
                                            setState(() {
                                            });
                                            Navigator.pop(context);
                                          }, child: const Text('Đồng ý xoá!', style: TextStyle(color: Colors.red),)),
                                          TextButton(onPressed: (){
                                            Navigator.pop(context);
                                          }, child: const Text('Huỷ'))
                                        ],
                                      ));
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
                                      order.quantity = newQuantity;
                                      order.totalAmount = order.unitPrice*order.quantity;
                                      setState(() {
                                      });      
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
                    Flexible(child: Checkbox(
                      value: checkAllOrders, 
                      onChanged: (value) {
                      if(value!=null){
                      checkAllOrders = value;
                        for(int i = 0; i<checkOrders.length; i++){
                          checkOrders[i]=value;
                        }
                        if(checkAllOrders){
                           allOrdersTotalAmount = 0.0; // Reset the total
                                  for (int i = 0; i < checkOrders.length; i++) {
                                    if (checkOrders[i]) {
                                      allOrdersTotalAmount +=
                                          orders[i].totalAmount;
                                          buyProducts.add(orders[i]);
                                    }
                    }
                        }
                        else{
                          buyProducts.clear();
                          allOrdersTotalAmount=0.0;
                        }
                        setState(() {
                        });
                      }
                     },)),
                    const Text('Tất cả'),
                    Flexible(
                      child: Text(
                        'Tổng thanh toán: ${allOrdersTotalAmount.abs().toStringAsFixed(2)} USD',
                        style: const TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    if(buyProducts.isEmpty){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Chưa có sản phẩm nào được chọn')));
                    }
                    else{
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>BuyScreen(buyProducts: buyProducts, isCart: true,)));
                    }
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
