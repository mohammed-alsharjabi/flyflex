import 'package:shared_preferences/shared_preferences.dart';
import '../models/onboarding_page_model.dart';

class OnboardingLocalDatasource {
  static const _keyCompleted = 'onboarding_completed';

  List<OnboardingPageModel> getPages() => const [
        OnboardingPageModel(
          title: 'Discover Unsold Seats',
          subtitle:
              'Airlines publish seats not sold before takeoff. You discover them first.',
          imagePath: 'assets/onboarding/onboarding_discover_seats.png',
          tag: 'discover',
        ),
        OnboardingPageModel(
          title: 'Book at Up to 83% Off',
          subtitle:
              'Premium cabin seats at a fraction of the original price. Luxury, redefined.',
          imagePath: 'assets/onboarding/onboarding_easy_booking.png',
          tag: 'book',
        ),
        OnboardingPageModel(
          title: 'Fly Premium. Pay Less.',
          subtitle:
              'Business and First Class experiences, made accessible. Your upgrade awaits.',
          imagePath: 'assets/onboarding/onboarding_travel_more.png',
          tag: 'fly',
        ),
      ];

  Future<bool> hasCompletedOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyCompleted) ?? false;
  }

  Future<void> markCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyCompleted, true);
  }
}
