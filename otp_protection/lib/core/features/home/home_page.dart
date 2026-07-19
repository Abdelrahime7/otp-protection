import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0F172A),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 237, 239, 243),
        elevation: 0,
        title: const Text("OTP Protection"),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              context.push('/settings');
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.shield_outlined,
                    color: Color(0xff3B82F6),
                    size: 70,
                  ),
                ),
              ),
        
              const SizedBox(height: 32),
        
              const Text(
                "Welcome",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
        
              const SizedBox(height: 10),
        
              const Text(
                "OTP Protection keeps your verification codes secure by "
                "monitoring incoming SMS messages in the background.\n\n"
                "The protection service continues running even when the app "
                "is minimized. You can change this behavior at any time from "
                "the Settings page.",
                style: TextStyle(
                  color: Colors.white70,
                  height: 1.6,
                  fontSize: 16,
                ),
              ),
        
              const SizedBox(height: 30),
        
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xff1E293B),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Colors.amber,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        "For maximum protection, keep the background service enabled.",
                        style: TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}