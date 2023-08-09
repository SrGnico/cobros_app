import 'package:cobros_app/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

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
              onPressed: () {
                
              }, 
              icon: const Padding(
                padding: EdgeInsets.all(5.0),
                child: Icon(
                  Icons.sort_rounded,
                  color: Colors.teal,
                  size: 65,
                ),
              )
            ),
          ),
        ],
      ),
      body: const Center(child: Text('Product Screen')),
      bottomNavigationBar: const BottomBar(currentPage: 2),
    );
  }
}