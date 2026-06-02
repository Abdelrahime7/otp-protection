import 'dart:async';
import 'package:phone_state/phone_state.dart';

class CallDetector {
  bool _isInCall = false;
  StreamSubscription<PhoneState>? _subscription;

  /// Call this ONCE when app starts
  void init() {
    _subscription = PhoneState.stream.listen((state) {
      _isInCall = _isActiveCall(state.status);
    });
  }

  bool get isUserInCall => _isInCall;

  bool _isActiveCall(PhoneStateStatus status) {
    return status == PhoneStateStatus.CALL_STARTED ||
        status == PhoneStateStatus.CALL_INCOMING;
  }

  /// Call this when app is disposed (important for cleanup)
  void dispose() {
    _subscription?.cancel();
  }
}