import 'package:cobros_app/models/product.dart';
import 'package:cobros_app/widgets/product_cart_item.dart';
import 'package:flutter/material.dart';

class ProductList extends StatefulWidget {
  final List<Product> list;
  final String title;
  const ProductList({super.key, required this.title, required this.list});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        (widget.title == '')?const SizedBox():
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Text(widget.title,
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
            itemCount: widget.list.length,
            itemBuilder: (context, index) {
              final item = widget.list[index];
              return ProductCartItem(product: item);
            },
          ),
        ),
      ],
    );
  }
}