import '../../data/constants/countries.dart';
import '../../data/models/country_model.dart';

class PassportScanResult {
  const PassportScanResult({
    required this.firstName,
    required this.lastName,
    required this.passportNumber,
    required this.dateOfBirth,
    required this.passportExpiry,
    required this.gender,
    required this.country,
  });

  final String firstName;
  final String lastName;
  final String passportNumber;
  final DateTime dateOfBirth;
  final DateTime passportExpiry;
  final String gender;
  final CountryModel country;
}

/// Mock OCR service — simulates reading passport data from an uploaded file.
class PassportScanService {
  PassportScanService._();

  static Future<PassportScanResult> scanFromFile(String fileName) async {
    await Future<void>.delayed(const Duration(milliseconds: 1600));

    return PassportScanResult(
      firstName: 'Ahmed',
      lastName: 'Al-Rashid',
      passportNumber: 'A12345678',
      dateOfBirth: DateTime(1990, 5, 15),
      passportExpiry: DateTime(2030, 3, 20),
      gender: 'male',
      country: Countries.saudiArabia,
    );
  }
}
