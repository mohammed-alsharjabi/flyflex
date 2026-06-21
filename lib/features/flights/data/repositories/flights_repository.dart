import '../models/flight_model.dart';

abstract interface class FlightsRepository {
  Future<List<FlightModel>> getDomesticFlights();
  Future<List<FlightModel>> getInternationalFlights();
  Future<List<FlightModel>> getFlightsByRoute({
    required String fromCode,
    required String toCode,
  });
}
