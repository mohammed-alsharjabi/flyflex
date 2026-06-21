import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/ui/screens/splash_screen.dart';
import '../../features/auth/ui/screens/login_screen.dart';
import '../../features/onboarding/ui/screens/onboarding_screen.dart';
import '../../features/home/ui/screens/home_screen.dart';
import '../../features/cities/ui/screens/cities_screen.dart';
import '../../features/flights/ui/screens/domestic_flights_screen.dart';
import '../../features/flights/ui/screens/international_flights_screen.dart';
import '../../features/flights/ui/screens/available_flights_screen.dart';
import '../../features/flight_details/ui/screens/flight_details_screen.dart';
import '../../features/passengers/ui/screens/passenger_details_screen.dart';
import '../../features/seat_selection/ui/screens/seat_selection_screen.dart';
import '../../features/payment/ui/screens/payment_screen.dart';
import '../../features/tickets/ui/screens/ticket_screen.dart';
import '../../features/bookings/ui/screens/my_bookings_screen.dart';
import '../../features/profile/ui/screens/profile_screen.dart';
import '../../features/notifications/ui/screens/notifications_screen.dart';
import '../../features/flights/data/models/flight_model.dart';

abstract final class AppRoutes {
  static const splash = '/';
  static const onboarding = '/onboarding';
  static const login = '/login';
  static const home = '/home';
  static const cities = '/cities';
  static const domesticFlights = '/flights/domestic';
  static const internationalFlights = '/flights/international';
  static const availableFlights = '/flights/available';
  static const flightDetails = '/flight-details';
  static const passengerDetails = '/passenger-details';
  static const seatSelection = '/seat-selection';
  static const payment = '/payment';
  static const ticket = '/ticket';
  static const myBookings = '/bookings';
  static const profile = '/profile';
  static const notifications = '/notifications';
}

final appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      pageBuilder: (context, state) =>
          _buildPage(state, const SplashScreen()),
    ),
    GoRoute(
      path: AppRoutes.onboarding,
      pageBuilder: (context, state) =>
          _buildPage(state, const OnboardingScreen()),
    ),
    GoRoute(
      path: AppRoutes.login,
      pageBuilder: (context, state) =>
          _buildPage(state, const LoginScreen()),
    ),
    GoRoute(
      path: AppRoutes.home,
      pageBuilder: (context, state) =>
          _buildPage(state, const HomeScreen()),
    ),
    GoRoute(
      path: AppRoutes.cities,
      pageBuilder: (context, state) {
        final type = state.uri.queryParameters['type'] ?? 'domestic';
        return _buildPage(state, CitiesScreen(flightType: type));
      },
    ),
    GoRoute(
      path: AppRoutes.domesticFlights,
      pageBuilder: (context, state) =>
          _buildPage(state, const DomesticFlightsScreen()),
    ),
    GoRoute(
      path: AppRoutes.internationalFlights,
      pageBuilder: (context, state) =>
          _buildPage(state, const InternationalFlightsScreen()),
    ),
    GoRoute(
      path: AppRoutes.availableFlights,
      pageBuilder: (context, state) {
        final from = state.uri.queryParameters['from'] ?? '';
        final to = state.uri.queryParameters['to'] ?? '';
        return _buildPage(
          state,
          AvailableFlightsScreen(fromCode: from, toCode: to),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.flightDetails,
      pageBuilder: (context, state) {
        final flight = state.extra as FlightModel;
        return _buildPage(state, FlightDetailsScreen(flight: flight));
      },
    ),
    GoRoute(
      path: AppRoutes.passengerDetails,
      pageBuilder: (context, state) {
        final flight = state.extra as FlightModel;
        return _buildPage(state, PassengerDetailsScreen(flight: flight));
      },
    ),
    GoRoute(
      path: AppRoutes.seatSelection,
      pageBuilder: (context, state) {
        final flight = state.extra as FlightModel;
        return _buildPage(state, SeatSelectionScreen(flight: flight));
      },
    ),
    GoRoute(
      path: AppRoutes.payment,
      pageBuilder: (context, state) {
        final flight = state.extra as FlightModel;
        return _buildPage(state, PaymentScreen(flight: flight));
      },
    ),
    GoRoute(
      path: AppRoutes.ticket,
      pageBuilder: (context, state) {
        final bookingId = state.uri.queryParameters['bookingId'] ?? '';
        return _buildPage(state, TicketScreen(bookingId: bookingId));
      },
    ),
    GoRoute(
      path: AppRoutes.myBookings,
      pageBuilder: (context, state) =>
          _buildPage(state, const MyBookingsScreen()),
    ),
    GoRoute(
      path: AppRoutes.profile,
      pageBuilder: (context, state) =>
          _buildPage(state, const ProfileScreen()),
    ),
    GoRoute(
      path: AppRoutes.notifications,
      pageBuilder: (context, state) =>
          _buildPage(state, const NotificationsScreen()),
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    backgroundColor: const Color(0xFF050D1F),
    body: Center(
      child: Text(
        'Page not found',
        style: TextStyle(color: Colors.white),
      ),
    ),
  ),
);

CustomTransitionPage<void> _buildPage(GoRouterState state, Widget child) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.05, 0),
            end: Offset.zero,
          ).animate(CurveTween(curve: Curves.easeOutCubic).animate(animation)),
          child: child,
        ),
      );
    },
    transitionDuration: const Duration(milliseconds: 380),
  );
}
