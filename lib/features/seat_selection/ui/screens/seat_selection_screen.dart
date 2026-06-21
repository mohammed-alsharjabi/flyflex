import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:fly_flex/core/di/injection.dart';
import 'package:fly_flex/core/router/app_router.dart';
import 'package:fly_flex/core/theme/app_colors.dart';
import 'package:fly_flex/core/theme/app_spacing.dart';
import 'package:fly_flex/core/theme/app_typography.dart';
import 'package:fly_flex/core/utils/l10n_extension.dart';
import 'package:fly_flex/core/widgets/app_back_button.dart';
import 'package:fly_flex/core/widgets/app_button.dart';
import 'package:fly_flex/core/widgets/gradient_background.dart';
import 'package:fly_flex/features/flights/data/models/flight_model.dart';
import 'package:fly_flex/features/seat_selection/logic/cubit/seat_cubit.dart';
import 'package:fly_flex/features/seat_selection/logic/state/seat_state.dart';
import 'package:fly_flex/features/seat_selection/ui/sections/seat_map_section.dart';
import 'package:fly_flex/features/seat_selection/ui/widgets/seat_flight_header.dart';
import 'package:fly_flex/features/seat_selection/ui/widgets/seat_legend_widget.dart';
import 'package:fly_flex/features/seat_selection/ui/widgets/seat_selected_badge.dart';

class SeatSelectionScreen extends StatelessWidget {
  const SeatSelectionScreen({super.key, required this.flight});

  final FlightModel flight;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<SeatCubit>()..loadSeats(flight),
      child: _SeatSelectionBody(flight: flight),
    );
  }
}

class _SeatSelectionBody extends StatelessWidget {
  const _SeatSelectionBody({required this.flight});

  final FlightModel flight;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return NavyScaffold(
      child: Stack(
        children: [
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                pinned: true,
                leading: Padding(
                  padding: const EdgeInsets.only(left: 16, top: 8),
                  child: AppBackButton(),
                ),
                title: Text(l.seatTitle, style: AppTypography.headlineMedium),
                centerTitle: true,
                toolbarHeight: 64,
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.navyDeep,
                        AppColors.navyDeep.withValues(alpha: 0),
                      ],
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.screenHorizontal,
                ),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    SeatFlightHeader(flight: flight)
                        .animate()
                        .fadeIn(duration: 400.ms)
                        .slideY(begin: -0.08, end: 0),
                    const SizedBox(height: 14),
                    const SeatLegendWidget()
                        .animate()
                        .fadeIn(duration: 400.ms, delay: 80.ms),
                    const SizedBox(height: 20),
                    const SeatMapSection(),
                    const SizedBox(height: 150),
                  ]),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _SeatSelectionBottom(flight: flight),
          ),
        ],
      ),
    );
  }
}

class _SeatSelectionBottom extends StatelessWidget {
  const _SeatSelectionBottom({required this.flight});

  final FlightModel flight;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return BlocBuilder<SeatCubit, SeatState>(
      builder: (context, state) {
        final loaded = state is SeatLoaded ? state : null;
        final selected = loaded?.selectedSeat;
        final total = loaded?.totalPrice ?? flight.price;

        return Container(
          padding: EdgeInsets.fromLTRB(
            AppSpacing.screenHorizontal,
            16,
            AppSpacing.screenHorizontal,
            MediaQuery.of(context).padding.bottom + 16,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.navyDeep.withValues(alpha: 0),
                AppColors.navyDeep.withValues(alpha: 0.95),
                AppColors.navyDeep,
              ],
              stops: const [0.0, 0.3, 1.0],
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 280),
                transitionBuilder: (child, anim) => FadeTransition(
                  opacity: anim,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 0.3),
                      end: Offset.zero,
                    ).animate(anim),
                    child: child,
                  ),
                ),
                child: selected != null
                    ? SeatSelectedBadge(
                        key: ValueKey(selected.id),
                        seat: selected,
                        totalPrice: total,
                      )
                    : const SizedBox.shrink(key: ValueKey('empty')),
              ),
              if (selected != null) const SizedBox(height: 12),
              AppButton(
                label: selected != null ? l.seatConfirm : l.seatSelectASeat,
                isEnabled: selected != null,
                icon: selected != null
                    ? const Icon(
                        Icons.check_circle_rounded,
                        color: AppColors.navyDeep,
                        size: 20,
                      )
                    : null,
                onPressed: selected != null
                    ? () => context.push(AppRoutes.payment, extra: flight)
                    : null,
              ),
            ],
          ),
        );
      },
    );
  }
}
