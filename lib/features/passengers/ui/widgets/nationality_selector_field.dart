import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fly_flex/core/theme/app_colors.dart';
import 'package:fly_flex/core/utils/l10n_extension.dart';
import '../../data/models/country_model.dart';
import '../bottom_sheets/country_picker_bottom_sheet.dart';
import 'selector_form_field.dart';

class NationalitySelectorField extends StatelessWidget {
  const NationalitySelectorField({
    super.key,
    required this.selectedCountry,
    required this.onChanged,
    this.errorText,
    this.isAutoFilled = false,
  });

  final CountryModel? selectedCountry;
  final void Function(CountryModel) onChanged;
  final String? errorText;
  final bool isAutoFilled;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return SelectorFormField(
      label: l10n.passengerNationality.toUpperCase(),
      hint: l10n.passengerSelectNationality,
      value: selectedCountry?.localizedName(context),
      prefixIcon: Icons.flag_outlined,
      leading: selectedCountry != null
          ? Text(
              selectedCountry!.flagEmoji,
              style: const TextStyle(fontSize: 20),
            )
          : null,
      errorText: errorText,
      showAutoFilledBadge: isAutoFilled,
      autoFilledLabel: l10n.passengerAutoFilled,
      onTap: () => CountryPickerBottomSheet.show(
        context,
        selected: selectedCountry,
        onSelected: onChanged,
        title: l10n.passengerSelectNationality,
      ),
    );
  }
}

class AutoFilledFieldLabel extends StatelessWidget {
  const AutoFilledFieldLabel({
    super.key,
    required this.label,
    this.isAutoFilled = false,
  });

  final String label;
  final bool isAutoFilled;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Row(
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
        if (isAutoFilled)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: AppColors.goldPure.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.goldPure.withValues(alpha: 0.35),
              ),
            ),
            child: Text(
              l10n.passengerAutoFilled,
              style: GoogleFonts.inter(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: AppColors.goldLight,
              ),
            ),
          ),
      ],
    );
  }
}
