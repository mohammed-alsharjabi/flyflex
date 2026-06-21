import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fly_flex/core/theme/app_colors.dart';
import 'package:fly_flex/core/utils/l10n_extension.dart';
import 'package:fly_flex/core/utils/model_localization.dart';
import 'package:fly_flex/features/auth/data/models/user_model.dart';

class MemberTierBadge extends StatelessWidget {
  const MemberTierBadge({super.key, required this.tier});

  final UserTier tier;

  Color get _color => switch (tier) {
        UserTier.platinum => const Color(0xFFB0C4DE),
        UserTier.gold => AppColors.goldPure,
        UserTier.silver => const Color(0xFFA8B2BC),
      };

  @override
  Widget build(BuildContext context) {
    final tierName = tier.localizedName(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: _color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: _color.withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.star_rounded, size: 12, color: _color),
          const SizedBox(width: 5),
          Text(
            context.l10n.profileMember(tierName),
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: _color,
            ),
          ),
        ],
      ),
    );
  }
}
