import '../../../auth/data/models/user_model.dart';
import '../models/profile_model.dart';

abstract interface class ProfileRepository {
  Future<ProfileModel> getProfile();
  Future<void> updateProfile(UserModel user);
  Future<void> logout();
}
