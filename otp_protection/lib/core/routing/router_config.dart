import 'package:go_router/go_router.dart';
import 'package:otp_protection/core/routing/app_routes.dart';
import 'package:otp_protection/main.dart';

class AppRouterConfig {

  static GoRouter router = GoRouter(
    initialLocation: AppRoutes.myHomePage,
    routes: [
    GoRoute(path: AppRoutes.myHomePage,
     builder: (context, state) => const MyHomePage()),
    ]
  ); 
}