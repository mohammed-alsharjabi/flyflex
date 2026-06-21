import 'package:fly_flex/features/flights/data/models/flight_model.dart';
import '../models/ticket_model.dart';

abstract interface class TicketsRepository {
  Future<TicketModel> generateAndSaveTicket({
    required String bookingId,
    required FlightModel flight,
    required String seatNumber,
  });
  Future<TicketModel?> getTicket(String bookingId);
  Future<List<TicketModel>> getAllTickets();
}
