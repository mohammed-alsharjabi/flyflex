import 'package:equatable/equatable.dart';
import '../../data/models/flight_details_model.dart';

sealed class FlightDetailsState extends Equatable {
  const FlightDetailsState();

  @override
  List<Object?> get props => [];
}

final class FlightDetailsInitial extends FlightDetailsState {
  const FlightDetailsInitial();
}

final class FlightDetailsLoading extends FlightDetailsState {
  const FlightDetailsLoading();
}

final class FlightDetailsLoaded extends FlightDetailsState {
  const FlightDetailsLoaded(this.details);

  final FlightDetailsModel details;

  @override
  List<Object?> get props => [details];
}

final class FlightDetailsError extends FlightDetailsState {
  const FlightDetailsError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
