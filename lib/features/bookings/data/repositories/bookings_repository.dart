import '../models/booking_model.dart';

abstract interface class BookingsRepository {
  Future<List<BookingModel>> getAllBookings();
  Future<List<BookingModel>> getUpcomingBookings();
  Future<List<BookingModel>> getPastBookings();
}
