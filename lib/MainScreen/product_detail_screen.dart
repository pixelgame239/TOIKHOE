import 'package:flutter/material.dart';
import 'package:toikhoe/database/fetch_products.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key, required Product product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
