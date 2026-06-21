import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/models/ticket_model.dart';
import '../widgets/barcode_widget.dart';
import '../widgets/boarding_pass_header.dart';
import '../widgets/tear_line_widget.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/utils/l10n_extension.dart';
import '../../../../core/utils/model_localization.dart';

class TicketCardSection extends StatelessWidget {
  const TicketCardSection({super.key, required this.ticket});

  final TicketModel ticket;

  String _time(DateTime dt) =>
      '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: AppRadius.cardBorderRadius,
        gradient: const LinearGradient(
          colors: [AppColors.goldDim, AppColors.goldPure, AppColors.goldLight, AppColors.goldDim],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.goldPure.withValues(alpha: 0.2),
            blurRadius: 32,
            spreadRadius: 4,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Container(
        margin: const EdgeInsets.all(1.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.card - 1.5),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.navyMid, AppColors.navyAccent, AppColors.navyLight],
            stops: [0.0, 0.55, 1.0],
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.card - 1.5),
          child: Column(
            children: [
              _TopSection(
                ticket: ticket,
                time: _time,
                date: (dt) => localizedDate(context, dt),
              ),
              const TearLineWidget(backgroundColor: AppColors.navyDeep),
              _BottomSection(ticket: ticket),
            ],
          ),
        ),
      ),
    );
  }
}

class _TopSection extends StatelessWidget {
  const _TopSection({
    required this.ticket,
    required this.time,
    required this.date,
  });

  final TicketModel ticket;
  final String Function(DateTime) time;
  final String Function(DateTime) date;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final f = ticket.flight;
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 22, 22, 0),
      child: Column(
        children: [
          BoardingPassHeader(
            airline: f.airline,
            flightNumber: f.flightNumber,
            status: ticket.status,
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              _RoutePoint(code: f.fromCode, city: f.fromCity, t: time(f.departureTime), left: true),
              Expanded(
                child: Column(
                  children: [
                    const Icon(Icons.flight, color: AppColors.goldPure, size: 22),
                    const SizedBox(height: 4),
                    Container(height: 1, color: AppColors.glassBorder),
                  ],
                ),
              ),
              _RoutePoint(code: f.toCode, city: f.toCity, t: time(f.arrivalTime), left: false),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _InfoBox(label: l.ticketDate, value: date(f.departureTime)),
              const SizedBox(width: 10),
              _InfoBox(label: l.ticketDuration, value: f.durationFormatted),
              const SizedBox(width: 10),
              _InfoBox(label: l.ticketCabin, value: ticket.cabinClass.localizedName(context)),
            ],
          ),
          const SizedBox(height: 14),
        ],
      ),
    );
  }
}

class _RoutePoint extends StatelessWidget {
  const _RoutePoint({required this.code, required this.city, required this.t, required this.left});

  final String code, city, t;
  final bool left;

  @override
  Widget build(BuildContext context) {
    final align = left ? CrossAxisAlignment.start : CrossAxisAlignment.end;
    return Column(
      crossAxisAlignment: align,
      children: [
        Text(code, style: GoogleFonts.inter(fontSize: 34, fontWeight: FontWeight.w900, color: AppColors.textPrimary, letterSpacing: -1)),
        Text(city, style: GoogleFonts.inter(fontSize: 11, color: AppColors.textMuted)),
        const SizedBox(height: 2),
        Text(t, style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textSecondary)),
      ],
    );
  }
}

class _InfoBox extends StatelessWidget {
  const _InfoBox({required this.label, required this.value});

  final String label, value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.glassSurface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.glassBorder),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: GoogleFonts.inter(fontSize: 9, color: AppColors.textHint, letterSpacing: 0.5, fontWeight: FontWeight.w600)),
            const SizedBox(height: 2),
            Text(value, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
          ],
        ),
      ),
    );
  }
}

class _BottomSection extends StatelessWidget {
  const _BottomSection({required this.ticket});

  final TicketModel ticket;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return Container(
      padding: const EdgeInsets.fromLTRB(22, 18, 22, 22),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _PassInfo(label: l.ticketPassenger, value: ticket.passengerName),
              _PassInfo(label: l.ticketSeat, value: ticket.seatNumber, alignEnd: true),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _PassInfo(label: l.ticketGate, value: ticket.gate),
              _PassInfo(label: l.ticketBoardingTime, value: _formatTime(ticket.boardingTime)),
              _PassInfo(label: l.ticketClass, value: ticket.cabinClass.localizedName(context), alignEnd: true),
            ],
          ),
          const SizedBox(height: 18),
          BarcodeWidget(data: ticket.qrData),
        ],
      ),
    );
  }

  String _formatTime(DateTime dt) =>
      '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
}

class _PassInfo extends StatelessWidget {
  const _PassInfo({required this.label, required this.value, this.alignEnd = false});

  final String label, value;
  final bool alignEnd;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignEnd ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.inter(fontSize: 9, color: AppColors.textHint, letterSpacing: 0.5, fontWeight: FontWeight.w600)),
        const SizedBox(height: 2),
        Text(value, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
      ],
    );
  }
}
