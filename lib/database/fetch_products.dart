import 'package:mysql1/mysql1.dart';

import 'connection.dart';

class Product {
  final int productID;
  final String name;
  final String? description;
  final double price;
  final int stock;
  final DateTime createdAt;

  Product({
    required this.productID,
    required this.name,
    this.description,
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

Future<List<Product>> fetchAllProducts() async {
  List<Product> products = [];
  final conn = await connectToRDS();
  if (conn == null) {
    print('Kết nối chưa được khởi tạo.');
    return products; // Trả về danh sách rỗng
  }

  try {
    final result = await conn.query("SELECT * FROM Products");

    for (var row in result) {
      products.add(Product.fromMap(row.fields));
    }

    print('Lấy toàn bộ thông tin sản phẩm thành công: $products');
  } catch (e) {
    print('Lỗi khi lấy thông tin sản phẩm: $e');
  } finally {
    await conn.close();
  }

  return products;
}
