import '../models/flight_category_model.dart';
import '../../../flights/data/models/flight_model.dart';
import '../../../cities/data/models/city_model.dart';

abstract interface class HomeRepository {
  Future<List<FlightCategoryModel>> getCategories();
  Future<List<FlightModel>> getFeaturedFlights();
  Future<List<CityModel>> getPopularCities();
}
