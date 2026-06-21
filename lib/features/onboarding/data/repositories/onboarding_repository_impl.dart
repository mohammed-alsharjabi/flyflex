import '../datasources/onboarding_local_datasource.dart';
import '../models/onboarding_page_model.dart';
import 'onboarding_repository.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  const OnboardingRepositoryImpl(this._datasource);

  final OnboardingLocalDatasource _datasource;

  @override
  List<OnboardingPageModel> getPages() => _datasource.getPages();

  @override
  Future<bool> hasCompleted() => _datasource.hasCompletedOnboarding();

  @override
  Future<void> markCompleted() => _datasource.markCompleted();
}
