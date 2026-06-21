import 'package:equatable/equatable.dart';
import '../../data/models/onboarding_page_model.dart';

sealed class OnboardingState extends Equatable {
  const OnboardingState();

  @override
  List<Object?> get props => [];
}

final class OnboardingInitial extends OnboardingState {
  const OnboardingInitial();
}

final class OnboardingReady extends OnboardingState {
  const OnboardingReady({
    required this.pages,
    required this.currentPage,
  });

  final List<OnboardingPageModel> pages;
  final int currentPage;

  bool get isLastPage => currentPage == pages.length - 1;

  OnboardingReady copyWith({int? currentPage}) => OnboardingReady(
        pages: pages,
        currentPage: currentPage ?? this.currentPage,
      );

  @override
  List<Object?> get props => [pages, currentPage];
}

final class OnboardingCompleted extends OnboardingState {
  const OnboardingCompleted();
}
