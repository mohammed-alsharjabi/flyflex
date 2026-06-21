import 'package:flutter/material.dart';

import '../widgets/profile_option_tile.dart';
import '../bottom_sheets/language_bottom_sheet.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/utils/l10n_extension.dart';

class ProfileOptionsSection extends StatelessWidget {
  const ProfileOptionsSection({super.key, required this.onLogout});

  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.glassSurface,
        borderRadius: AppRadius.cardBorderRadius,
        border: Border.all(color: AppColors.glassBorder),
      ),
      child: Builder(builder: (context) {
        final l = context.l10n;
        return Column(
          children: [
            ProfileOptionTile(
              icon: Icons.language_rounded,
              title: l.profileLanguage,
              subtitle: l.profileLanguageSubtitle,
              onTap: () => LanguageBottomSheet.show(context),
            ),
            ProfileOptionTile(
              icon: Icons.person_outline_rounded,
              title: l.passengerPersonalInfo,
              subtitle: l.profilePersonalInfoSubtitle,
              onTap: () {},
            ),
            ProfileOptionTile(
              icon: Icons.badge_outlined,
              title: l.passengerTravelDoc,
              subtitle: l.profileTravelDocSubtitle,
              onTap: () {},
            ),
            ProfileOptionTile(
              icon: Icons.credit_card_rounded,
              title: l.profilePaymentMethods,
              subtitle: l.profilePaymentMethodsSubtitle,
              onTap: () {},
            ),
            ProfileOptionTile(
              icon: Icons.notifications_outlined,
              title: l.profileNotifications,
              subtitle: l.profileNotificationsSubtitle,
              onTap: () {},
            ),
            ProfileOptionTile(
              icon: Icons.help_outline_rounded,
              title: l.profileHelp,
              subtitle: l.profileHelpSubtitle,
              onTap: () {},
            ),
            ProfileOptionTile(
              icon: Icons.logout_rounded,
              title: l.profileSignOut,
              onTap: onLogout,
              isDestructive: true,
              showDivider: false,
            ),
          ],
        );
      }),
    );
  }
}
