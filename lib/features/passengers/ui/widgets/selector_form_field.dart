import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fly_flex/core/theme/app_colors.dart';
import 'package:fly_flex/core/theme/app_radius.dart';

class SelectorFormField extends StatelessWidget {
  const SelectorFormField({
    super.key,
    required this.label,
    required this.onTap,
    this.value,
    this.hint,
    this.prefixIcon,
    this.leading,
    this.errorText,
    this.showAutoFilledBadge = false,
    this.autoFilledLabel,
  });

  final String label;
  final String? value;
  final String? hint;
  final IconData? prefixIcon;
  final Widget? leading;
  final VoidCallback onTap;
  final String? errorText;
  final bool showAutoFilledBadge;
  final String? autoFilledLabel;

  @override
  Widget build(BuildContext context) {
    final hasValue = value != null && value!.isNotEmpty;
    final hasError = errorText != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.goldPure,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            if (showAutoFilledBadge && autoFilledLabel != null)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.goldPure.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(AppRadius.chip),
                  border: Border.all(
                    color: AppColors.goldPure.withValues(alpha: 0.35),
                  ),
                ),
                child: Text(
                  autoFilledLabel!,
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: AppColors.goldLight,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(AppRadius.md),
            child: Ink(
              decoration: BoxDecoration(
                color: AppColors.glassSurface,
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(
                  color: hasError ? AppColors.error : AppColors.glassBorder,
                  width: hasError ? 1.5 : 1,
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                child: Row(
                  children: [
                    if (leading != null) ...[
                      leading!,
                      const SizedBox(width: 10),
                    ] else if (prefixIcon != null) ...[
                      Icon(prefixIcon, size: 18, color: AppColors.textMuted),
                      const SizedBox(width: 10),
                    ],
                    Expanded(
                      child: Text(
                        hasValue ? value! : (hint ?? ''),
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          color: hasValue
                              ? AppColors.textPrimary
                              : AppColors.textMuted,
                          fontWeight:
                              hasValue ? FontWeight.w500 : FontWeight.w400,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: AppColors.textMuted,
                      size: 22,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (hasError) ...[
          const SizedBox(height: 4),
          Text(
            errorText!,
            style: GoogleFonts.inter(
              fontSize: 11,
              color: AppColors.error,
            ),
          ),
        ],
      ],
    );
  }
}
