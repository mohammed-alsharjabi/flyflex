# FlyFlex — Unsold Airline Seat Marketplace

A polished Flutter marketplace concept for discovering discounted unsold airline seats, selecting passengers and seats, completing payment flows, and managing bookings and tickets.

> **Project type:** Advanced product prototype  
> **Status:** Frontend and application architecture implemented; live airline and payment integrations are not included

## العربية

FlyFlex نموذج منتج متقدم لسوق مقاعد الطيران غير المباعة. يركز المشروع على تجربة الحجز الكاملة، التنظيم المعماري، ودعم العربية والإنجليزية. البيانات الحالية محلية لأغراض العرض والتطوير، وليست مرتبطة بمزود رحلات حقيقي.

## Features

- Authentication and onboarding
- Arabic and English localization
- Domestic and international flight discovery
- Flight details and fare presentation
- Passenger management
- Seat selection
- Payment flow UI and state handling
- Bookings, tickets, profile, and notifications
- Responsive RTL and LTR experience

## Tech Stack

- Flutter and Dart
- Flutter BLoC / Cubit
- GetIt
- GoRouter
- Dio-ready networking layer
- SharedPreferences
- Flutter Animate
- Cached Network Image and Shimmer

## Architecture

FlyFlex uses a feature-first layered structure. Each major feature contains a data source, repository contract, repository implementation, Cubit, and presentation layer.

```text
lib/
├── core/
│   ├── di/
│   ├── localization/
│   ├── router/
│   └── theme/
├── features/
│   ├── auth/
│   ├── flights/
│   ├── flight_details/
│   ├── passengers/
│   ├── seat_selection/
│   ├── payment/
│   ├── bookings/
│   ├── tickets/
│   ├── profile/
│   └── notifications/
└── main.dart
```

## Current Data Scope

The repository currently uses local data sources to model complete user flows. This keeps the prototype deterministic and easy to review. Production readiness would require:

- Airline inventory API integration
- Real authentication backend
- PCI-compliant payment provider integration
- Booking confirmation and ticket issuance services
- Monitoring, analytics, and automated tests

## Running Locally

```bash
flutter pub get
flutter run
```

## Repository Note

The `crashcart` repository contains an earlier duplicate of this codebase. FlyFlex is the canonical repository for this project.

## Author

**Mohammed Alsharjabi**  
Flutter Developer and Founder of TechnoVizen
