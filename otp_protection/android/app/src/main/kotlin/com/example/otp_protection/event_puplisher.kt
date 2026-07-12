package com.example.otp_protection
import io.flutter.plugin.common.MethodChannel

class EventPublisher(
    private val channel: MethodChannel
) {

    
    fun publish(event: ProtectionEvent) {
    channel.invokeMethod(
        "protection_event",
        event.name
    )
}
}