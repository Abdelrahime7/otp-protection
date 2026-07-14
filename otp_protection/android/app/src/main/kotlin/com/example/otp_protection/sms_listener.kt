
package com.example.otp_protection

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.provider.Telephony

class SmsReceiver : BroadcastReceiver() {

    override fun onReceive(
        context: Context,
        intent: Intent
    ) {
        if (intent.action != Telephony.Sms.Intents.SMS_RECEIVED_ACTION) return

        val messages = Telephony.Sms.Intents.getMessagesFromIntent(intent)

        val parser        = SmsParser()
        val callDetector  = CallDetector()

        messages.forEach { sms ->
            val body = sms.messageBody ?: return@forEach

            // Determine the event without needing a channel yet.
            if (!parser.containsOtp(body)) return@forEach

            val event = if (callDetector.isUserInCall(context)) {
                ProtectionEvent.otpReceivedDuringCall
            } else {
                ProtectionEvent.otpDetected
            }

            // Priority 1: app is in foreground — use MainActivity's channel.
            val mainChannel = MainActivity.channel
            if (mainChannel != null) {
                EventPublisher(mainChannel).publish(event)
                return@forEach
            }

            // Priority 2: service is already running — use its channel.
            val serviceChannel = OtpProtectionService.channel
            if (serviceChannel != null) {
                EventPublisher(serviceChannel).publish(event)
                return@forEach
            }

            // Priority 3: nothing is alive — start the service; it will
            // boot its own FlutterEngine and deliver the event once ready.
            OtpProtectionService.startWithEvent(context, event.name)
        }
    }
}