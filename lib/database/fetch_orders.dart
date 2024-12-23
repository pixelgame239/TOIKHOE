import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'package:toikhoe/database/connection.dart';
import 'package:toikhoe/model/order_model.dart';

Future<List<OrderModel>?> fetchAllOrders(int userID, Orders userOrders) async{
  MySqlConnection? conn = await connectToRDS();
  if(conn!=null){
    final result = await conn.query('Select * from Orders where userID=?' [userID]);
    for(var res in result){
      OrderModel curOrder = OrderModel(0, userID, 0, 0, 'discountCode', 'paymentStatus', null);
      curOrder.orderID= res['orderID'];
      curOrder.totalAmount = res['totalAmount'];
      curOrder.shippingFee = res['shipping_fee'];
      curOrder.discountCode = res['discount_code'];
      if(res['paymentStatus']=='Pending'){
        curOrder.paymentStatus = 'Đang chờ thanh toán';
      }
      else if(res['paymentStatus']=='Paid'){
        curOrder.paymentStatus = 'Đã thanh toán';
      }
      else{
        curOrder.paymentStatus = 'Đã huỷ';
      }
      curOrder.dateAdd = res['created_at'];
      userOrders.listOrders.add(curOrder);
    }
    return userOrders.listOrders;
  }
  else{
    throw 'Something went wrong';
  }
}