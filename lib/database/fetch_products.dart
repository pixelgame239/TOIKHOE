import 'package:mysql1/mysql1.dart';
import 'package:toikhoe/model/product_model.dart';

import 'connection.dart';

Future<List<Product>> fetchAllProducts() async {
  List<Product> products= [];
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
