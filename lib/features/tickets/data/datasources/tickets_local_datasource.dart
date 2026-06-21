import 'package:shared_preferences/shared_preferences.dart';
import 'package:fly_flex/features/flights/data/models/flight_model.dart';
import '../models/ticket_model.dart';

class TicketsLocalDatasource {
  static const _prefix = 'ticket_';

  TicketModel generateTicket(
    String bookingId,
    FlightModel flight,
    String seatNumber,
  ) {
    final now = DateTime.now();
    final gateNum = (bookingId.hashCode % 20 + 1).abs();
    return TicketModel(
      bookingId: bookingId,
      flight: flight,
      passengerName: 'Mohammed Al-Sharjabi',
      seatNumber: seatNumber,
      cabinClass: flight.cabinClass,
      gate: 'B$gateNum',
      boardingTime: flight.departureTime.subtract(const Duration(minutes: 45)),
      status: 'confirmed',
      qrData: 'FLYFLEX-$bookingId',
      issuedAt: now,
    );
  }

  Future<void> saveTicket(TicketModel ticket) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      '$_prefix${ticket.bookingId}',
      ticket.toJsonString(),
    );
  }

  Future<TicketModel?> getTicket(String bookingId) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString('$_prefix$bookingId');
    if (raw == null) return null;
    try {
      return TicketModel.fromJsonString(raw);
    } catch (_) {
      return null;
    }
  }
}
