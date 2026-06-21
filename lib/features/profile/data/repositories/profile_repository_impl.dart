import '../../../auth/data/models/user_model.dart';
import '../datasources/profile_local_datasource.dart';
import '../models/profile_model.dart';
import 'profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  const ProfileRepositoryImpl(this._datasource);

  final ProfileLocalDatasource _datasource;

  @override
  Future<ProfileModel> getProfile() => _datasource.getProfile();

  @override
  Future<void> updateProfile(UserModel user) => _datasource.saveProfile(user);

  @override
  Future<void> logout() => _datasource.clearProfile();
}
