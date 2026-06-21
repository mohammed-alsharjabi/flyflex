import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/passenger_model.dart';
import '../../data/repositories/passengers_repository.dart';
import '../state/passengers_state.dart';

class PassengersCubit extends Cubit<PassengersState> {
  PassengersCubit(this._repository) : super(const PassengersInitial());

  final PassengersRepository _repository;

  Future<void> loadExisting() async {
    try {
      final existing = await _repository.getLastPassenger();
      emit(PassengersEditing(existing: existing));
    } catch (_) {
      emit(const PassengersEditing());
    }
  }

  Future<bool> save(PassengerModel passenger) async {
    emit(PassengersEditing(existing: passenger, isSaving: true));
    try {
      await _repository.savePassenger(passenger);
      emit(PassengersSaved(passenger));
      return true;
    } catch (e) {
      emit(PassengersEditing(
        existing: passenger,
        errorMessage: e.toString(),
      ));
      return false;
    }
  }
}
