import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'catalog_controller.dart';

class CatalogScreen extends GetView<CatalogController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Catalog")),
      body: GridView.builder(
        padding: EdgeInsets.all(12),
        itemCount: controller.items.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemBuilder: (_, index) {
          final item = controller.items[index];
          return CatalogItemCard(item: item);
        },
      ),
    );
  }
}

class CatalogItemCard extends StatelessWidget {
  final Map<String, String> item;

  const CatalogItemCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFF0A2A4D)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Image.asset(item['image']!, width: 200, height: 80)),
          SizedBox(height: 8),
          Text(
            'Tag #${item['tag']}',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          Text(item['desc']!, maxLines: 2, overflow: TextOverflow.ellipsis),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                alignment: Alignment.bottomLeft,
                padding: EdgeInsets.fromLTRB(4, 4, 3, 5),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 82, 79, 79),

                  borderRadius: BorderRadius.circular(15),
                ),
                width: 80,
                height: 25,
                child: Text(
                  item['price']!,
                  style: TextStyle(
                    fontSize: 10,
                    color: Color.fromARGB(255, 255, 246, 230),
                  ),
                ),
              ),
              SizedBox(width: 3),
              ElevatedButton(
                onPressed: () {
                  Get.find<CatalogController>().openAddressBottomSheet();
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                child: Text("Buy", style: TextStyle(color: Colors.black)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
