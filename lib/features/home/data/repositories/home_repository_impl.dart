import '../datasources/home_local_datasource.dart';
import '../models/flight_category_model.dart';
import '../../../flights/data/models/flight_model.dart';
import '../../../cities/data/models/city_model.dart';
import 'home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  const HomeRepositoryImpl(this._datasource);

  final HomeLocalDatasource _datasource;

  @override
  Future<List<FlightCategoryModel>> getCategories() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _datasource.getCategories();
  }

  @override
  Future<List<FlightModel>> getFeaturedFlights() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _datasource.getFeaturedFlights();
  }

  @override
  Future<List<CityModel>> getPopularCities() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _datasource.getPopularCities();
  }
}
