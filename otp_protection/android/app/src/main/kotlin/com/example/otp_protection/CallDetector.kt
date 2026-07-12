

package com.example.otp_protection
import android.content.Context
import android.telephony.TelephonyManager

class CallDetector {

    fun isUserInCall(
        context: Context
    ): Boolean {

        val telephonyManager =
            context.getSystemService(
                Context.TELEPHONY_SERVICE
            ) as TelephonyManager

        return when (
            telephonyManager.callState
        ) {

            TelephonyManager.CALL_STATE_OFFHOOK,
            TelephonyManager.CALL_STATE_RINGING -> true

            else -> false
        }
    }
}