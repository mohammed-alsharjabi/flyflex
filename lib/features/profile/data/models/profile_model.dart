import 'package:equatable/equatable.dart';
import 'package:fly_flex/features/auth/data/models/user_model.dart';

class ProfileModel extends Equatable {
  const ProfileModel({
    required this.user,
    this.totalBookings = 0,
    this.totalFlights = 0,
    this.memberSince,
  });

  final UserModel user;
  final int totalBookings;
  final int totalFlights;
  final DateTime? memberSince;

  UserTier get memberTier => user.tier;

  static ProfileModel get mock => ProfileModel(
        user: UserModel.mock,
        totalBookings: 12,
        totalFlights: 8,
        memberSince: DateTime(2022, 3, 15),
      );

  @override
  List<Object?> get props => [user, totalBookings, totalFlights, memberSince];
}
