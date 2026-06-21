import 'package:equatable/equatable.dart';

class CityModel extends Equatable {
  const CityModel({
    required this.id,
    required this.name,
    required this.code,
    required this.country,
    required this.imagePath,
    this.availableFlights = 0,
    this.isPopular = false,
  });

  final String id;
  final String name;
  final String code;
  final String country;
  final String imagePath;
  final int availableFlights;
  final bool isPopular;

  @override
  List<Object?> get props => [id, name, code, country, imagePath];
}
