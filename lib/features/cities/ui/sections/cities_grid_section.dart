import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fly_flex/core/theme/app_colors.dart';
import 'package:fly_flex/core/utils/l10n_extension.dart';
import 'package:fly_flex/features/cities/data/models/city_model.dart';
import 'package:fly_flex/features/cities/ui/widgets/city_card.dart';

class CitiesGridSection extends StatelessWidget {
  const CitiesGridSection({super.key, required this.cities});

  final List<CityModel> cities;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text(
              context.l10n.citiesAvailable(cities.length),
              style: GoogleFonts.inter(
                color: AppColors.textMuted,
                fontSize: 13,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.2,
              ),
            ),
          ),
          ...List.generate(cities.length, (i) => Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: CityCard(city: cities[i], index: i),
          )),
          const SizedBox(height: 16),
        ]),
      ),
    );
  }
}
