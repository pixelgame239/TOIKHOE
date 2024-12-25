import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toikhoe/database/fetch_orders.dart';

class OrderModel {
  int orderID;
  int userID;
  int productID;
  String productName;
  int quantity;
  double unitPrice;
  double totalAmount;
  double shippingFee;
  String discountCode;
  String paymentStatus;
  DateTime? dateAdd;
  OrderModel(this.orderID, this.userID, this.productID, this.productName, this.quantity, this.unitPrice, this.totalAmount, this.shippingFee, this.discountCode, this.paymentStatus, this.dateAdd);
}
final ordersProvider = StateNotifierProvider<Orders, List<OrderModel>>((ref){
  return Orders([]);
});
class Orders extends StateNotifier<List<OrderModel>>{
    Orders(List<OrderModel> state) : super(state);
  Future<void> fetchuserOrders(int userID) async{
    List<OrderModel>? orders = await fetchAllOrders(userID);
    if(orders!=null){
       state = orders;
    }
  }
  void addOrder(int userID, int productID, int quantity, double unitPrice, double totalAmount, double shipping_fee, String? discount_code){
  }
}