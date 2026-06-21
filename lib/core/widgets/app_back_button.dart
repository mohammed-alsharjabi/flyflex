import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_colors.dart';
import 'glass_card.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      width: 44,
      height: 44,
      padding: EdgeInsets.zero,
      onTap: onPressed ?? () => context.pop(),
      child: const Icon(
        Icons.arrow_back_ios_new_rounded,
        color: AppColors.textPrimary,
        size: 18,
      ),
    );
  }
}
