import 'package:shared_preferences/shared_preferences.dart';
import '../../../auth/data/models/user_model.dart';
import '../models/profile_model.dart';

class ProfileLocalDatasource {
  static const _keyUserId = 'profile_user_id';

  Future<ProfileModel> getProfile() async {
    await Future.delayed(const Duration(milliseconds: 500));
    final prefs = await SharedPreferences.getInstance();
    final hasProfile = prefs.containsKey(_keyUserId);
    if (!hasProfile) return ProfileModel.mock;
    return ProfileModel.mock;
  }

  Future<void> saveProfile(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUserId, user.id);
  }

  Future<void> clearProfile() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyUserId);
  }
}
