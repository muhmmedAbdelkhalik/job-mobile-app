import '../entities/auth_response.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<AuthResponse> login(String email, String password);
  Future<AuthResponse> register(String name, String email, String password, String passwordConfirmation);
  Future<void> logout();
  Future<User> getProfile();
  Future<User> updateProfile(Map<String, dynamic> data);
  Future<bool> isLoggedIn();
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> clearToken();
}
