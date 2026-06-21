import 'package:fly_flex/features/flights/data/models/flight_model.dart';
import 'package:fly_flex/features/seat_selection/data/datasources/seat_local_datasource.dart';
import 'package:fly_flex/features/seat_selection/data/models/seat_model.dart';
import 'package:fly_flex/features/seat_selection/data/repositories/seat_repository.dart';

class SeatRepositoryImpl implements SeatRepository {
  SeatRepositoryImpl(this._datasource);

  final SeatLocalDatasource _datasource;

  @override
  Future<List<SeatModel>> getSeatMap(FlightModel flight) async {
    await Future.delayed(const Duration(milliseconds: 600));
    return _datasource.generateSeatMap(flight);
  }
}
