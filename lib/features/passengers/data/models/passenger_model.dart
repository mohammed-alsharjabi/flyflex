import 'package:equatable/equatable.dart';

class PassengerModel extends Equatable {
  const PassengerModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.passportNumber,
    required this.passportExpiry,
    required this.nationality,
    required this.gender,
    this.countryCode,
    this.nationalId,
    this.mobile,
    this.email,
    this.phone,
    this.passportFileName,
  });

  final String id;
  final String firstName;
  final String lastName;
  final DateTime dateOfBirth;
  final String passportNumber;
  final DateTime passportExpiry;
  final String nationality;
  final String gender; // 'male' | 'female'
  final String? countryCode; // ISO 3166-1 alpha-2
  final String? nationalId;
  final String? mobile;
  final String? email;
  final String? phone;
  final String? passportFileName;

  String get fullName => '$firstName $lastName';

  bool get isPassportValid => passportExpiry.isAfter(DateTime.now());

  factory PassengerModel.fromJson(Map<String, dynamic> json) => PassengerModel(
        id: json['id'] as String,
        firstName: json['first_name'] as String,
        lastName: json['last_name'] as String,
        dateOfBirth: DateTime.parse(json['date_of_birth'] as String),
        passportNumber: json['passport_number'] as String,
        passportExpiry: json['passport_expiry'] != null
            ? DateTime.parse(json['passport_expiry'] as String)
            : DateTime.now().add(const Duration(days: 365 * 5)),
        nationality: json['nationality'] as String,
        gender: json['gender'] as String,
        countryCode: json['country_code'] as String?,
        nationalId: json['national_id'] as String?,
        mobile: json['mobile'] as String?,
        email: json['email'] as String?,
        phone: json['phone'] as String?,
        passportFileName: json['passport_file_name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'first_name': firstName,
        'last_name': lastName,
        'date_of_birth': dateOfBirth.toIso8601String(),
        'passport_number': passportNumber,
        'passport_expiry': passportExpiry.toIso8601String(),
        'nationality': nationality,
        'gender': gender,
        'country_code': countryCode,
        'national_id': nationalId,
        'mobile': mobile,
        'email': email,
        'phone': phone,
        'passport_file_name': passportFileName,
      };

  PassengerModel copyWith({
    String? firstName,
    String? lastName,
    DateTime? dateOfBirth,
    String? passportNumber,
    DateTime? passportExpiry,
    String? nationality,
    String? gender,
    String? countryCode,
    String? nationalId,
    String? mobile,
    String? email,
    String? phone,
    String? passportFileName,
  }) =>
      PassengerModel(
        id: id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        passportNumber: passportNumber ?? this.passportNumber,
        passportExpiry: passportExpiry ?? this.passportExpiry,
        nationality: nationality ?? this.nationality,
        gender: gender ?? this.gender,
        countryCode: countryCode ?? this.countryCode,
        nationalId: nationalId ?? this.nationalId,
        mobile: mobile ?? this.mobile,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        passportFileName: passportFileName ?? this.passportFileName,
      );

  @override
  List<Object?> get props => [id, passportNumber];
}
