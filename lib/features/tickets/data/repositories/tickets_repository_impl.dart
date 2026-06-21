import 'package:fly_flex/features/flights/data/models/flight_model.dart';
import '../datasources/tickets_local_datasource.dart';
import '../models/ticket_model.dart';
import 'tickets_repository.dart';

class TicketsRepositoryImpl implements TicketsRepository {
  const TicketsRepositoryImpl(this._datasource);

  final TicketsLocalDatasource _datasource;

  @override
  Future<TicketModel> generateAndSaveTicket({
    required String bookingId,
    required FlightModel flight,
    required String seatNumber,
  }) async {
    final ticket = _datasource.generateTicket(bookingId, flight, seatNumber);
    await _datasource.saveTicket(ticket);
    return ticket;
  }

  @override
  Future<TicketModel?> getTicket(String bookingId) =>
      _datasource.getTicket(bookingId);

  @override
  Future<List<TicketModel>> getAllTickets() async => [];
}
