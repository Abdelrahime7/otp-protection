class MessageParser {
  OtpResult parse(String message) {
    // regex matching
    return OtpResult(containsOtp: true,
     otp: "");
  }
}
class OtpResult {
  
  final bool containsOtp;
  final String? otp;

  OtpResult({required this.containsOtp, required this.otp});
  
}