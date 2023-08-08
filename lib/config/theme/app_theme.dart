import 'package:flutter/material.dart';

class AppTheme {

  ThemeData theme(){
    return ThemeData(
      useMaterial3: true,
    );

  }

  Color buttonColor(){
    return const Color.fromARGB(255, 191, 169, 88);
  }

  Color primaryColor(){
    return const Color.fromARGB(255, 217, 217, 217);
  }

  Color secondaryColor(){
    return const Color.fromARGB(255, 194, 194, 194);
  }

  Color blackColor(){
    return const Color.fromARGB(255, 15, 15, 15);
  }

  Color greenColor(){
    return const Color.fromARGB(255, 29, 130, 27);
  }

  Color redColor(){
    return const Color.fromARGB(255, 168, 5, 5);
  }
}