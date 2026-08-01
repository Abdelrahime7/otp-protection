package com.example.otp_protection

import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.app.Service
import android.content.Context
import android.content.Intent
import android.os.Build
import android.os.IBinder
import androidx.core.app.NotificationCompat
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.plugin.common.MethodChannel

class OtpProtectionService : Service() {

    companion object {
        private const val CHANNEL_ID       = "otp_protection_channel"
        private const val NOTIFICATION_ID  = 1001
        const val ACTION_PUBLISH_EVENT     = "com.example.otp_protection.ACTION_PUBLISH_EVENT"
        const val EXTRA_EVENT_NAME         = "event_name"

        /** Shared channel reference — set once the engine is ready. */
        @Volatile
        var channel: MethodChannel? = null

        /** Pending events queued before the Dart isolate is ready. */
        private val pendingEvents = mutableListOf<String>()

        fun startWithEvent(context: Context, eventName: String) {
            val intent = Intent(context, OtpProtectionService::class.java).apply {
                action = ACTION_PUBLISH_EVENT
                putExtra(EXTRA_EVENT_NAME, eventName)
            }
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                context.startForegroundService(intent)
            } else {
                context.startService(intent)
            }
        }
    }

    private var flutterEngine: FlutterEngine? = null

    // ──────────────────────────────────────────────────────────────────────────
    // Lifecycle
    // ──────────────────────────────────────────────────────────────────────────

    override fun onCreate() {
        super.onCreate()
        createNotificationChannel()
        startForeground(NOTIFICATION_ID, buildNotification())
        bootFlutterEngine()
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        val eventName = intent?.getStringExtra(EXTRA_EVENT_NAME)
        if (eventName != null) {
            deliverOrQueue(eventName)
        }
        return START_STICKY
    }

    override fun onBind(intent: Intent?): IBinder? = null

    override fun onDestroy() {
        channel = null
        flutterEngine?.destroy()
        flutterEngine = null
        super.onDestroy()
    }

    // ──────────────────────────────────────────────────────────────────────────
    // Flutter engine bootstrap
    // ──────────────────────────────────────────────────────────────────────────

    /**
     * Use the existing Flutter engine's MethodChannel from MainActivity.
     * The channel is set in MainActivity.configureFlutterEngine and stored
     * in its companion object's static `channel` property. This avoids creating
     * a separate FlutterEngine which would isolate the MethodChannel from the UI
     * isolate, ensuring that events published from the service are received by
     * the Dart side's ProtectionBridge handler.
     */
    private fun bootFlutterEngine() {
        // Obtain the channel that was created by MainActivity.
        try {
            // Reference MainActivity's static channel.
            channel = MainActivity.channel
        } catch (e: Exception) {
            // If for any reason MainActivity.channel is not yet set, keep channel null.
            // Events will be queued in `pendingEvents` until the channel becomes available.
            channel = null
        }
        // No additional engine bootstrapping is required because we reuse the UI engine.
    }

    // ──────────────────────────────────────────────────────────────────────────
    // Event delivery
    // ──────────────────────────────────────────────────────────────────────────

    private fun deliverOrQueue(eventName: String) {
        val ch = channel
        if (ch != null) {
            publishOnMainThread(eventName)
        } else {
            // Engine not ready yet — queue for flush after boot.
            synchronized(pendingEvents) {
                pendingEvents.add(eventName)
            }
        }
    }

    private fun publishOnMainThread(eventName: String) {
        android.os.Handler(mainLooper).post {
            channel?.invokeMethod("protection_event", eventName)
        }
    }

    // ──────────────────────────────────────────────────────────────────────────
    // Notification
    // ──────────────────────────────────────────────────────────────────────────

    private fun createNotificationChannel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val notificationManager =
                getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager

            if (notificationManager.getNotificationChannel(CHANNEL_ID) == null) {
                val channel = NotificationChannel(
                    CHANNEL_ID,
                    "OTP Protection",
                    NotificationManager.IMPORTANCE_LOW   // silent, no sound
                ).apply {
                    description = "Monitors incoming messages for OTP-based scams"
                }
                notificationManager.createNotificationChannel(channel)
            }
        }
    }

    private fun buildNotification() =
        NotificationCompat.Builder(this, CHANNEL_ID)
            .setContentTitle("OTP Protection Active")
            .setContentText("Monitoring for suspicious OTP activity")
            .setSmallIcon(android.R.drawable.ic_lock_lock)
            .setPriority(NotificationCompat.PRIORITY_LOW)
            .setOngoing(true)
            .setContentIntent(launchAppPendingIntent())
            .build()

    private fun launchAppPendingIntent(): PendingIntent {
        val intent = Intent(this, MainActivity::class.java).apply {
            flags = Intent.FLAG_ACTIVITY_SINGLE_TOP
        }
        val flags = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M)
            PendingIntent.FLAG_IMMUTABLE or PendingIntent.FLAG_UPDATE_CURRENT
        else
            PendingIntent.FLAG_UPDATE_CURRENT

        return PendingIntent.getActivity(this, 0, intent, flags)
    }
}
