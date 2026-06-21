import '../datasources/flights_local_datasource.dart';
import '../models/flight_model.dart';
import 'flights_repository.dart';

class FlightsRepositoryImpl implements FlightsRepository {
  const FlightsRepositoryImpl(this._datasource);

  final FlightsLocalDatasource _datasource;

  @override
  Future<List<FlightModel>> getDomesticFlights() =>
      _datasource.getDomesticFlights();

  @override
  Future<List<FlightModel>> getInternationalFlights() =>
      _datasource.getInternationalFlights();

  @override
  Future<List<FlightModel>> getFlightsByRoute({
    required String fromCode,
    required String toCode,
  }) =>
      _datasource.getByRoute(fromCode, toCode);
}
