import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:fly_flex/core/di/injection.dart';
import 'package:fly_flex/core/utils/l10n_extension.dart';
import 'package:fly_flex/core/widgets/gradient_background.dart';
import '../sections/flights_filter_section.dart';
import '../sections/flights_list_section.dart';
import '../widgets/flights_app_bar.dart';
import '../../logic/cubit/flights_cubit.dart';

class InternationalFlightsScreen extends StatelessWidget {
  const InternationalFlightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FlightsCubit>(
      create: (_) => sl<FlightsCubit>()..loadInternational(),
      child: const _InternationalFlightsView(),
    );
  }
}

class _InternationalFlightsView extends StatelessWidget {
  const _InternationalFlightsView();

  @override
  Widget build(BuildContext context) {
    return NavyScaffold(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FlightsAppBar(
              title: context.l10n.flightsInternational,
              subtitle: context.l10n.flightsInternationalRegion,
              onBack: () => context.pop(),
            ),
            const SizedBox(height: 16),
            const FlightsFilterSection(),
            const SizedBox(height: 16),
            const Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [FlightsListSection(), SizedBox(height: 24)],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
