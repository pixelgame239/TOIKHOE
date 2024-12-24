import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mysql1/mysql1.dart';
import 'package:toikhoe/database/fetch_products.dart';

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

  Future<void> fetchProducts() async{
    List<Product> products = await fetchAllProducts();
    state = products;
  }
  void addProduct(Product singleProduct) {
    state = [...state, singleProduct];
  }
   void removeProduct(int productId) {
    state = state.where((product) => product.productID != productId).toList();
  }

  // Modify a product in the list
  void modifyProduct(Product modifiedProduct) {
    final index = state.indexWhere((product) => product.productID == modifiedProduct.productID);
    
    if (index != -1) {
      state = [
        ...state.sublist(0, index),
        modifiedProduct,
        ...state.sublist(index + 1),
      ];
    }
  }
}

