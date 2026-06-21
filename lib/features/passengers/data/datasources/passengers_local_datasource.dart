import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/passenger_model.dart';

class PassengersLocalDatasource {
  PassengersLocalDatasource(this._prefs);

  final SharedPreferences _prefs;

  static const String _key = 'last_passenger';

  Future<void> savePassenger(PassengerModel passenger) async {
    await _prefs.setString(_key, jsonEncode(passenger.toJson()));
  }

  Future<PassengerModel?> getLastPassenger() async {
    final json = _prefs.getString(_key);
    if (json == null) return null;
    return PassengerModel.fromJson(
        jsonDecode(json) as Map<String, dynamic>);
  }
}
