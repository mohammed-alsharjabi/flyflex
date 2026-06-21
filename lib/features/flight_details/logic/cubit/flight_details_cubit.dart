import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../flights/data/models/flight_model.dart';
import '../../data/repositories/flight_details_repository.dart';
import '../state/flight_details_state.dart';

class FlightDetailsCubit extends Cubit<FlightDetailsState> {
  FlightDetailsCubit(this._repository) : super(const FlightDetailsInitial());

  final FlightDetailsRepository _repository;

  Future<void> loadDetails(FlightModel flight) async {
    emit(const FlightDetailsLoading());
    try {
      final details = await _repository.getFlightDetails(flight);
      emit(FlightDetailsLoaded(details));
    } catch (e) {
      emit(FlightDetailsError(e.toString()));
    }
  }
}
