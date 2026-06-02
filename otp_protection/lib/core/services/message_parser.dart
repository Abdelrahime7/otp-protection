import 'package:otp_protection/core/models/sms_message.dart';
import 'package:otp_protection/core/utils/otp_result.dart';

class MessageParser {
  static const _otpKeywords = [
    'otp',
    'verification code',
    'verification',
    'security code',
    'one-time password',
    'passcode',
    'authentication code',
    'login code',
    'code',
  ];

  static final _otpRegex = RegExp(r'\b\d{4,8}\b');

  OtpResult parse(SmsMessage sms) {
    final normalized = sms.content.toLowerCase();

    final hasKeyword = _otpKeywords.any(
      normalized.contains,
    );

    if (!hasKeyword) {
      return OtpResult(
        containsOtp: false,
        otp: null,
      );
    }

    final match = _otpRegex.firstMatch(sms.content);

    if (match == null) {
      return OtpResult(
        containsOtp: false,
        otp: null,
      );
    }

    return OtpResult(
      containsOtp: true,
      otp: match.group(0),
    );
  }
}

