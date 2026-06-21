import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fly_flex/core/theme/app_colors.dart';
import 'package:fly_flex/features/seat_selection/data/models/seat_model.dart';

class SeatWidget extends StatefulWidget {
  const SeatWidget({
    super.key,
    required this.seat,
    required this.onTap,
  });

  final SeatModel seat;
  final void Function(SeatModel) onTap;

  @override
  State<SeatWidget> createState() => _SeatWidgetState();
}

class _SeatWidgetState extends State<SeatWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
    );
    _scale = Tween<double>(begin: 1.0, end: 0.82).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    if (!widget.seat.isSelectable) return;
    _controller.forward().then((_) => _controller.reverse());
    widget.onTap(widget.seat);
  }

  Color get _fill {
    switch (widget.seat.status) {
      case SeatStatus.available:
        return AppColors.seatAvailable.withValues(alpha: 0.72);
      case SeatStatus.premium:
        return AppColors.seatPremium.withValues(alpha: 0.72);
      case SeatStatus.selected:
        return AppColors.seatSelected;
      case SeatStatus.occupied:
        return AppColors.seatOccupied;
    }
  }

  Color get _border {
    switch (widget.seat.status) {
      case SeatStatus.available:
        return AppColors.seatAvailable;
      case SeatStatus.premium:
        return AppColors.seatPremium;
      case SeatStatus.selected:
        return AppColors.goldLight;
      case SeatStatus.occupied:
        return AppColors.seatOccupied.withValues(alpha: 0.4);
    }
  }

  Color get _text {
    switch (widget.seat.status) {
      case SeatStatus.available:
      case SeatStatus.premium:
      case SeatStatus.selected:
        return AppColors.navyDeep;
      case SeatStatus.occupied:
        return AppColors.textMuted;
    }
  }

  List<BoxShadow> get _shadows {
    switch (widget.seat.status) {
      case SeatStatus.selected:
        return [
          BoxShadow(
            color: AppColors.goldPure.withValues(alpha: 0.5),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ];
      case SeatStatus.premium:
        return [
          BoxShadow(
            color: AppColors.seatPremium.withValues(alpha: 0.3),
            blurRadius: 4,
          ),
        ];
      case SeatStatus.available:
        return [
          BoxShadow(
            color: AppColors.seatAvailable.withValues(alpha: 0.25),
            blurRadius: 4,
          ),
        ];
      case SeatStatus.occupied:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: ScaleTransition(
        scale: _scale,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: _fill,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: _border, width: 1.0),
            boxShadow: _shadows,
          ),
          child: Center(
            child: Text(
              widget.seat.label,
              style: GoogleFonts.inter(
                fontSize: 8,
                fontWeight: FontWeight.w700,
                color: _text,
                letterSpacing: 0.2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
