import 'package:cobros_app/models/product.dart';
import 'package:cobros_app/widgets/item/item_list.dart';
import 'package:flutter/material.dart';

class ProductList extends StatelessWidget {
  Function addProductToEditingList;
  Function deleteProductFromEditingList;

  final List<Product> list;
  final String title;
  ProductList({
    super.key, 
    required this.addProductToEditingList,
    required this.deleteProductFromEditingList,
    required this.title, 
    required this.list
  });

  @override
  Widget build(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        (title == '')?const SizedBox():
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Text(title,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: list.length,
            itemBuilder: (context, index) {
              final item = list[index];
              return ItemList(
                product: item,
                addProductToEditingList: addProductToEditingList,
                deleteProductFromEditingList: deleteProductFromEditingList,
              );
            },
          ),
        ),
      ],
    );
  }
}