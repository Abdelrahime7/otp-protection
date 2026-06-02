

import 'package:telephony/telephony.dart';

class SmsListener {
  final Telephony _telephony = Telephony.instance;
  final void Function(String message) onMessage;

  SmsListener({required this.onMessage});

  void start() {
    _telephony.listenIncomingSms(
      onNewMessage: (msg) {
        onMessage(msg.body ?? "");
      },
    );
  }
}