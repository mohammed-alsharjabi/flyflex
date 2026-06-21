import '../models/onboarding_page_model.dart';

abstract interface class OnboardingRepository {
  List<OnboardingPageModel> getPages();
  Future<bool> hasCompleted();
  Future<void> markCompleted();
}
