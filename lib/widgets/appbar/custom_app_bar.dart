import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {

  final String title;
  final String subTitle;
  final Widget actions;

  const CustomAppBar({
    super.key, 
    required this.title, 
    required this.subTitle, 
    required this.actions
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
  
  @override
  Size get preferredSize => const Size.fromHeight(150);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(150),
      child: AppBar(
        scrolledUnderElevation: 0,
        toolbarHeight: 150,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              widget.subTitle,
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
            child: widget.actions
          ),
        ],
      ),
      );
  }
}