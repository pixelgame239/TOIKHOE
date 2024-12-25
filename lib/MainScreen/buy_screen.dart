import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toikhoe/model/product_model.dart';
import 'package:toikhoe/riverpod/user_riverpod.dart';

class BuyScreen extends ConsumerStatefulWidget {
  const BuyScreen({super.key, required this.buyProduct, required this.quantity});
  final Product buyProduct;
  final int quantity;

  @override
  ConsumerState<BuyScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends ConsumerState<BuyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chi tiết đơn hàng')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(child: Text(widget.buyProduct.name),),
            Text('Số lượng: ${widget.quantity}'),
            Text('Địa chỉ nhận hàng: ${ref.read(userProvider).first.address}')
          ],
        ),
      ),
    );
  }
}