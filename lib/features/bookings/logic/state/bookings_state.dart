import 'package:equatable/equatable.dart';
import '../../data/models/booking_model.dart';

sealed class BookingsState extends Equatable {
  const BookingsState();

  @override
  List<Object?> get props => [];
}

final class BookingsInitial extends BookingsState {
  const BookingsInitial();
}

final class BookingsLoading extends BookingsState {
  const BookingsLoading();
}

final class BookingsLoaded extends BookingsState {
  const BookingsLoaded({
    required this.upcoming,
    required this.past,
    this.selectedTab = 0,
  });

  final List<BookingModel> upcoming;
  final List<BookingModel> past;
  final int selectedTab;

  BookingsLoaded copyWith({
    List<BookingModel>? upcoming,
    List<BookingModel>? past,
    int? selectedTab,
  }) =>
      BookingsLoaded(
        upcoming: upcoming ?? this.upcoming,
        past: past ?? this.past,
        selectedTab: selectedTab ?? this.selectedTab,
      );

  @override
  List<Object?> get props => [upcoming, past, selectedTab];
}

final class BookingsError extends BookingsState {
  const BookingsError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
