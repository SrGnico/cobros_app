import 'package:cobros_app/models/cart.dart';
import 'package:flutter/material.dart';

class RecordItem extends StatefulWidget {
  final Cart cart;
  const RecordItem({
    super.key,
    required this.cart
    });

  @override
  State<RecordItem> createState() => _RecordItemState();
}

class _RecordItemState extends State<RecordItem> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Row(
      children: [
        Text(widget.cart.fecha),
        const SizedBox(width: 50,),
        Text(widget.cart.perfumeriaTotal),
      ],
    ));
  }
}