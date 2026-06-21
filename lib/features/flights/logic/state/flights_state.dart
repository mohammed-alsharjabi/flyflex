import 'package:equatable/equatable.dart';
import '../../data/models/flight_model.dart';

sealed class FlightsState extends Equatable {
  const FlightsState();

  @override
  List<Object?> get props => [];
}

final class FlightsInitial extends FlightsState {
  const FlightsInitial();
}

final class FlightsLoading extends FlightsState {
  const FlightsLoading();
}

final class FlightsLoaded extends FlightsState {
  const FlightsLoaded({
    required this.flights,
    this.filteredFlights,
    this.selectedCabin,
  });

  final List<FlightModel> flights;
  final List<FlightModel>? filteredFlights;
  final CabinClass? selectedCabin;

  List<FlightModel> get displayFlights => filteredFlights ?? flights;

  FlightsLoaded copyWith({
    List<FlightModel>? flights,
    List<FlightModel>? filteredFlights,
    CabinClass? selectedCabin,
    bool clearCabin = false,
    bool clearFilter = false,
  }) =>
      FlightsLoaded(
        flights: flights ?? this.flights,
        filteredFlights: clearFilter ? null : filteredFlights ?? this.filteredFlights,
        selectedCabin: clearCabin ? null : selectedCabin ?? this.selectedCabin,
      );

  @override
  List<Object?> get props => [flights, filteredFlights, selectedCabin];
}

final class FlightsError extends FlightsState {
  const FlightsError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
