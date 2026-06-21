import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/flight_category_model.dart';
import '../../data/repositories/home_repository.dart';
import '../../../flights/data/models/flight_model.dart';
import '../../../cities/data/models/city_model.dart';
import '../state/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._repository) : super(const HomeInitial());

  final HomeRepository _repository;

  Future<void> loadHome() async {
    emit(const HomeLoading());
    try {
      final List<FlightCategoryModel> categories =
          await _repository.getCategories();
      final List<FlightModel> flights =
          await _repository.getFeaturedFlights();
      final List<CityModel> cities =
          await _repository.getPopularCities();

      emit(HomeLoaded(
        categories: categories,
        featuredFlights: flights,
        popularCities: cities,
      ));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> refresh() => loadHome();
}
