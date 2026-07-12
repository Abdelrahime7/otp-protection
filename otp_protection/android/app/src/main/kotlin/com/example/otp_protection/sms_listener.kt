
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

        if (
            intent.action !=
            Telephony.Sms.Intents.SMS_RECEIVED_ACTION
        ) {
            return
        }

        val channel = MainActivity.channel ?: return

        val engine =
            ProtectionEngine(
                parser = SmsParser(),
                callDetector = CallDetector(),
                publisher = EventPublisher(channel)
            )

        val messages =
            Telephony.Sms.Intents
                .getMessagesFromIntent(intent)

        messages.forEach { sms ->

            val body =
                sms.messageBody ?: return@forEach

            engine.handleSms(
                context,
                body
            )
        }
    }
}