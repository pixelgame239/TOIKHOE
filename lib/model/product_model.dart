import 'package:mysql1/mysql1.dart';

class Product {
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
      name: map['name'] is Blob
          ? String.fromCharCodes((map['name'] as Blob).toBytes())
          : map['name'],
      description: map['description'] is Blob
          ? String.fromCharCodes((map['description'] as Blob).toBytes())
          : map['description'],
      price: map['price'],
      stock: map['stock'],
      createdAt: map['created_at'],
    );
  }
}
