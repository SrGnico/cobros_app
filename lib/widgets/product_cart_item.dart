import 'package:cobros_app/models/category_colors.dart';
import 'package:cobros_app/models/category_icons.dart';
import 'package:cobros_app/models/product.dart';
import 'package:flutter/material.dart';

class ProductCartItem extends StatelessWidget {
  final Product product;

  final colores = CategoryColor.colores;
  final icons = CategoryIcon.icons;


  ProductCartItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {

    // TODO: BOTONES Y EDICION
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  color: colores[product.categoria],
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Icon(icons[product.categoria],
                    color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.descripcion,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 25
                  ),
                  ),
                  Text(product.categoria,
                  style: const TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 20
                  ),  
                  )
                ],
              ),
              const Spacer(),
              Text(
                '+ \$ ${product.precio}',
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 30
                ),
              )
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Divider(height: 0.1),
        )
      ],
    );
  }
}