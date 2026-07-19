import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:otp_protection/core/features/home/home_page.dart';
import 'package:otp_protection/core/features/settings/settings_page.dart';
import 'package:otp_protection/core/routing/app_routes.dart';

class AppRouterConfig {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: AppRoutes.myHomePage,
    routes: [
      GoRoute(
        path: AppRoutes.myHomePage,
        builder: (context, state) => const HomePage(),
      ),
       GoRoute(
        path: AppRoutes.settings,
        builder: (context, state) => const SettingsPage(),
      ),
      
    ],
  ); 
}