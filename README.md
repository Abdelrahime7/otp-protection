# otp-protection
# ScamShield - OTP Protection Against Phone Scams

## Overview

ScamShield is a Flutter-based security application designed to protect users from social engineering attacks where fraudsters attempt to obtain One-Time Passwords (OTPs) during phone calls.

The application monitors incoming OTP messages while a phone call is active. When suspicious conditions are detected, ScamShield triggers protection mechanisms such as warnings, alerts, screen overlays, or other defensive actions to prevent users from sharing sensitive verification codes.

## Problem Statement

A common scam scenario occurs when:

1. A fraudster calls a victim.
2. The fraudster initiates a sensitive operation (bank transfer, account recovery, login verification, etc.).
3. An OTP is sent to the victim's device.
4. The fraudster asks the victim to read the OTP aloud.
5. The victim unknowingly shares the code, compromising their account.

ScamShield aims to interrupt this attack chain before the OTP is disclosed.

## User Story

**As a smartphone user,**

I want the application to detect when an OTP arrives during an active phone call,

so that I can be warned before sharing sensitive verification codes with a potential scammer.

### Example Flow

1. User is on a phone call.
2. SMS listener detects a new incoming message.
3. Message parser identifies the message as containing an OTP.
4. Call detector confirms that a call is currently active.
5. A ProtectionEvent is published.
6. Protection strategies receive the event.
7. Appropriate defensive actions are executed:

   * Warning popup
   * Alert notification
   * Full-screen protection overlay
   * Other configurable protections

## Architecture

The project follows:

* Separation of Concerns (SoC)
* Event-Driven Architecture
* Observer Pattern
* Strategy Pattern
* Clean and Modular Design

### Directory Structure

```text
lib/
├── core/
│   ├── models/
│   │   ├── sms_message.dart
│   │   └── protection_event.dart
│   │
│   ├── contracts/
│   │   └── protection_strategy.dart
│   │
│   ├── services/
│   │   ├── message_parser.dart
│   │   ├── call_detector.dart
│   │   └── event_protection_publisher.dart
│   │
│   └── utils/
│
├── features/
│   └── otp_protection/
│       ├── bloc/
│       ├── screens/
│       └── widgets/
```

## Core Components

### Call Detector

Responsible for monitoring phone call state.

Responsibilities:

* Detect active calls
* Notify interested components
* Provide current call status

### SMS Parser

Responsible for analyzing incoming SMS messages.

Responsibilities:

* Extract OTP codes
* Detect OTP-related keywords
* Determine whether a message is security-sensitive

### Event Protection Publisher

Central event bus of the system.

Responsibilities:

* Publish protection events
* Notify subscribers
* Decouple detection logic from protection logic

### Protection Event

Represents a security incident requiring intervention.

Example:

```dart
ProtectionEvent(
  type: ProtectionEventType.otpDetectedDuringCall,
  otpCode: "123456",
  timestamp: DateTime.now(),
);
```

## Protection Strategies

The system uses the Strategy Pattern to support multiple protection mechanisms.

Each strategy implements a common contract:

```dart
abstract class EventSubscriber {
  void onEvent(ProtectionEvent event);
}

```

Examples:

### Warning Strategy

Displays a warning dialog:

> Never share your OTP with anyone, even if they claim to be from your bank or a trusted organization.

### Alert Strategy

Triggers a high-priority notification.

### Screen Protection Strategy

Displays a full-screen overlay designed to interrupt scam attempts and attract the user's attention.

## Event Flow

```text
Incoming SMS
      │
      ▼
 SMS Parser
      │
      ▼
 OTP Detected?
      │
      ▼
 Call Detector
      │
      ▼
 Call Active?
      │
      ▼
 Protection Event
      │
      ▼
 Event Publisher
      │
      ▼
 ┌──────────────┬──────────────┬─────────────────┐
 │              │              │                 │
 ▼              ▼              ▼                 ▼
Warning     Alert        Screen Lock      Future Strategies
Strategy    Strategy      Strategy
```

## Design Patterns

### Observer Pattern

Used between:

* EventProtectionPublisher
* Event Subscribers

Benefits:

* Loose coupling
* Easy extensibility
* Independent protection modules

### Strategy Pattern

Used for protection mechanisms.

Benefits:

* Add new protection actions without modifying existing code
* Open/Closed Principle compliance

## Future Enhancements

* AI-powered scam risk scoring
* Detection of suspicious call behavior
* Scam caller reputation database
* Multi-language support
* Accessibility improvements
* Customizable protection rules
* Analytics dashboard

## Security Notice

ScamShield assists users in identifying potentially dangerous situations but cannot guarantee the prevention of all fraud attempts. Users should never share OTPs, verification codes, passwords, or authentication credentials with third parties.

## License

MIT License
