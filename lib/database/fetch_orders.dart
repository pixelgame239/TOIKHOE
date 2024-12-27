import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mysql1/mysql1.dart';
import 'package:toikhoe/database/connection.dart';
import 'package:toikhoe/model/order_model.dart';


Future<List<OrderModel>?> fetchAllOrders(int userID) async{
  MySqlConnection? conn = await connectToRDS();
  List<OrderModel> listOrders = [];
  if(conn!=null){
    final result = await conn.query('Select o.*, p.name from Orders o inner join Products p on o.productID = p.productID where o.userID=?', [userID]);
    for(var res in result){
      OrderModel curOrder = OrderModel(0, userID, 0, 'productName', 0, 0, 0, 0, 'discountCode', 'paymentStatus', null);
      curOrder.orderID= res['OrderID'];
      curOrder.productID = res['productID'];
      curOrder.productName = res['name'];
      curOrder.quantity = res['quantity'];
      curOrder.unitPrice = res['price'];

      curOrder.totalAmount = res['totalAmount'];
      curOrder.shippingFee = res['shipping_fee'];
      curOrder.discountCode = res['discount_code'];
      if (res['paymentStatus'] == 'Pending') {
        curOrder.paymentStatus = 'Đang chờ thanh toán';
      } else if (res['paymentStatus'] == 'Paid') {
        curOrder.paymentStatus = 'Đã thanh toán';
      } else {
        curOrder.paymentStatus = 'Đã huỷ';
      }
      curOrder.dateAdd = res['created_at'];
      listOrders.add(curOrder);
    }

    return listOrders;
  }
  else{
    throw 'Something went wrong';
  }
}
Future<void> addOrder(int userID, int productID, int quantity, double price, double totalAmount, double shipping_fee, String discount_code, WidgetRef ref) async{
  MySqlConnection? conn = await connectToRDS();
  if(conn!=null){
    try{
          await conn.query('Insert into Orders(userID, productID, quantity, price, totalAmount, shipping_fee, discount_code) values (?,?,?,?,?,?,?)', 
          [userID, productID, quantity, price, totalAmount, shipping_fee, discount_code]);
      final result = await conn.query('Select o.*, p.name from Orders o inner join Products p on o.productID = p.productID Order by OrderID desc limit 1');
      for(var res in result){
        ref.read(ordersProvider.notifier).addOrderProvider(res['OrderID'], userID, productID, res['name'], quantity, price, totalAmount);
      }
    } catch(error){
      print(error);
    }
  }
}
Future<void> deleteOrder(int orderID, WidgetRef ref) async {
  MySqlConnection? conn = await connectToRDS();
  if(conn!=null){
    try{
      await conn.query('Delete from Orders where OrderID = ?', [orderID]);
      ref.read(ordersProvider.notifier).deleteOrder(orderID);
    }
    catch(error){
      print(error);
    }
  }
}

