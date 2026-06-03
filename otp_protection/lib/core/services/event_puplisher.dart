import 'package:otp_protection/core/contracts/protection_strategy.dart';
import 'package:otp_protection/core/models/protection_event.dart';

class EventPublisher {
 final  List<EventSubscriber> _subscribers = [];

   void  subscribe(EventSubscriber subscriber) {
    _subscribers.add(subscriber);
  }

  void publish(ProtectionEvent event) {
    for (final s in _subscribers) {
      s.onEvent(event);
    }
  }
}