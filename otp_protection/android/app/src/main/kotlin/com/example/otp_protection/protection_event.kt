package com.example.otp_protection

enum class ProtectionEvent {
  otpDetected,
  otpReceivedDuringCall,
  suspiciousActivity,
}