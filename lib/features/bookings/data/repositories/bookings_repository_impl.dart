import '../datasources/bookings_local_datasource.dart';
import '../models/booking_model.dart';
import 'bookings_repository.dart';

class BookingsRepositoryImpl implements BookingsRepository {
  const BookingsRepositoryImpl(this._datasource);

  final BookingsLocalDatasource _datasource;

  @override
  Future<List<BookingModel>> getAllBookings() => _datasource.getAll();

  @override
  Future<List<BookingModel>> getUpcomingBookings() async {
    final all = await _datasource.getAll();
    return _datasource.getUpcoming(all);
  }

  @override
  Future<List<BookingModel>> getPastBookings() async {
    final all = await _datasource.getAll();
    return _datasource.getCompleted(all);
  }
}
