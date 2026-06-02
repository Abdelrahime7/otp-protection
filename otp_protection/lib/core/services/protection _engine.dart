import 'package:otp_protection/core/models/protection_event.dart';
import 'package:otp_protection/core/models/sms_message.dart';
import 'package:otp_protection/core/services/call_detector.dart';
import 'package:otp_protection/core/services/event_puplisher.dart';
import 'package:otp_protection/core/services/message_parser.dart';

class ProtectionEngine {
  final MessageParser parser;
  final CallDetector callDetector;
  final EventPublisher publisher;

  ProtectionEngine({
    required this.parser,
    required this.callDetector,
    required this.publisher,
  });

  void handleSms(SmsMessage sms) {
    final result = parser.parse(sms);

    if (!result.containsOtp) return;

    final event = callDetector.isUserInCall
        ? ProtectionEvent.otpReceivedDuringCall
        : ProtectionEvent.otpDetected;

    publisher.publish(event);
  }
}