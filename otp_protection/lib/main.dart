import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:otp_protection/core/models/sms_message.dart';
import 'package:otp_protection/core/prtection_srategies/yellowarning.dart';
import 'package:otp_protection/core/routing/router_config.dart';
import 'package:otp_protection/core/services/call_detector.dart';
import 'package:otp_protection/core/services/event_puplisher.dart';
import 'package:otp_protection/core/services/message_parser.dart';
import 'package:otp_protection/core/services/protection%20_engine.dart';


void main() {
 WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      child: MaterialApp.router(
          routerConfig: AppRouterConfig.router,
          ),
    );
   
  }
}

// ignore: non_constant_identifier_names
class MyHomePage extends  StatelessWidget {


  const MyHomePage();

 void test (){
  EventPublisher publisher = EventPublisher();
  Yellowarning warning = Yellowarning();
  
  publisher.subscribe(warning);
  ProtectionEngine engine = ProtectionEngine(parser:MessageParser(), 
  callDetector:CallDetector(), publisher:publisher);
   SmsMessage sms = SmsMessage(content: "Your OTP is 1234",
    sender: "baridi mob", 
    receivedAt: DateTime(2020,9,9) );
    
     engine.handleSms(sms);
 } 
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
       Center(child:
        ElevatedButton(onPressed:test, child: Text("Test"),)
       )

    );
  }
}
