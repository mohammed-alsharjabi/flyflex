import '../datasources/passengers_local_datasource.dart';
import '../models/passenger_model.dart';
import 'passengers_repository.dart';

class PassengersRepositoryImpl implements PassengersRepository {
  PassengersRepositoryImpl(this._datasource);

  final PassengersLocalDatasource _datasource;

  @override
  Future<void> savePassenger(PassengerModel passenger) =>
      _datasource.savePassenger(passenger);

  @override
  Future<PassengerModel?> getLastPassenger() =>
      _datasource.getLastPassenger();
}
