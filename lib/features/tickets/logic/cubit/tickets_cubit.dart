import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fly_flex/features/flights/data/models/flight_model.dart';
import '../../data/repositories/tickets_repository.dart';
import '../state/tickets_state.dart';

class TicketsCubit extends Cubit<TicketsState> {
  TicketsCubit(this._repository) : super(const TicketsInitial());

  final TicketsRepository _repository;

  Future<void> loadTicket(String bookingId) async {
    emit(const TicketsLoading());
    try {
      await Future.delayed(const Duration(milliseconds: 700));
      final ticket = await _repository.getTicket(bookingId) ??
          await _repository.generateAndSaveTicket(
            bookingId: bookingId,
            flight: _mockFlight(),
            seatNumber: '14C',
          );
      emit(TicketsLoaded(ticket));
    } catch (e) {
      emit(TicketsError(e.toString()));
    }
  }

  FlightModel _mockFlight() {
    final now = DateTime.now();
    return FlightModel(
      id: 'fl_mock',
      flightNumber: 'SV204',
      airline: 'Saudia',
      airlineCode: 'SV',
      fromCity: 'Riyadh',
      fromCode: 'RUH',
      toCity: 'Jeddah',
      toCode: 'JED',
      departureTime: now.add(const Duration(days: 1, hours: 8)),
      arrivalTime: now.add(const Duration(days: 1, hours: 9, minutes: 30)),
      durationMinutes: 90,
      price: 320,
      originalPrice: 480,
      availableSeats: 3,
      totalSeats: 180,
      cabinClass: CabinClass.economy,
    );
  }
}
