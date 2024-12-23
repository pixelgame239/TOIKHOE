import 'package:flutter/material.dart';
import 'package:toikhoe/MainScreen/product_detail_screen.dart';
import 'package:toikhoe/database/fetch_products.dart';
import 'package:toikhoe/model/product_model.dart';

class TMDTScreen extends StatefulWidget {
  const TMDTScreen({super.key});

  @override
  State<TMDTScreen> createState() => _TMDTScreenState();
}

class _TMDTScreenState extends State<TMDTScreen> {
  late Future<List<Product>> _productsFuture;

  @override
  void initState() {
    super.initState();
    _productsFuture = fetchAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    // Get the width of the screen to adjust the number of columns
    double screenWidth = MediaQuery.of(context).size.width;

    // Determine the number of columns based on the screen width
    int crossAxisCount = screenWidth > 600
        ? 3
        : 2; // 3 columns for larger screens, 2 columns for smaller screens
    return FutureBuilder<List<Product>>(
      future: _productsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Lỗi: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
              child: Text('Không có sản phẩm nào để hiển thị.'));
        }

        final products = snapshot.data!;

        return GridView.builder(
          padding: const EdgeInsets.all(8.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount, // Dynamic number of columns
            crossAxisSpacing: 8, // Spacing between columns
            mainAxisSpacing: 8, // Spacing between rows
            childAspectRatio: screenWidth > 600
                ? 4 / 3
                : 3 / 2, // Adjust aspect ratio for larger screens
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final curProduct = products[index];
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailScreen(curProduct: curProduct),
                  ),
                );
              },
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        curProduct.name,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '\$${curProduct.price.toStringAsFixed(2)}',
                        style:
                            const TextStyle(fontSize: 14, color: Colors.green),
                      ),
                      Text(
                        'Stock: ${curProduct.stock}',
                        style:
                            const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
