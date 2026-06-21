import 'package:fly_flex/features/flights/data/models/flight_model.dart';
import 'package:fly_flex/features/seat_selection/data/models/seat_model.dart';

abstract interface class SeatRepository {
  Future<List<SeatModel>> getSeatMap(FlightModel flight);
}
