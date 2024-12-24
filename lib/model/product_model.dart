import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mysql1/mysql1.dart';

class Product extends ChangeNotifier {
  final int productID;
  final String name;
  final String description;
  final double price;
  final int stock;
  final DateTime createdAt;

  Product({
    required this.productID,
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
    required this.createdAt,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      productID: map['productID'],
      name: map['name'],
      description: map['description'],
      price: map['price'],
      stock: map['stock'],
      createdAt: map['created_at'],
    );
  }
}
final listProductProvider = StateNotifierProvider<ListProduct, List<Product>>((ref) {
  return ListProduct([]);
});

class ListProduct extends StateNotifier<List<Product>> {
  ListProduct(List<Product> state) : super(state);

  void addProduct(Product singleProduct) {
    // Immutable state update
    state = [...state, singleProduct];
  }

  // You can add other methods to modify the list if necessary
}

