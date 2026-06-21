import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/cities_repository.dart';
import '../state/cities_state.dart';

class CitiesCubit extends Cubit<CitiesState> {
  CitiesCubit(this._repository) : super(const CitiesInitial());

  final CitiesRepository _repository;

  Future<void> loadCities({String? type}) async {
    emit(const CitiesLoading());
    try {
      final cities = await _repository.getCities(type: type);
      emit(CitiesLoaded(cities: cities, flightType: type));
    } catch (e) {
      emit(CitiesError(e.toString()));
    }
  }
}
