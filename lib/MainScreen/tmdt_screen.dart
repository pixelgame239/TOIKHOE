import 'package:flutter/material.dart';
import 'package:toikhoe/MainScreen/product_detail_screen.dart';

class TMDTScreen extends StatefulWidget {
  const TMDTScreen({super.key});

  @override
  State<TMDTScreen> createState() => _TMDTScreenState();
}

class _TMDTScreenState extends State<TMDTScreen> {
    final List<Map<String, dynamic>> items = [
    {"name": "Item 1", "price": "\$20", "details": "Detail 1"},
    {"name": "Item 2", "price": "\$15", "details": "Detail 2"},
    {"name": "Item 3", "price": "\$30", "details": "Detail 3"},
    {"name": "Item 4", "price": "\$25", "details": "Detail 4"},
      {"name": "Item 1", "price": "\$20", "details": "Detail 1"},
    {"name": "Item 2", "price": "\$15", "details": "Detail 2"},
    {"name": "Item 3", "price": "\$30", "details": "Detail 3"},
    {"name": "Item 4", "price": "\$25", "details": "Detail 4"},
      {"name": "Item 1", "price": "\$20", "details": "Detail 1"},
    {"name": "Item 2", "price": "\$15", "details": "Detail 2"},
    {"name": "Item 3", "price": "\$30", "details": "Detail 3"},
    {"name": "Item 4", "price": "\$25", "details": "Detail 4"},
      {"name": "Item 1", "price": "\$20", "details": "Detail 1"},
    {"name": "Item 2", "price": "\$15", "details": "Detail 2"},
    {"name": "Item 3", "price": "\$30", "details": "Detail 3"},
    {"name": "Item 4", "price": "\$25", "details": "Detail 4"},
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
         SizedBox(
          height: MediaQuery.of(context).size.height,
           child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Number of columns
            crossAxisSpacing: 5, // Spacing between columns
            mainAxisSpacing: 5, // Spacing between rows
            childAspectRatio: 3 / 2, // Aspect ratio for grid items
                   ),
                   itemCount: items.length,
                   itemBuilder: (context, index) {
            final item = items[index];
            return InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetailScreen()));
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
                        item["name"],
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        item["price"],
                        style: TextStyle(fontSize: 14, color: Colors.green),
                      ),
                      Text(
                        item["details"],
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
            );
                   },
                 ),
         ),
      ]
    );
  }
}