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
  double lastPosition = 0;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    ref.read(listProductProvider.notifier).fetchProducts();
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (scrollController.offset > lastPosition && scrollController.offset > 0) {
      ref.read(showNaviProvider.notifier).state = false;
    } else if (scrollController.offset < lastPosition) {
      ref.read(showNaviProvider.notifier).state = true;
    }
    lastPosition = scrollController.offset;
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(listProductProvider);
    double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = screenWidth > 600 ? 3 : 2;

    return SafeArea(
      child: Scaffold(
        body: GridView.builder(
          controller: scrollController,
          padding: const EdgeInsets.all(8.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 3 / 5, // Làm ô dài hơn
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final curProduct = products[index];
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ProductDetailScreen(curProduct: curProduct),
                  ),
                );
              },
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Hiển thị ảnh sản phẩm
                    Expanded(
                      child: Container(
                        height: 180, // Đặt chiều cao cố định cho ảnh
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12.0),
                            topRight: Radius.circular(12.0),
                          ),
                          color: Colors.grey.shade200,
                        ),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12.0),
                            topRight: Radius.circular(12.0),
                          ),
                          child: Image.asset(
                            'assets/blood-pressure-monitor.jpg',
                            fit: BoxFit
                                .contain, // Ảnh vừa khít khung nhưng có thể bị cắt
                            errorBuilder: (context, error, stackTrace) {
                              return Center(
                                child: Icon(
                                  Icons.broken_image,
                                  color: Colors.grey,
                                  size: 48,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              curProduct.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '\$${curProduct.price.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.green.shade700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
