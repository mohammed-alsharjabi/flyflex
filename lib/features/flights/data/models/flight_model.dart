import 'package:equatable/equatable.dart';

class FlightModel extends Equatable {
  const FlightModel({
    required this.id,
    required this.flightNumber,
    required this.airline,
    required this.airlineCode,
    required this.fromCity,
    required this.fromCode,
    required this.toCity,
    required this.toCode,
    required this.departureTime,
    required this.arrivalTime,
    required this.durationMinutes,
    required this.price,
    required this.originalPrice,
    required this.availableSeats,
    required this.totalSeats,
    required this.cabinClass,
    this.aircraft = 'Boeing 737',
    this.amenities = const [],
    this.stops = 0,
    this.logoPath,
  });

  final String id;
  final String flightNumber;
  final String airline;
  final String airlineCode;
  final String fromCity;
  final String fromCode;
  final String toCity;
  final String toCode;
  final DateTime departureTime;
  final DateTime arrivalTime;
  final int durationMinutes;
  final double price;
  final double originalPrice;
  final int availableSeats;
  final int totalSeats;
  final CabinClass cabinClass;
  final String aircraft;
  final List<String> amenities;
  final int stops;
  final String? logoPath;

  double get discountPercent =>
      ((originalPrice - price) / originalPrice * 100).roundToDouble();

  bool get isAlmostFull => availableSeats <= 5;

  String get durationFormatted {
    final h = durationMinutes ~/ 60;
    final m = durationMinutes % 60;
    return m == 0 ? '${h}h' : '${h}h ${m}m';
  }

  factory FlightModel.fromJson(Map<String, dynamic> json) => FlightModel(
        id: json['id'] as String,
        flightNumber: json['flight_number'] as String,
        airline: json['airline'] as String,
        airlineCode: json['airline_code'] as String,
        fromCity: json['from_city'] as String,
        fromCode: json['from_code'] as String,
        toCity: json['to_city'] as String,
        toCode: json['to_code'] as String,
        departureTime: DateTime.parse(json['departure_time'] as String),
        arrivalTime: DateTime.parse(json['arrival_time'] as String),
        durationMinutes: json['duration_minutes'] as int,
        price: (json['price'] as num).toDouble(),
        originalPrice: (json['original_price'] as num).toDouble(),
        availableSeats: json['available_seats'] as int,
        totalSeats: json['total_seats'] as int,
        cabinClass: CabinClass.fromString(json['cabin_class'] as String),
        aircraft: json['aircraft'] as String? ?? 'Boeing 737',
        amenities: List<String>.from(json['amenities'] as List? ?? []),
        stops: json['stops'] as int? ?? 0,
        logoPath: json['logo_path'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'flight_number': flightNumber,
        'airline': airline,
        'airline_code': airlineCode,
        'from_city': fromCity,
        'from_code': fromCode,
        'to_city': toCity,
        'to_code': toCode,
        'departure_time': departureTime.toIso8601String(),
        'arrival_time': arrivalTime.toIso8601String(),
        'duration_minutes': durationMinutes,
        'price': price,
        'original_price': originalPrice,
        'available_seats': availableSeats,
        'total_seats': totalSeats,
        'cabin_class': cabinClass.name,
        'aircraft': aircraft,
        'amenities': amenities,
        'stops': stops,
        'logo_path': logoPath,
      };

  @override
  List<Object?> get props => [id, flightNumber, fromCode, toCode, departureTime];
}

enum CabinClass {
  economy,
  business,
  first;

  static CabinClass fromString(String val) => CabinClass.values.firstWhere(
        (c) => c.name == val,
        orElse: () => CabinClass.economy,
      );

  String get label {
    switch (this) {
      case CabinClass.economy:
        return 'Economy';
      case CabinClass.business:
        return 'Business';
      case CabinClass.first:
        return 'First Class';
    }
  }
}
