import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/models/booking_model.dart';
import '../widgets/booking_status_badge.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/utils/model_localization.dart';

class BookingCard extends StatelessWidget {
  const BookingCard({super.key, required this.booking, this.animationDelay});

  final BookingModel booking;
  final Duration? animationDelay;

  String _date(BuildContext context, DateTime dt) =>
      localizedDate(context, dt);

  @override
  Widget build(BuildContext context) {
    final flight = booking.flight;

    Widget card = GestureDetector(
      onTap: () => context.push('${AppRoutes.ticket}?bookingId=${booking.id}'),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: ClipRRect(
          borderRadius: AppRadius.cardBorderRadius,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.glassSurface,
                borderRadius: AppRadius.cardBorderRadius,
                border: Border.all(color: AppColors.glassBorder),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 18, 20, 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${flight.airline} · ${flight.flightNumber}',
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            BookingStatusBadge(status: booking.status),
                          ],
                        ),
                        const SizedBox(height: 14),
                        Row(
                          children: [
                            Text(
                              flight.fromCode,
                              style: GoogleFonts.inter(
                                fontSize: 28,
                                fontWeight: FontWeight.w900,
                                color: AppColors.textPrimary,
                                letterSpacing: -0.5,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Icon(Icons.flight, color: AppColors.goldPure, size: 20),
                            ),
                            Text(
                              flight.toCode,
                              style: GoogleFonts.inter(
                                fontSize: 28,
                                fontWeight: FontWeight.w900,
                                color: AppColors.textPrimary,
                                letterSpacing: -0.5,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 0.5,
                    color: AppColors.glassBorder,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
                    child: Row(
                      children: [
                        _MetaItem(icon: Icons.calendar_today_rounded, label: _date(context, flight.departureTime)),
                        const SizedBox(width: 12),
                        _MetaItem(icon: Icons.airline_seat_recline_normal_rounded, label: booking.seatNumber),
                        const Spacer(),
                        Text(
                          localizedCurrency(context, booking.totalPaid),
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: AppColors.goldPure,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    if (animationDelay != null) {
      card = card
          .animate()
          .fadeIn(delay: animationDelay!, duration: 400.ms)
          .slideY(begin: 0.1, end: 0, delay: animationDelay!, duration: 400.ms, curve: Curves.easeOutCubic);
    }

    return card;
  }
}

class _MetaItem extends StatelessWidget {
  const _MetaItem({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 12, color: AppColors.textMuted),
        const SizedBox(width: 4),
        Text(label, style: GoogleFonts.inter(fontSize: 11, color: AppColors.textMuted)),
      ],
    );
  }
}
