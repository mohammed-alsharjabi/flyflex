import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/utils/l10n_extension.dart';
import '../../../../core/utils/model_localization.dart';
import '../../../flights/data/models/flight_model.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';

class PriceBreakdownSection extends StatelessWidget {
  const PriceBreakdownSection({super.key, required this.flight});

  final FlightModel flight;

  static const double _flyFlexFee = 25.0;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final taxes = (flight.price * 0.15).roundToDouble();
    final total = flight.price + taxes + _flyFlexFee;
    final savings = flight.originalPrice - flight.price;
    final savingsPercent = flight.discountPercent.toInt();

    return ClipRRect(
      borderRadius: AppRadius.cardBorderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.glassSurface,
            borderRadius: AppRadius.cardBorderRadius,
            border: Border.all(color: AppColors.glassBorder),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 3,
                    height: 18,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: AppColors.goldGradient,
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(AppRadius.xs),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    l.flightDetailsPriceBreakdown,
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const Spacer(),
                  if (savingsPercent > 0)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.successLight,
                        borderRadius: BorderRadius.circular(AppRadius.chip),
                      ),
                      child: Text(
                        l.flightDetailsSavePercent(savingsPercent),
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: AppColors.success,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              _PriceRow(
                  label: l.flightDetailsBaseFare,
                  value: localizedCurrency(context, flight.price)),
              _PriceRow(
                label: l.flightDetailsTaxesPercent,
                value: localizedCurrency(context, taxes),
              ),
              _PriceRow(
                label: l.flightDetailsServiceFee,
                value: localizedCurrency(context, _flyFlexFee),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: _DashedDivider(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l.flightDetailsTotal,
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    localizedCurrency(context, total),
                    style: GoogleFonts.inter(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: AppColors.goldPure,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
              if (savings > 0) ...[
                const SizedBox(height: 12),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.successLight,
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.savings_rounded,
                          size: 16, color: AppColors.success),
                      const SizedBox(width: 8),
                      Text(
                        l.flightDetailsSavings(
                          savings.toInt().toString(),
                          savingsPercent,
                        ),
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.success,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  const _PriceRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style:
                  GoogleFonts.inter(fontSize: 13, color: AppColors.textMuted)),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _DashedDivider extends StatelessWidget {
  const _DashedDivider();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const dashWidth = 6.0;
        const dashSpace = 4.0;
        final dashCount =
            (constraints.maxWidth / (dashWidth + dashSpace)).floor();
        return Row(
          children: List.generate(dashCount, (_) {
            return Padding(
              padding: const EdgeInsets.only(right: dashSpace),
              child: Container(
                width: dashWidth,
                height: 1,
                color: AppColors.glassBorder,
              ),
            );
          }),
        );
      },
    );
  }
}
