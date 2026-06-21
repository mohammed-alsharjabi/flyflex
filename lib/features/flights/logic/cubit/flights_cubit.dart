import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/flight_model.dart';
import '../../data/repositories/flights_repository.dart';
import '../state/flights_state.dart';

class FlightsCubit extends Cubit<FlightsState> {
  FlightsCubit(this._repository) : super(const FlightsInitial());

  final FlightsRepository _repository;
  List<FlightModel> _baseFlights = [];

  Future<void> loadDomestic() async {
    emit(const FlightsLoading());
    try {
      final flights = await _repository.getDomesticFlights();
      _baseFlights = flights;
      emit(FlightsLoaded(flights: flights));
    } catch (e) {
      emit(FlightsError(e.toString()));
    }
  }

  Future<void> loadInternational() async {
    emit(const FlightsLoading());
    try {
      final flights = await _repository.getInternationalFlights();
      _baseFlights = flights;
      emit(FlightsLoaded(flights: flights));
    } catch (e) {
      emit(FlightsError(e.toString()));
    }
  }

  Future<void> loadByRoute({
    required String fromCode,
    required String toCode,
  }) async {
    emit(const FlightsLoading());
    try {
      final flights = await _repository.getFlightsByRoute(
        fromCode: fromCode,
        toCode: toCode,
      );
      _baseFlights = flights;
      emit(FlightsLoaded(flights: flights));
    } catch (e) {
      emit(FlightsError(e.toString()));
    }
  }

  void filterByCabin(CabinClass? cabin) {
    final current = state;
    if (current is! FlightsLoaded) return;
    if (cabin == null) {
      emit(current.copyWith(clearFilter: true, clearCabin: true));
      return;
    }
    final filtered = _baseFlights
        .where((f) => f.cabinClass == cabin)
        .toList();
    emit(current.copyWith(
      filteredFlights: filtered,
      selectedCabin: cabin,
    ));
  }

  void sortByPrice(bool ascending) {
    final current = state;
    if (current is! FlightsLoaded) return;
    final source = List<FlightModel>.from(current.displayFlights);
    source.sort((a, b) =>
        ascending ? a.price.compareTo(b.price) : b.price.compareTo(a.price));
    emit(current.copyWith(filteredFlights: source));
  }
}
