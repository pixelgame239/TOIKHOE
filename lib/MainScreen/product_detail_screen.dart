import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:toikhoe/MainScreen/buy_screen.dart';
import 'package:toikhoe/database/fetch_orders.dart';
import 'package:toikhoe/model/product_model.dart';
import 'package:toikhoe/riverpod/user_riverpod.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  final Product curProduct;
  const ProductDetailScreen({super.key, required this.curProduct});

  @override
  ConsumerState<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  late String ngayThem;
  final TextEditingController quantityController = TextEditingController();
  void showOrderDetail(BuildContext context, String type){
    quantityController.text = '1';
     showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16,0, 16, (MediaQuery.of(context).viewInsets.bottom + 16.0)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(child: const Image(image: AssetImage('assets/ZaloLogin.jpg'))),
                    Text(widget.curProduct.name)
                  ],
                ),
                  Row(
                  children: [
                    const Expanded(flex: 5, child: Text('Số lượng: ')),
                    Expanded(flex: 2, child: IconButton(
                      onPressed: (){
                        if(quantityController.text=='1'){
                        }
                        else{
                           quantityController.text = (int.parse(quantityController.text)-1).toString();
                        }
                    }, icon: Icon(Icons.arrow_circle_down_outlined))),
                    Expanded(
                      flex: 2,
                      child: TextField(
                        maxLength: 5,
                        textAlign: TextAlign.center,
                        controller: quantityController,
                        keyboardType: TextInputType.number,
                        onChanged: (value){
                          if(quantityController.text.isEmpty||quantityController.text=='0'){
                              quantityController.text = '1';
                          }
                          if(quantityController.text.contains(',')||quantityController.text.contains('.')||quantityController.text.contains(' ')||quantityController.text.contains('-')){
                            quantityController.text='1';
                          }
                        },
                      ),
                    ),
                    Expanded(flex: 2, child: IconButton(onPressed: (){
                      if(quantityController.text!='99999'){
                          quantityController.text = (int.parse(quantityController.text)+1).toString();
                      }
                    }, icon: Icon(Icons.arrow_circle_up_outlined))),
                  ],
                ),
                if(type=='Cart')...[
                ElevatedButton(onPressed: () async{
                  int intQuantity = int.parse(quantityController.text);
                  int userID = ref.read(userProvider).first.userId;
                  try{
                    await addOrder(userID, widget.curProduct.productID, intQuantity, widget.curProduct.price, (widget.curProduct.price*intQuantity), 0, '', ref);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Thêm đơn hàng thành công')));
                    Navigator.pop(context);
                  } catch(error){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Lỗi khi thêm đơn hàng, vui lòng thử lại sau')));
                  }
                }, child: const Text('Đặt mua'))
                ]
                else...[
                  ElevatedButton(onPressed: (){
                    int intQuantity = int.parse(quantityController.text);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>BuyScreen(buyProduct: widget.curProduct, quantity: intQuantity)));
                  }, child: const Text('Mua ngay'))
                ]
              ],
            ),
          ),
        );
      },
    );
  }
  @override
  void initState(){
    ngayThem = DateFormat('dd/MM/yyyy').format(widget.curProduct.createdAt!);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.curProduct.name),
      // ),
      resizeToAvoidBottomInset: true,
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
                    showOrderDetail(context, 'Cart');
                  }, 
                  icon: Icon(Icons.add_shopping_cart)),
                TextButton(onPressed: (){
                  showOrderDetail(context, 'Buy');
                }, child: const Text('Mua hàng'))
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
