import 'package:equatable/equatable.dart';
import '../../data/models/city_model.dart';

sealed class CitiesState extends Equatable {
  const CitiesState();

  @override
  List<Object?> get props => [];
}

final class CitiesInitial extends CitiesState {
  const CitiesInitial();
}

final class CitiesLoading extends CitiesState {
  const CitiesLoading();
}

final class CitiesLoaded extends CitiesState {
  const CitiesLoaded({
    required this.cities,
    this.flightType,
  });

  final List<CityModel> cities;
  final String? flightType;

  @override
  List<Object?> get props => [cities, flightType];
}

final class CitiesError extends CitiesState {
  const CitiesError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
