import 'dart:math';
import 'package:fly_flex/features/flights/data/models/flight_model.dart';
import 'package:fly_flex/features/seat_selection/data/models/seat_model.dart';

class SeatLocalDatasource {
  static const _columns = ['A', 'B', 'C', 'D', 'E', 'F'];
  static const _firstClassRows = 4;
  static const _businessEndRow = 15;
  static const _economyStartRow = 16;
  static const _fixedSeats = 90; // 4*6 first + 11*6 business

  List<SeatModel> generateSeatMap(FlightModel flight) {
    final rng = Random(flight.id.hashCode);
    final seats = <SeatModel>[];

    for (int row = 1; row <= _firstClassRows; row++) {
      for (final col in _columns) {
        final occupied = rng.nextDouble() < 0.70;
        seats.add(SeatModel(
          id: '$row$col',
          row: row,
          column: col,
          status: occupied ? SeatStatus.occupied : SeatStatus.premium,
          isPremium: true,
          extraCharge: 500.0,
        ));
      }
    }

    for (int row = _firstClassRows + 1; row <= _businessEndRow; row++) {
      for (final col in _columns) {
        final occupied = rng.nextDouble() < 0.70;
        seats.add(SeatModel(
          id: '$row$col',
          row: row,
          column: col,
          status: occupied ? SeatStatus.occupied : SeatStatus.premium,
          isPremium: true,
          extraCharge: 200.0,
        ));
      }
    }

    final remaining = flight.totalSeats - _fixedSeats;
    final economyRows = max((remaining / 6).ceil(), 10);
    for (int row = _economyStartRow; row < _economyStartRow + economyRows; row++) {
      for (final col in _columns) {
        final occupied = rng.nextDouble() < 0.70;
        seats.add(SeatModel(
          id: '$row$col',
          row: row,
          column: col,
          status: occupied ? SeatStatus.occupied : SeatStatus.available,
          isPremium: false,
        ));
      }
    }

    return seats;
  }
}
