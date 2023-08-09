import 'package:cobros_app/models/product.dart';
import 'package:cobros_app/services/database_delper.dart';
import 'package:cobros_app/widgets/bottom_bar.dart';
import 'package:cobros_app/widgets/future_product_list.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProductScreen extends StatefulWidget {

  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {

Future<List<Product>?> list = DatabaseHelper.getAllProducts();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 150,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Productos',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Todos',
              maxLines: 1,
              style: TextStyle(
                fontSize: 90,
                fontWeight: FontWeight.w500
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0,50,10,0),
            child: IconButton(
              onPressed: () {}, 
              icon: const Padding(
                padding: EdgeInsets.all(5.0),
                child: Icon(
                  Icons.sort_by_alpha_rounded,
                  color: Colors.teal,
                  size: 65,
                ),
              )
            ),
          ),
        ],
      ),
      body: const FutureProductList(),
      floatingActionButton: 
        IconButton(
          onPressed: () {
            context.goNamed('add');
          }, 
          icon: const Padding(
            padding: EdgeInsets.all(5.0),
            child: Icon(
              Icons.add,
              color: Colors.teal,
              size: 65,
              ),
            )
          ),
      bottomNavigationBar: const BottomBar(currentPage: 2),
    );
  }
}