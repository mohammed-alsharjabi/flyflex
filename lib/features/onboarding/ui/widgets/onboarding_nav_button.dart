import 'package:flutter/material.dart';
import 'package:fly_flex/core/theme/app_colors.dart';
import 'package:fly_flex/core/theme/app_radius.dart';
import 'package:fly_flex/core/theme/app_typography.dart';
import 'package:fly_flex/core/utils/l10n_extension.dart';

class OnboardingNavButton extends StatelessWidget {
  const OnboardingNavButton({
    super.key,
    required this.isLastPage,
    required this.onPressed,
  });

  final bool isLastPage;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.goldDark, AppColors.goldPure, AppColors.goldLight],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(AppRadius.button),
          boxShadow: [
            BoxShadow(
              color: AppColors.goldPure.withValues(alpha: 0.30),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.button),
            ),
            padding: EdgeInsets.zero,
          ),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: Row(
              key: ValueKey(isLastPage),
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  isLastPage ? context.l10n.buttonGetStarted : context.l10n.buttonNext,
                  style: AppTypography.buttonText,
                ),
                const SizedBox(width: 8),
                Icon(
                  isLastPage
                      ? Icons.rocket_launch_rounded
                      : Icons.arrow_forward_rounded,
                  color: AppColors.navyDeep,
                  size: 18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
