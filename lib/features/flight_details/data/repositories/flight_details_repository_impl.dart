import '../datasources/flight_details_local_datasource.dart';
import '../models/flight_details_model.dart';
import '../../../flights/data/models/flight_model.dart';
import 'flight_details_repository.dart';

class FlightDetailsRepositoryImpl implements FlightDetailsRepository {
  const FlightDetailsRepositoryImpl(this._datasource);

  final FlightDetailsLocalDatasource _datasource;

  @override
  Future<FlightDetailsModel> getFlightDetails(FlightModel flight) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _datasource.getDetails(flight);
  }
}
