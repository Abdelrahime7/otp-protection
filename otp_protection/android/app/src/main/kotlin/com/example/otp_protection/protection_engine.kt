package com.example.otp_protection
import android.content.Context

class ProtectionEngine(
    private val parser: SmsParser,
    private val callDetector: CallDetector,
    private val publisher: EventPublisher
) {

    fun handleSms(
        context: Context,
        message: String
    ) {

        if (!parser.containsOtp(message)) {
            return
        }

        val event =
            if (
                callDetector.isUserInCall(
                    context
                )
            ) {
                ProtectionEvent.otpReceivedDuringCall
            } else {
                ProtectionEvent.otpDetected
            }

        publisher.publish(event)
    }
}
