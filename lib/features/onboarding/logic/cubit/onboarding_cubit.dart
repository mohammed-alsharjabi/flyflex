import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/onboarding_repository.dart';
import '../state/onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit(this._repository) : super(const OnboardingInitial());

  final OnboardingRepository _repository;

  void loadPages() {
    final pages = _repository.getPages();
    emit(OnboardingReady(pages: pages, currentPage: 0));
  }

  void nextPage(int page) {
    final current = state;
    if (current is! OnboardingReady) return;
    emit(current.copyWith(currentPage: page));
  }

  Future<void> complete() async {
    await _repository.markCompleted();
    emit(const OnboardingCompleted());
  }
}
