import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:otp_protection/core/features/home/home_page.dart';
import 'package:otp_protection/core/features/settings/settings_page.dart';
import 'package:otp_protection/core/otp-protections/danger_warning_dialog.dart';
import 'package:otp_protection/core/otp-protections/normal_warning_dialog.dart';
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
      GoRoute(
        path: AppRoutes.showDangerWarning,
        builder: (context, state) => const DangerWarningDialog(),
      ),
 GoRoute(
        path: AppRoutes.showNormalWarning,
        builder: (context, state) => const NormalWarningDialog(),
      ),
      
    ],
  ); 
}