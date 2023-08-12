import 'package:flutter/material.dart';

class Button extends StatelessWidget {

  final dynamic condition;
  final VoidCallback trueOnPressed;
  final VoidCallback falseOnPressed;
  final IconData trueIcon;
  final IconData falseIcon;
  final Color trueColor;
  final Color falseColor;


  const Button({
    super.key, 
    this.condition, 
    required this.trueOnPressed, 
    required this.falseOnPressed, 
    required this.trueIcon, 
    required this.falseIcon, 
    required this.trueColor, 
    required this.falseColor});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: IconButton.styleFrom(backgroundColor: Colors.teal),
      onPressed: condition
        ? trueOnPressed
        :falseOnPressed,
      icon: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Icon(
          condition
          ? trueIcon
          : falseIcon,
          color: condition
          ? trueColor
          : falseColor,
          size: 65,
        ),
      ),
    );
  }
}