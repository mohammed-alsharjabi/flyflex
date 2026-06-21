import 'package:equatable/equatable.dart';
import '../../../flights/data/models/flight_model.dart';

class FlightDetailsModel extends Equatable {
  const FlightDetailsModel({
    required this.flight,
    required this.amenities,
    required this.baggageInfo,
    required this.aircraftType,
    required this.onTimeRate,
    required this.departureTerminal,
    required this.arrivalTerminal,
    required this.boardingTime,
    required this.refundPolicy,
  });

  final FlightModel flight;
  final List<String> amenities;
  final String baggageInfo;
  final String aircraftType;
  final int onTimeRate;
  final String departureTerminal;
  final String arrivalTerminal;
  final DateTime boardingTime;
  final String refundPolicy;

  bool get isRefundable =>
      refundPolicy.toLowerCase().contains('refundable') &&
      !refundPolicy.toLowerCase().contains('non');

  @override
  List<Object?> get props => [flight.id];
}
