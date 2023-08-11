import 'package:cobros_app/models/product.dart';
import 'package:cobros_app/screens/add_or_edit_product_screen.dart';
import 'package:cobros_app/screens/cash_screen.dart';
import 'package:cobros_app/screens/product_screen.dart';
import 'package:cobros_app/screens/record_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: '1',
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          child: const CashScreen(), 
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: CurveTween(curve: Curves.fastOutSlowIn).animate(animation),
              child: child,
            );
          },
        );
      },
    ),
    GoRoute(
      path: '/record',
      name: '0',
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          child: const RecordScreen(), 
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: CurveTween(curve: Curves.fastOutSlowIn).animate(animation),
              child: child,
            );
          },
        );
      },
    ),
    GoRoute(
      path: '/product',
      name: '2',
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          child: const ProductScreen(), 
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: CurveTween(curve: Curves.fastOutSlowIn).animate(animation),
              child: child,
            );
          },
        );
      },
      routes: [
        GoRoute(
          path: 'addOrEdit',
          name: 'addOrEdit',
  
          pageBuilder: (context, state) {
            Product product =  state.extra as Product;
            return CustomTransitionPage(
            child: AddOrEditProductScreen(editingProduct: product ), 
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: CurveTween(curve: Curves.fastOutSlowIn).animate(animation),
                  child: child,
                );
              },
            );
          },
        )
      ]
    ),
  ],
  

);
