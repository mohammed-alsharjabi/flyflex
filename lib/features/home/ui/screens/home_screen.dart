import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../logic/cubit/home_cubit.dart';
import '../../logic/state/home_state.dart';
import '../../data/models/flight_category_model.dart';
import '../../../flights/data/models/flight_model.dart';
import '../../../cities/data/models/city_model.dart';
import '../sections/hero_section.dart';
import '../sections/flight_categories_section.dart';
import '../sections/last_minute_deals_section.dart';
import '../sections/popular_cities_section.dart';
import '../widgets/home_bottom_nav.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/utils/l10n_extension.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _navIndex = 0;

  void _onNavTap(int index) {
    if (index == _navIndex) return;

    HapticFeedback.lightImpact();

    switch (index) {
      case 1:
        context.push(AppRoutes.myBookings);
      case 2:
        context.push(AppRoutes.notifications);
      case 3:
        context.push(AppRoutes.profile);
      default:
        setState(() => _navIndex = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<HomeCubit>()..loadHome(),
      child: Scaffold(
        backgroundColor: AppColors.navyDeep,
        extendBody: true,
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return switch (state) {
              HomeLoading() || HomeInitial() => const _LoadingBody(),
              HomeError(:final message) => _ErrorBody(
                  message: message,
                  onRetry: () => context.read<HomeCubit>().refresh(),
                ),
              HomeLoaded(
                :final categories,
                :final featuredFlights,
                :final popularCities,
              ) =>
                _HomeBody(
                  categories: categories,
                  featuredFlights: featuredFlights,
                  popularCities: popularCities,
                ),
            };
          },
        ),
        bottomNavigationBar: HomeBottomNav(
          currentIndex: _navIndex,
          onTap: _onNavTap,
        ),
      ),
    );
  }
}

class _HomeBody extends StatelessWidget {
  const _HomeBody({
    required this.categories,
    required this.featuredFlights,
    required this.popularCities,
  });

  final List<FlightCategoryModel> categories;
  final List<FlightModel> featuredFlights;
  final List<CityModel> popularCities;

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: HeroSection(topPadding: topPadding),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 36)),
        SliverToBoxAdapter(
          child: FlightCategoriesSection(categories: categories),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 36)),
        SliverToBoxAdapter(
          child: LastMinuteDealsSection(flights: featuredFlights),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 36)),
        SliverToBoxAdapter(
          child: PopularCitiesSection(cities: popularCities),
        ),
        SliverToBoxAdapter(
          child: SizedBox(height: 100 + bottomPadding),
        ),
      ],
    );
  }
}

class _LoadingBody extends StatelessWidget {
  const _LoadingBody();

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          SizedBox(
            height: 420 + topPadding,
            child: Container(
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment(0.3, -0.6),
                  radius: 1.4,
                  colors: [Color(0xFF1A2E52), Color(0xFF050D1F)],
                ),
              ),
            ),
          ),
          const SizedBox(height: 36),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                Expanded(child: _ShimmerBlock(height: 160, radius: 20)),
                const SizedBox(width: 14),
                Expanded(child: _ShimmerBlock(height: 160, radius: 20)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ShimmerBlock extends StatelessWidget {
  const _ShimmerBlock({required this.height, required this.radius});
  final double height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: AppColors.navyMid,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}



class _ErrorBody extends StatelessWidget {
  const _ErrorBody({required this.message, required this.onRetry});
  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.wifi_off_rounded,
              color: AppColors.textMuted,
              size: 64,
            ),
            const SizedBox(height: 16),
            Text(
              context.l10n.errorGeneral,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: onRetry,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.goldPure, AppColors.goldDark],
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  context.l10n.buttonRetry,
                  style: const TextStyle(
                    color: AppColors.navyDeep,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
