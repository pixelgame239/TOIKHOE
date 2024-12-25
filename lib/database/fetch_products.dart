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
Future<Product> fetchSingleProduct(int singproductID) async{
  Product singleProduct = Product(productID: singproductID, name: 'name', description: 'null', price: 0, stock: 0, createdAt: null);
  MySqlConnection? conn = await connectToRDS();
  if(conn!=null){
    final fetchData = await conn.query('Select * from Products where productID=?', [singproductID]);
    for(var result in fetchData){
      Product tempProduct = Product(productID: singproductID, name: result['name'], description: result['description'], price: result['price'], stock: result['stock'], createdAt: result['created_at']);
      singleProduct = tempProduct;
    }
    return singleProduct;
  }
  else{
    return singleProduct;
  }
}
