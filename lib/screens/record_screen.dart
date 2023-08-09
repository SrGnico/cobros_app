import 'package:cobros_app/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';

class RecordScreen extends StatelessWidget {
  const RecordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Record Screen')),
      bottomNavigationBar: BottomBar(currentPage: 0),
    );
  }
}