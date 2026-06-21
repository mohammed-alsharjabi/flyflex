import 'package:equatable/equatable.dart';
import 'package:fly_flex/features/seat_selection/data/models/seat_model.dart';

sealed class SeatState extends Equatable {
  const SeatState();

  @override
  List<Object?> get props => [];
}

final class SeatInitial extends SeatState {
  const SeatInitial();
}

final class SeatLoading extends SeatState {
  const SeatLoading();
}

final class SeatLoaded extends SeatState {
  const SeatLoaded({
    required this.seats,
    required this.basePrice,
    this.selectedSeat,
  });

  final List<SeatModel> seats;
  final double basePrice;
  final SeatModel? selectedSeat;

  double get totalPrice => basePrice + (selectedSeat?.extraCharge ?? 0.0);

  @override
  List<Object?> get props => [seats, basePrice, selectedSeat];
}

final class SeatError extends SeatState {
  const SeatError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
