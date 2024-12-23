class OrderModel {
  int orderID;
  int userID;
  double totalAmount;
  double shippingFee;
  String discountCode;
  String paymentStatus;
  DateTime? dateAdd;
  OrderModel(this.orderID, this.userID, this.totalAmount, this.shippingFee, this.discountCode, this.paymentStatus, this.dateAdd);
}
class Orders{
  List<OrderModel> listOrders=[];
}