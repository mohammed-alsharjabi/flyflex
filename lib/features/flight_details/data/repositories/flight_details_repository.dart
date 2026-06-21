import '../models/flight_details_model.dart';
import '../../../flights/data/models/flight_model.dart';

abstract interface class FlightDetailsRepository {
  Future<FlightDetailsModel> getFlightDetails(FlightModel flight);
}
