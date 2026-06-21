import '../models/city_model.dart';

abstract interface class CitiesRepository {
  Future<List<CityModel>> getCities({String? type});
  Future<CityModel?> getCityByCode(String code);
}
