import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.avatarUrl,
    this.createdAt,
    this.passportNumber,
    this.nationality,
    this.dateOfBirth,
    this.loyaltyPoints = 0,
    this.tier = UserTier.silver,
  });

  final String id;
  final String name;
  final String email;
  final String? phone;
  final String? avatarUrl;
  final DateTime? createdAt;
  final String? passportNumber;
  final String? nationality;
  final DateTime? dateOfBirth;
  final int loyaltyPoints;
  final UserTier tier;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'] as String,
        name: json['name'] as String,
        email: json['email'] as String,
        phone: json['phone'] as String?,
        avatarUrl: json['avatar_url'] as String?,
        createdAt: json['created_at'] != null
            ? DateTime.parse(json['created_at'] as String)
            : null,
        passportNumber: json['passport_number'] as String?,
        nationality: json['nationality'] as String?,
        dateOfBirth: json['date_of_birth'] != null
            ? DateTime.parse(json['date_of_birth'] as String)
            : null,
        loyaltyPoints: json['loyalty_points'] as int? ?? 0,
        tier: UserTier.fromString(json['tier'] as String? ?? 'silver'),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'phone': phone,
        'avatar_url': avatarUrl,
        'created_at': createdAt?.toIso8601String(),
        'passport_number': passportNumber,
        'nationality': nationality,
        'date_of_birth': dateOfBirth?.toIso8601String(),
        'loyalty_points': loyaltyPoints,
        'tier': tier.name,
      };

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? avatarUrl,
    DateTime? createdAt,
    String? passportNumber,
    String? nationality,
    DateTime? dateOfBirth,
    int? loyaltyPoints,
    UserTier? tier,
  }) =>
      UserModel(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        avatarUrl: avatarUrl ?? this.avatarUrl,
        createdAt: createdAt ?? this.createdAt,
        passportNumber: passportNumber ?? this.passportNumber,
        nationality: nationality ?? this.nationality,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        loyaltyPoints: loyaltyPoints ?? this.loyaltyPoints,
        tier: tier ?? this.tier,
      );

  static UserModel get mock => UserModel(
        id: 'usr_001',
        name: 'Mohammed Al-Sharjabi',
        email: 'mohammed@flyflex.app',
        phone: '+966501234567',
        nationality: 'SA',
        createdAt: DateTime(2024, 1, 1),
        loyaltyPoints: 2840,
        tier: UserTier.gold,
      );

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        phone,
        avatarUrl,
        createdAt,
        passportNumber,
        nationality,
        dateOfBirth,
        loyaltyPoints,
        tier,
      ];
}

enum UserTier {
  silver,
  gold,
  platinum;

  static UserTier fromString(String value) => UserTier.values.firstWhere(
        (t) => t.name == value,
        orElse: () => UserTier.silver,
      );

  String get label {
    switch (this) {
      case UserTier.silver:
        return 'Silver';
      case UserTier.gold:
        return 'Gold';
      case UserTier.platinum:
        return 'Platinum';
    }
  }
}
