import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/booking_model.dart';
import '../../data/repositories/bookings_repository.dart';
import '../state/bookings_state.dart';

class BookingsCubit extends Cubit<BookingsState> {
  BookingsCubit(this._repository) : super(const BookingsInitial());

  final BookingsRepository _repository;

  Future<void> loadBookings() async {
    emit(const BookingsLoading());
    try {
      final all = await _repository.getAllBookings();
      final upcoming =
          all.where((b) => b.status == BookingStatus.upcoming).toList();
      final past =
          all.where((b) => b.status != BookingStatus.upcoming).toList();
      emit(BookingsLoaded(upcoming: upcoming, past: past));
    } catch (e) {
      emit(BookingsError(e.toString()));
    }
  }

  void selectTab(int tab) {
    if (state is BookingsLoaded) {
      emit((state as BookingsLoaded).copyWith(selectedTab: tab));
    }
  }
}
