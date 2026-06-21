import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:fly_flex/core/theme/app_colors.dart';
import 'package:fly_flex/core/theme/app_spacing.dart';
import 'package:fly_flex/core/theme/app_typography.dart';
import 'package:fly_flex/features/onboarding/data/models/onboarding_page_model.dart';
import 'package:fly_flex/core/utils/l10n_extension.dart';

class OnboardingPageCard extends StatelessWidget {
  const OnboardingPageCard({
    super.key,
    required this.page,
    required this.pageIndex,
  });

  final OnboardingPageModel page;
  final int pageIndex;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildImageSection(screenHeight * 0.55),
        const SizedBox(height: AppSpacing.md),
        _buildTextSection(),
      ],
    );
  }

  Widget _buildImageSection(double height) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            page.imagePath,
            fit: BoxFit.cover,
            alignment: Alignment.center,
            filterQuality: FilterQuality.high,
            errorBuilder: (context, error, stackTrace) => _buildFallback(),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 200,
            child: DecoratedBox(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [AppColors.navyDeep, Colors.transparent],
                ),
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms, curve: Curves.easeOut);
  }

  Widget _buildFallback() {
    final IconData icon;
    switch (page.tag) {
      case 'discover':
        icon = Icons.explore_rounded;
      case 'book':
        icon = Icons.confirmation_num_rounded;
      default:
        icon = Icons.flight_takeoff_rounded;
    }
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.navyMid, AppColors.navyAccent],
        ),
      ),
      child: Center(
        child: Icon(
          icon,
          color: AppColors.goldPure,
          size: 80,
        ),
      ),
    );
  }

  (String, String) _localizedContent(BuildContext context) {
    final l = context.l10n;
    return switch (page.tag) {
      'discover' => (l.onboarding1Title, l.onboarding1Subtitle),
      'book'     => (l.onboarding2Title, l.onboarding2Subtitle),
      _          => (l.onboarding3Title, l.onboarding3Subtitle),
    };
  }

  Widget _buildTextSection() {
    final delay = Duration(milliseconds: 150 + pageIndex * 50);
    return Builder(builder: (context) {
    final (title, subtitle) = _localizedContent(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenHorizontal,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTypography.displaySmall)
              .animate()
              .fadeIn(delay: delay, duration: 500.ms)
              .slideY(
                begin: 0.25,
                end: 0,
                delay: delay,
                duration: 500.ms,
                curve: Curves.easeOutCubic,
              ),
          const SizedBox(height: AppSpacing.md),
          Text(subtitle, style: AppTypography.bodyLarge)
              .animate()
              .fadeIn(delay: delay + 100.ms, duration: 500.ms)
              .slideY(
                begin: 0.25,
                end: 0,
                delay: delay + 100.ms,
                duration: 500.ms,
                curve: Curves.easeOutCubic,
              ),
        ],
      ),
    );
    });
  }
}
