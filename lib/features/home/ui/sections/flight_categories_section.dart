import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/models/flight_category_model.dart';
import '../widgets/flight_category_card.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/l10n_extension.dart';

class FlightCategoriesSection extends StatelessWidget {
  const FlightCategoriesSection({
    super.key,
    required this.categories,
  });

  final List<FlightCategoryModel> categories;

  static const _images = [
    'assets/cities/riyadh.png',
    'assets/cities/jeddah.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader(),
          const SizedBox(height: 16),
          ...List.generate(categories.length, (i) {
            return Padding(
              padding: EdgeInsets.only(bottom: i < categories.length - 1 ? 14 : 0),
              child: FlightCategoryCard(
                category: categories[i],
                imagePath: i < _images.length ? _images[i] : _images.last,
                index: i,
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 3,
          height: 20,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AppColors.goldPure, AppColors.goldDark],
            ),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          context.l10n.homeFlightCategories,
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
            letterSpacing: -0.3,
          ),
        ),
      ],
    );
  }
}
