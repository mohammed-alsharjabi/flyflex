import 'package:equatable/equatable.dart';
import '../../data/models/passenger_model.dart';

sealed class PassengersState extends Equatable {
  const PassengersState();

  @override
  List<Object?> get props => [];
}

final class PassengersInitial extends PassengersState {
  const PassengersInitial();
}

final class PassengersEditing extends PassengersState {
  const PassengersEditing({
    this.existing,
    this.isSaving = false,
    this.errorMessage,
  });

  final PassengerModel? existing;
  final bool isSaving;
  final String? errorMessage;

  PassengersEditing copyWith({
    PassengerModel? existing,
    bool? isSaving,
    String? errorMessage,
  }) =>
      PassengersEditing(
        existing: existing ?? this.existing,
        isSaving: isSaving ?? this.isSaving,
        errorMessage: errorMessage,
      );

  @override
  List<Object?> get props => [existing, isSaving, errorMessage];
}

final class PassengersSaved extends PassengersState {
  const PassengersSaved(this.passenger);

  final PassengerModel passenger;

  @override
  List<Object?> get props => [passenger];
}
