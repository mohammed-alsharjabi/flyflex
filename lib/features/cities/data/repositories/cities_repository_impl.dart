import '../datasources/cities_local_datasource.dart';
import '../models/city_model.dart';
import 'cities_repository.dart';

class CitiesRepositoryImpl implements CitiesRepository {
  const CitiesRepositoryImpl(this._datasource);

  final CitiesLocalDatasource _datasource;

  @override
  Future<List<CityModel>> getCities({String? type}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _datasource.getCities(type: type);
  }

  @override
  Future<CityModel?> getCityByCode(String code) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _datasource.getCityByCode(code);
  }
}
