import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fly_flex/core/utils/l10n_extension.dart';
import 'package:fly_flex/core/utils/model_localization.dart';
import '../../data/models/flight_model.dart';
import '../../logic/cubit/flights_cubit.dart';
import '../../logic/state/flights_state.dart';
import '../../../../core/theme/app_colors.dart';

class FlightsFilterSection extends StatefulWidget {
  const FlightsFilterSection({super.key});

  @override
  State<FlightsFilterSection> createState() => _FlightsFilterSectionState();
}

class _FlightsFilterSectionState extends State<FlightsFilterSection> {
  bool _ascending = true;

  static const _cabinFilters = [
    _CabinFilter(cabin: null, icon: Icons.grid_view_rounded),
    _CabinFilter(
      cabin: CabinClass.economy,
      icon: Icons.airline_seat_recline_normal_rounded,
    ),
    _CabinFilter(
      cabin: CabinClass.business,
      icon: Icons.airline_seat_flat_rounded,
    ),
    _CabinFilter(
      cabin: CabinClass.first,
      icon: Icons.star_rounded,
    ),
  ];

  void _onCabinTap(CabinClass? cabin) {
    context.read<FlightsCubit>().filterByCabin(cabin);
  }

  void _toggleSort() {
    setState(() => _ascending = !_ascending);
    context.read<FlightsCubit>().sortByPrice(_ascending);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FlightsCubit, FlightsState>(
      builder: (context, state) {
        final selected =
            state is FlightsLoaded ? state.selectedCabin : null;

        return SizedBox(
          height: 44,
          child: Row(
            children: [
              Expanded(
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(left: 20),
                  itemCount: _cabinFilters.length,
                  separatorBuilder: (context, index) => const SizedBox(width: 8),
                  itemBuilder: (context, i) {
                    final filter = _cabinFilters[i];
                    final isActive = filter.cabin == selected;
                    return _FilterChip(
                      filter: filter,
                      isActive: isActive,
                      onTap: () => _onCabinTap(filter.cabin),
                    );
                  },
                ),
              ),
              const SizedBox(width: 8),
              _SortButton(ascending: _ascending, onTap: _toggleSort),
              const SizedBox(width: 20),
            ],
          ),
        );
      },
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.filter,
    required this.isActive,
    required this.onTap,
  });

  final _CabinFilter filter;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          gradient: isActive
              ? const LinearGradient(
                  colors: [AppColors.goldDark, AppColors.goldPure],
                )
              : null,
          color: isActive ? null : AppColors.glassSurface,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: isActive ? Colors.transparent : AppColors.glassBorder,
          ),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: AppColors.goldPure.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              filter.icon,
              size: 14,
              color: isActive ? AppColors.navyDeep : AppColors.textMuted,
            ),
            const SizedBox(width: 6),
            Text(
              filter.label(context),
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                color: isActive ? AppColors.navyDeep : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SortButton extends StatelessWidget {
  const _SortButton({required this.ascending, required this.onTap});

  final bool ascending;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.glassSurface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.glassBorder),
        ),
        alignment: Alignment.center,
        child: Icon(
          ascending
              ? Icons.arrow_upward_rounded
              : Icons.arrow_downward_rounded,
          color: AppColors.goldPure,
          size: 18,
        ),
      ),
    );
  }
}

class _CabinFilter {
  const _CabinFilter({
    required this.cabin,
    required this.icon,
  });

  final CabinClass? cabin;
  final IconData icon;

  String label(BuildContext context) {
    if (cabin == null) return context.l10n.flightsAll;
    return cabin!.localizedName(context);
  }
}
