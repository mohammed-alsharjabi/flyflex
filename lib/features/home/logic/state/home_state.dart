import 'package:equatable/equatable.dart';
import '../../data/models/flight_category_model.dart';
import '../../../flights/data/models/flight_model.dart';
import '../../../cities/data/models/city_model.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

final class HomeInitial extends HomeState {
  const HomeInitial();
}

final class HomeLoading extends HomeState {
  const HomeLoading();
}

final class HomeLoaded extends HomeState {
  const HomeLoaded({
    required this.categories,
    required this.featuredFlights,
    required this.popularCities,
  });

  final List<FlightCategoryModel> categories;
  final List<FlightModel> featuredFlights;
  final List<CityModel> popularCities;

  @override
  List<Object?> get props => [categories, featuredFlights, popularCities];
}

final class HomeError extends HomeState {
  const HomeError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
