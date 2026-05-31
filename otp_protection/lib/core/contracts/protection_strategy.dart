import 'package:otp_protection/core/models/protection_event.dart';

abstract class EventSubscriber {
  void onEvent(ProtectionEvent event);
}