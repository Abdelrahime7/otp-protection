import 'package:flutter/services.dart';
import 'package:otp_protection/core/otp-protections/screen_warning.dart';
import 'package:otp_protection/core/routing/router_config.dart';

class ProtectionBridge {
  static const _channel =
      MethodChannel('protection/channel');

  void init() {
    _channel.setMethodCallHandler((call) async {

      if (call.method == "protection_event") {

        final event = call.arguments as String?;
        if (event != null) {
          _handle(event);
        }
      }
    });
  }

  void _handle(String event) {
    final context = AppRouterConfig.navigatorKey.currentContext;
    if (context == null) return;

    if (event == "otpReceivedDuringCall") {
      ScreenWarning.showDangerWarning(context);
    }

    if (event == "otpDetected") {
      ScreenWarning.showNormalWarning(context);
    }
  }
}