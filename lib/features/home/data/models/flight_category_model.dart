import 'package:equatable/equatable.dart';

class FlightCategoryModel extends Equatable {
  const FlightCategoryModel({
    required this.id,
    required this.label,
    required this.subtitle,
    required this.iconData,
    required this.route,
    required this.color,
  });

  final String id;
  final String label;
  final String subtitle;
  final int iconData;
  final String route;
  final int color;

  @override
  List<Object?> get props => [id, label, subtitle, iconData, route, color];
}
