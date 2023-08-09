import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomBar extends StatefulWidget {

  final int currentPage;

  const BottomBar({super.key, required this.currentPage});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.currentPage,
      selectedItemColor:Colors.teal,
      selectedIconTheme: const IconThemeData(size: 35),
      onTap:(value) {
        context.goNamed('$value');
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.wallet),
          label: 'Registro'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.receipt_long_rounded),
          label: 'Cobro'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.price_change_outlined),
          label: 'Productos'
        )
      ],
    );
  }
}