import 'package:otp_protection/core/models/protection_event.dart' show ProtectionEvent;

abstract class EventSubscriber {
  void onEvent(ProtectionEvent event);
}