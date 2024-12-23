import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toikhoe/MainScreen/product_detail_screen.dart';
import 'package:toikhoe/model/navigationbar_control.dart';
import 'package:toikhoe/model/product_model.dart';

class TMDTScreen extends ConsumerStatefulWidget {
  const TMDTScreen({super.key});

  @override
  ConsumerState<TMDTScreen> createState() => _TMDTScreenState();
}

class _TMDTScreenState extends ConsumerState<TMDTScreen> {
  double last_position = 0;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    ref.read(listProductProvider.notifier).fetchProducts();
    scrollController.addListener(_onScroll);
  }
  void _onScroll() {
    if (scrollController.offset > last_position &&
        scrollController.offset > 0) {
      // User scrolling down
      if (ref.read(showNaviProvider.notifier).state) {
        ref.read(showNaviProvider.notifier).state= false;
      }
    } else if (scrollController.offset < last_position) {
      // User scrolling up
      if (!ref.read(showNaviProvider.notifier).state) {
          ref.read(showNaviProvider.notifier).state = true;
      }
    }
    last_position = scrollController.offset;
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(listProductProvider);
    // Get the width of the screen to adjust the number of columns
    double screenWidth = MediaQuery.of(context).size.width;

    // Determine the number of columns based on the screen width
    int crossAxisCount = screenWidth > 600
        ? 3
        : 2; // 3 columns for larger screens, 2 columns for smaller screens
    return GridView.builder(
      controller: scrollController,
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
                      // Add product image at the top (from local assets)
                      Container(
                        height: 10, // Adjust height as needed to avoid overflow
                        width: double.infinity, // Full width of the container
                        child: Image.asset(
                          'assets/ZaloLogin.jpg', // Image file path
                          fit: BoxFit.cover, // Ensure the image fits properly
                        ),
                      ),
                      const SizedBox(height: 8), // Space between image and name

                      // Product name
                      Text(
                        curProduct.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4), // Space between name and price

                      // Product price
                      Text(
                        '\$${curProduct.price.toStringAsFixed(2)}',
                        style:
                            const TextStyle(fontSize: 14, color: Colors.green),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
    // return FutureBuilder<List<Product>>(
    //   future: _productsFuture,
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return const Center(child: CircularProgressIndicator());
    //     } else if (snapshot.hasError) {
    //       return Center(child: Text('Lỗi: ${snapshot.error}'));
    //     } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
    //       return const Center(
    //           child: Text('Không có sản phẩm nào để hiển thị.'));
    //     }

    //     final products = snapshot.data!;

    //     return GridView.builder(
    //       padding: const EdgeInsets.all(8.0),
    //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //         crossAxisCount: crossAxisCount, // Dynamic number of columns
    //         crossAxisSpacing: 8, // Spacing between columns
    //         mainAxisSpacing: 8, // Spacing between rows
    //         childAspectRatio: screenWidth > 600
    //             ? 4 / 3
    //             : 3 / 2, // Adjust aspect ratio for larger screens
    //       ),
    //       itemCount: products.length,
    //       itemBuilder: (context, index) {
    //         final curProduct = products[index];
    //         return InkWell(
    //           onTap: () {
    //             Navigator.push(
    //               context,
    //               MaterialPageRoute(
    //                 builder: (context) => ProductDetailScreen(curProduct: curProduct),
    //               ),
    //             );
    //           },
    //           child: Card(
    //             elevation: 4,
    //             shape: RoundedRectangleBorder(
    //               borderRadius: BorderRadius.circular(8.0),
    //             ),
    //             child: Padding(
    //               padding: const EdgeInsets.all(8.0),
    //               child: Column(
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   // Add product image at the top (from local assets)
    //                   Container(
    //                     height: 10, // Adjust height as needed to avoid overflow
    //                     width: double.infinity, // Full width of the container
    //                     child: Image.asset(
    //                       'assets/ZaloLogin.jpg', // Image file path
    //                       fit: BoxFit.cover, // Ensure the image fits properly
    //                     ),
    //                   ),
    //                   const SizedBox(height: 8), // Space between image and name

    //                   // Product name
    //                   Text(
    //                     curProduct.name,
    //                     style: const TextStyle(
    //                       fontSize: 16,
    //                       fontWeight: FontWeight.bold,
    //                     ),
    //                   ),
    //                   const SizedBox(height: 4), // Space between name and price

    //                   // Product price
    //                   Text(
    //                     '\$${curProduct.price.toStringAsFixed(2)}',
    //                     style:
    //                         const TextStyle(fontSize: 14, color: Colors.green),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ),
    //         );
    //       },
    //     );
    //   },
    // );
  }
}
