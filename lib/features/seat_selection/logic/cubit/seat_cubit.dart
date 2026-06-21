import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fly_flex/features/flights/data/models/flight_model.dart';
import 'package:fly_flex/features/seat_selection/data/models/seat_model.dart';
import 'package:fly_flex/features/seat_selection/data/repositories/seat_repository.dart';
import 'package:fly_flex/features/seat_selection/logic/state/seat_state.dart';

class SeatCubit extends Cubit<SeatState> {
  SeatCubit(this._repository) : super(const SeatInitial());

  final SeatRepository _repository;

  Future<void> loadSeats(FlightModel flight) async {
    emit(const SeatLoading());
    try {
      final seats = await _repository.getSeatMap(flight);
      emit(SeatLoaded(seats: seats, basePrice: flight.price));
    } catch (e) {
      emit(SeatError(e.toString()));
    }
  }

  void selectSeat(SeatModel seat) {
    final current = state;
    if (current is! SeatLoaded) return;
    if (!seat.isSelectable) return;

    final wasSelected = current.selectedSeat?.id == seat.id;

    final updatedSeats = current.seats.map((s) {
      if (s.id == seat.id) {
        return s.copyWith(
          status: wasSelected
              ? (s.isPremium ? SeatStatus.premium : SeatStatus.available)
              : SeatStatus.selected,
        );
      }
      if (s.status == SeatStatus.selected) {
        return s.copyWith(
          status: s.isPremium ? SeatStatus.premium : SeatStatus.available,
        );
      }
      return s;
    }).toList();

    emit(SeatLoaded(
      seats: updatedSeats,
      basePrice: current.basePrice,
      selectedSeat: wasSelected ? null : seat,
    ));
  }

  void deselectSeat() {
    final current = state;
    if (current is! SeatLoaded || current.selectedSeat == null) return;

    final updatedSeats = current.seats.map((s) {
      if (s.status == SeatStatus.selected) {
        return s.copyWith(
          status: s.isPremium ? SeatStatus.premium : SeatStatus.available,
        );
      }
      return s;
    }).toList();

    emit(SeatLoaded(seats: updatedSeats, basePrice: current.basePrice));
  }
}
