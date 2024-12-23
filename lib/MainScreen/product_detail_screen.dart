import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:toikhoe/model/product_model.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product curProduct;
  const ProductDetailScreen({super.key, required this.curProduct});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late String ngayThem;
  @override
  void initState(){
    ngayThem = DateFormat('dd/MM/yyyy').format(widget.curProduct.createdAt);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.curProduct.name),
      // ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
           Container(
             height: MediaQuery.of(context).size.height * 0.5, // Set the height for the image
            child: Stack(
            children: [
              // Background Image
              Positioned(
                top: 0, 
                left: 20,
                right: 20,
                bottom: 0,
                child: Container(
                  width: double.infinity,
                  child: Image.asset(
                    'assets/ZaloLogin.jpg',
                    fit: BoxFit.contain,// Makes the image cover the container area
                  ),
                ),
              ),
              // Back Button in the top-left corner
              Positioned(
                left: 10, // Add some padding from the left edge
                top: 20, // Add some padding from the top edge (to avoid overlap with status bar)
                child: IconButton.filledTonal(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back, color: Colors.black,),// Optional: change the color of the icon
                ),
              ),
            ],
          ),
           ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: (){

                  }, 
                  icon: Icon(Icons.add_shopping_cart)),
                TextButton(onPressed: (){}, child: Text('Mua hàng'))
              ],
            ),
            ListTile(enabled: false, title: Text(widget.curProduct.name, style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),)),
            ListTile(
              enabled: false,
              leading: Icon(Icons.my_library_books),
              title: Text(widget.curProduct.description,
              maxLines: 5),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: ListTile(enabled: false, leading: Icon(CupertinoIcons.cube_box_fill), title: Text('Còn: ${widget.curProduct.stock}'))),
                Expanded(child: ListTile(enabled:false, leading: Icon(CupertinoIcons.calendar_circle_fill), title: Text('Ngày thêm:'), subtitle: Text(ngayThem), horizontalTitleGap: 5,))
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Giá: ${widget.curProduct.price}', style: TextStyle(color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold),),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
