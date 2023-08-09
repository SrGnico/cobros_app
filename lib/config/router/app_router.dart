import 'package:cobros_app/screens/add_product_screen.dart';
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
          path: 'add',
          name: 'add',
          pageBuilder: (context, state) {
            return CustomTransitionPage(
            child: AddProductScreen(), 
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
