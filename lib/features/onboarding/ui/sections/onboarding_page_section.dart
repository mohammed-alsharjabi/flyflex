import 'package:flutter/material.dart';
import 'package:fly_flex/core/theme/app_colors.dart';
import 'package:fly_flex/features/onboarding/data/models/onboarding_page_model.dart';
import 'package:fly_flex/features/onboarding/ui/widgets/onboarding_page_card.dart';

class OnboardingPageSection extends StatelessWidget {
  const OnboardingPageSection({
    super.key,
    required this.page,
    required this.pageIndex,
  });

  final OnboardingPageModel page;
  final int pageIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.navyMid, AppColors.navyDeep],
          stops: [0.0, 0.4],
        ),
      ),
      child: OnboardingPageCard(page: page, pageIndex: pageIndex),
    );
  }
}
