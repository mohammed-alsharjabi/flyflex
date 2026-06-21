import '../models/passenger_model.dart';

abstract interface class PassengersRepository {
  Future<void> savePassenger(PassengerModel passenger);
  Future<PassengerModel?> getLastPassenger();
}
