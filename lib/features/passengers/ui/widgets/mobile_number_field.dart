import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fly_flex/core/theme/app_colors.dart';
import 'package:fly_flex/core/theme/app_radius.dart';
import 'package:fly_flex/core/utils/l10n_extension.dart';
import '../../data/models/country_model.dart';
import '../bottom_sheets/country_picker_bottom_sheet.dart';

class MobileNumberField extends StatefulWidget {
  const MobileNumberField({
    super.key,
    required this.country,
    required this.controller,
    required this.onCountryChanged,
    this.validator,
    this.onChanged,
  });

  final CountryModel country;
  final TextEditingController controller;
  final void Function(CountryModel) onCountryChanged;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  @override
  State<MobileNumberField> createState() => MobileNumberFieldState();
}

class MobileNumberFieldState extends State<MobileNumberField> {
  bool _hasError = false;
  String? _errorMessage;

  String? validate() {
    final result = widget.validator?.call(widget.controller.text);
    setState(() {
      _hasError = result != null;
      _errorMessage = result;
    });
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.passengerMobile.toUpperCase(),
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.goldPure,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _DialCodeButton(
              country: widget.country,
              onTap: () => CountryPickerBottomSheet.show(
                context,
                selected: widget.country,
                onSelected: widget.onCountryChanged,
                title: l10n.passengerSelectCountryCode,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.glassSurface,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  border: Border.all(
                    color: _hasError ? AppColors.error : AppColors.glassBorder,
                    width: _hasError ? 1.5 : 1,
                  ),
                ),
                child: TextFormField(
                  controller: widget.controller,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(12),
                  ],
                  onChanged: widget.onChanged,
                  validator: (v) {
                    final result = widget.validator?.call(v);
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (mounted) {
                        setState(() {
                          _hasError = result != null;
                          _errorMessage = result;
                        });
                      }
                    });
                    return result;
                  },
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    color: AppColors.textPrimary,
                  ),
                  cursorColor: AppColors.goldPure,
                  decoration: InputDecoration(
                    hintText: l10n.passengerMobileLocalHint,
                    hintStyle: GoogleFonts.inter(
                      fontSize: 14,
                      color: AppColors.textMuted,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        if (_hasError && _errorMessage != null) ...[
          const SizedBox(height: 4),
          Text(
            _errorMessage!,
            style: GoogleFonts.inter(fontSize: 11, color: AppColors.error),
          ),
        ],
      ],
    );
  }
}

class _DialCodeButton extends StatelessWidget {
  const _DialCodeButton({
    required this.country,
    required this.onTap,
  });

  final CountryModel country;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          decoration: BoxDecoration(
            color: AppColors.glassSurface,
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(color: AppColors.glassBorder),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(country.flagEmoji, style: const TextStyle(fontSize: 18)),
              const SizedBox(width: 6),
              Text(
                country.dialCode,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(width: 2),
              const Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 18,
                color: AppColors.textMuted,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
