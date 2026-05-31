class SmsMessage {
  final String sender;
  final String content;
  final DateTime receivedAt;

  SmsMessage({
    required this.sender,
    required this.content,
    required this.receivedAt,
  });
}