abstract final class AppConstants {
  // App Info
  static const String appName = 'FlyFlex';
  static const String appTagline = 'Premium Unsold Seats Marketplace';
  static const String appVersion = '1.0.0';

  // Storage Keys
  static const String keyOnboardingComplete = 'onboarding_complete';
  static const String keyAuthToken = 'auth_token';
  static const String keyUserId = 'user_id';
  static const String keyUserData = 'user_data';

  // Asset Paths
  static const String logoPath = 'assets/icons/flyflex_logo.png';
  static const String backgroundPath = 'assets/icons/background.png';

  static const String onboardingDiscover =
      'assets/onboarding/onboarding_discover_seats.png';
  static const String onboardingBooking =
      'assets/onboarding/onboarding_easy_booking.png';
  static const String onboardingTravel =
      'assets/onboarding/onboarding_travel_more.png';

  static const String airplaneFront = 'assets/flights/airplane_front.png';
  static const String airplaneSide = 'assets/flights/airplane_side.png';
  static const String airplaneSunset = 'assets/flights/airplane_sunset.png';
  static const String airplaneTakeoff = 'assets/flights/airplane_takeoff.png';

  static const String cityRiyadh = 'assets/cities/riyadh.png';
  static const String cityJeddah = 'assets/cities/jeddah.png';
  static const String cityDammam = 'assets/cities/dammam.png';
  static const String cityMakkah = 'assets/cities/makkah.png';
  static const String cityTabuk = 'assets/cities/tabuk.png';
  static const String cityAlula = 'assets/cities/alula.png';

  // Mock data timing
  static const Duration mockDelay = Duration(milliseconds: 800);

  // Pagination
  static const int defaultPageSize = 20;

  // Seat Config
  static const int seatsPerRow = 6;
  static const int economyRows = 30;
  static const int businessRows = 8;
}
