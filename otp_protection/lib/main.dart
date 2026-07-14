import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:otp_protection/core/services/prtection_pridge.dart';
import 'package:otp_protection/core/routing/router_config.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ProtectionBridge().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      child: MaterialApp.router(
        routerConfig: AppRouterConfig.router,
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:Text('Welcome to OTP-protection v1.0',
        )
      ) ,
    );
  }
  
}