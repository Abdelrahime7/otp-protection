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

  void _simulateWorkflow(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      backgroundColor: Colors.grey.shade900,
      builder: (bottomSheetContext) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text(
                "Simulate Workflow Scenario",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                "Select a scenario to trigger the method channel handler:",
                style: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 13.sp,
                ),
              ),
              SizedBox(height: 24.h),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  padding: EdgeInsets.all(12.r),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.shield_outlined, color: Colors.blue),
                ),
                title: const Text(
                  "Normal: OTP Detected",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "Simulates detecting an OTP from SMS in standard mode.",
                  style: TextStyle(color: Colors.grey.shade400),
                ),
                onTap: () {
                  Navigator.pop(bottomSheetContext);
                  _triggerPlatformEvent("otpDetected");
                },
              ),
              SizedBox(height: 16.h),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  padding: EdgeInsets.all(12.r),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.phone_locked_outlined, color: Colors.red),
                ),
                title: const Text(
                  "Danger: OTP During Active Call",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "Simulates receiving an OTP while user is on a phone call.",
                  style: TextStyle(color: Colors.grey.shade400),
                ),
                onTap: () {
                  Navigator.pop(bottomSheetContext);
                  _triggerPlatformEvent("otpReceivedDuringCall");
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}

  void _triggerPlatformEvent(String eventName) {
    const codec = StandardMethodCodec();
    final data = codec.encodeMethodCall(
      MethodCall('protection_event', eventName),
    );
    ServicesBinding.instance.defaultBinaryMessenger.handlePlatformMessage(
      'protection/channel',
      data,
      (ByteData? response) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("OTP Protection Demo"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.security_rounded,
              size: 80.r,
              color: Colors.greenAccent,
            ),
            SizedBox(height: 24.h),
            Text(
              "Active Protection Running",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              "Listening for OTP and call state...",
              style: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 48.h),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent.shade700,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
              onPressed: () => _simulateWorkflow(context),
              icon: const Icon(Icons.bug_report_outlined),
              label: Text(
                "Trigger Test Scenarios",
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
