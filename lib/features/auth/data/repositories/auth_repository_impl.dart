import '../datasources/auth_local_datasource.dart';
import '../models/user_model.dart';
import 'auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._datasource);

  final AuthLocalDatasource _datasource;

  @override
  Future<UserModel> login(String email, String password) async {
    final user = await _datasource.login(email, password);
    await _datasource.saveUser(user);
    return user;
  }

  @override
  Future<void> logout() => _datasource.clearUser();

  @override
  Future<UserModel?> getCurrentUser() => _datasource.getUser();

  @override
  Future<bool> isLoggedIn() => _datasource.isLoggedIn();
}
