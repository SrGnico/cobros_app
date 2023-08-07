import 'package:cobros_app/screens/cash_screen.dart';
import 'package:cobros_app/screens/product_screen.dart';
import 'package:cobros_app/screens/record_screen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const CashScreen(),
      routes: [
        GoRoute(
          path: 'record',
          name: 'record',
          builder: (context, state) => const RecordScreen(),
        ),
        GoRoute(
          path: 'product',
          name: 'product',
          builder: (context, state) => const ProductScreen(),
        ),
      ]
    )
  ]
  
);