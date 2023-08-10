import 'package:cobros_app/models/product.dart';
import 'package:cobros_app/widgets/bottom_bar.dart';
import 'package:cobros_app/widgets/product_list.dart';
import 'package:flutter/material.dart';

class CashScreen extends StatefulWidget {


  const CashScreen({super.key});

  @override
  State<CashScreen> createState() => _CashScreenState();
}

class _CashScreenState extends State<CashScreen> {
  int total = 0;
  List<Product> cart = [];

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        toolbarHeight: 150,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Cobros',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              '\$ $total',
              maxLines: 1,
              style: const TextStyle(
                fontSize: 80,
                fontWeight: FontWeight.w500
              ),
            ),
          ],
        ),

        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0,50,10,0),
            child: IconButton(
              onPressed: () {
                
              }, 
              icon: const Padding(
                padding: EdgeInsets.all(5.0),
                child: Icon(
                  Icons.qr_code_scanner_rounded,
                  color: Colors.teal,
                  size: 65,
                ),
              )
            ),
          ),
        ],
      ),



      body:ProductList(title: 'Carrito', list: cart),
      floatingActionButton: 
        IconButton(
          onPressed: () {
              
          }, 
        icon: const Padding(
          padding: EdgeInsets.all(5.0),
          child: Icon(
            Icons.shopping_cart_checkout_rounded,
            color: Colors.teal,
            size: 65,
            ),
          )
        ),
      bottomNavigationBar: const BottomBar(currentPage: 1),
    );
  }
}
