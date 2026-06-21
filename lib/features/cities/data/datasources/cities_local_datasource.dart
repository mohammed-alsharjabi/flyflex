import '../models/city_model.dart';

class CitiesLocalDatasource {
  static const _domestic = [
    CityModel(
      id: 'ruh',
      name: 'Riyadh',
      code: 'RUH',
      country: 'Saudi Arabia',
      imagePath: 'assets/cities/riyadh.png',
      availableFlights: 24,
      isPopular: true,
    ),
    CityModel(
      id: 'jed',
      name: 'Jeddah',
      code: 'JED',
      country: 'Saudi Arabia',
      imagePath: 'assets/cities/jeddah.png',
      availableFlights: 18,
      isPopular: true,
    ),
    CityModel(
      id: 'dmm',
      name: 'Dammam',
      code: 'DMM',
      country: 'Saudi Arabia',
      imagePath: 'assets/cities/dammam.png',
      availableFlights: 12,
      isPopular: true,
    ),
    CityModel(
      id: 'mkk',
      name: 'Makkah',
      code: 'MKK',
      country: 'Saudi Arabia',
      imagePath: 'assets/cities/makkah.png',
      availableFlights: 8,
      isPopular: false,
    ),
    CityModel(
      id: 'tuu',
      name: 'Tabuk',
      code: 'TUU',
      country: 'Saudi Arabia',
      imagePath: 'assets/cities/tabuk.png',
      availableFlights: 6,
      isPopular: false,
    ),
    CityModel(
      id: 'ulh',
      name: 'AlUla',
      code: 'ULH',
      country: 'Saudi Arabia',
      imagePath: 'assets/cities/alula.png',
      availableFlights: 4,
      isPopular: false,
    ),
  ];

  static const _international = [
    CityModel(
      id: 'dxb',
      name: 'Dubai',
      code: 'DXB',
      country: 'UAE',
      imagePath: 'assets/cities/dubai.png',
      availableFlights: 32,
      isPopular: true,
    ),
    CityModel(
      id: 'lhr',
      name: 'London',
      code: 'LHR',
      country: 'United Kingdom',
      imagePath: 'assets/cities/london.png',
      availableFlights: 14,
      isPopular: true,
    ),
    CityModel(
      id: 'ist',
      name: 'Istanbul',
      code: 'IST',
      country: 'Turkey',
      imagePath: 'assets/cities/istanbul.png',
      availableFlights: 16,
      isPopular: true,
    ),
    CityModel(
      id: 'cai',
      name: 'Cairo',
      code: 'CAI',
      country: 'Egypt',
      imagePath: 'assets/cities/cairo.png',
      availableFlights: 20,
      isPopular: true,
    ),
    CityModel(
      id: 'cdg',
      name: 'Paris',
      code: 'CDG',
      country: 'France',
      imagePath: 'assets/cities/paris.png',
      availableFlights: 10,
      isPopular: false,
    ),
    CityModel(
      id: 'jfk',
      name: 'New York',
      code: 'JFK',
      country: 'United States',
      imagePath: 'assets/cities/newyork.png',
      availableFlights: 8,
      isPopular: false,
    ),
  ];

  List<CityModel> getCities({String? type}) {
    if (type == 'international') return _international;
    return _domestic;
  }

  CityModel? getCityByCode(String code) {
    final all = [..._domestic, ..._international];
    try {
      return all.firstWhere((c) => c.code == code);
    } catch (_) {
      return null;
    }
  }
}
