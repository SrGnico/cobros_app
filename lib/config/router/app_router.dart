import 'package:cobros_app/screens/cash_screen.dart';
import 'package:cobros_app/screens/product_screen.dart';
import 'package:cobros_app/screens/record_screen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: '1',
      builder: (context, state) => const CashScreen(),
    ),
    GoRoute(
      path: '/record',
      name: '0',
      builder: (context, state) => const RecordScreen(),
    ),
    GoRoute(
      path: '/product',
      name: '2',
      builder: (context, state) => const ProductScreen(),
   ),
  ],
  

);
