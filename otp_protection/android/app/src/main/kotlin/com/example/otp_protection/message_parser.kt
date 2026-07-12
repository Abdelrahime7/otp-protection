
package com.example.otp_protection
class SmsParser {

    private val otpKeywords = listOf(
        "otp",
        "verification code",
        "verification",
        "security code",
        "one-time password",
        "passcode",
        "authentication code",
        "login code"
    )

    private val otpRegex =
        Regex("\\b\\d{4,8}\\b")

    fun containsOtp(
        message: String
    ): Boolean {

        val normalized =
            message.lowercase()

        val hasKeyword =
            otpKeywords.any {
                normalized.contains(it)
            }

        if (!hasKeyword) {
            return false
        }

        return otpRegex.containsMatchIn(message)
    }
}
