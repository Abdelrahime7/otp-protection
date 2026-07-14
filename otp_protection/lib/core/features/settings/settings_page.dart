import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _callDetection   = true;
  bool _smsMonitoring   = true;
  bool _backgroundGuard = true;
  bool _vibrationAlert  = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E1A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: Colors.white70),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Settings',
          style: GoogleFonts.outfit(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        children: [
          _sectionLabel('Protection'),
          _toggleTile(
            icon: Icons.phone_in_talk_rounded,
            iconColor: const Color(0xFFEF5350),
            title: 'Call Detection',
            subtitle: 'Warn when OTP arrives during a live call',
            value: _callDetection,
            onChanged: (v) => setState(() => _callDetection = v),
          ),
          _toggleTile(
            icon: Icons.sms_rounded,
            iconColor: const Color(0xFF42A5F5),
            title: 'SMS Monitoring',
            subtitle: 'Scan incoming messages for OTP patterns',
            value: _smsMonitoring,
            onChanged: (v) => setState(() => _smsMonitoring = v),
          ),
          _toggleTile(
            icon: Icons.shield_rounded,
            iconColor: const Color(0xFF66BB6A),
            title: 'Background Guard',
            subtitle: 'Keep protection active when app is closed',
            value: _backgroundGuard,
            onChanged: (v) => setState(() => _backgroundGuard = v),
          ),
          SizedBox(height: 8.h),
          _sectionLabel('Alerts'),
          _toggleTile(
            icon: Icons.vibration_rounded,
            iconColor: const Color(0xFFFFA726),
            title: 'Vibration Alert',
            subtitle: 'Vibrate device when a threat is detected',
            value: _vibrationAlert,
            onChanged: (v) => setState(() => _vibrationAlert = v),
          ),
          SizedBox(height: 8.h),
          _sectionLabel('About'),
          _infoTile(
            icon: Icons.info_outline_rounded,
            title: 'Version',
            trailing: 'v1.0.0',
          ),
          _infoTile(
            icon: Icons.security_rounded,
            title: 'Protection Engine',
            trailing: 'Active',
            trailingColor: const Color(0xFF66BB6A),
          ),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Helpers
  // ─────────────────────────────────────────────────────────────────────────

  Widget _sectionLabel(String label) => Padding(
        padding: EdgeInsets.only(left: 4.w, top: 16.h, bottom: 8.h),
        child: Text(
          label.toUpperCase(),
          style: GoogleFonts.inter(
            color: Colors.white38,
            fontSize: 11.sp,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.4,
          ),
        ),
      );

  Widget _toggleTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) =>
      Container(
        margin: EdgeInsets.only(bottom: 10.h),
        decoration: BoxDecoration(
          color: const Color(0xFF141929),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: Colors.white.withOpacity(0.06)),
        ),
        child: ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
          leading: Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(icon, color: iconColor, size: 22.r),
          ),
          title: Text(
            title,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: GoogleFonts.inter(
              color: Colors.white38,
              fontSize: 12.sp,
            ),
          ),
          trailing: Switch(
            value: value,
            onChanged: onChanged,
            activeColor: iconColor,
            trackColor: WidgetStateProperty.resolveWith(
              (states) => states.contains(WidgetState.selected)
                  ? iconColor.withOpacity(0.3)
                  : Colors.white12,
            ),
          ),
        ),
      );

  Widget _infoTile({
    required IconData icon,
    required String title,
    required String trailing,
    Color? trailingColor,
  }) =>
      Container(
        margin: EdgeInsets.only(bottom: 10.h),
        decoration: BoxDecoration(
          color: const Color(0xFF141929),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: Colors.white.withOpacity(0.06)),
        ),
        child: ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
          leading: Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.07),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(icon, color: Colors.white54, size: 22.r),
          ),
          title: Text(
            title,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          trailing: Text(
            trailing,
            style: GoogleFonts.inter(
              color: trailingColor ?? Colors.white38,
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
}
