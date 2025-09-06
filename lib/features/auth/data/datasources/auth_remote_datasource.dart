import 'package:get_storage/get_storage.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/services/api_service.dart';
import '../../../../shared/models/api_response.dart';
import '../../domain/entities/auth_response.dart';
import '../../domain/entities/user.dart';

class AuthRemoteDataSource {
  final ApiService _apiService = ApiService();
  final GetStorage _storage = GetStorage();

  Future<AuthResponse> login(String email, String password) async {
    final response = await _apiService.post(
      AppConstants.authLogin,
      data: {
        'email': email,
        'password': password,
      },
    );

    final apiResponse = ApiResponse.fromJson(response, (data) => AuthResponse.fromJson(data));
    
    if (apiResponse.success && apiResponse.data != null) {
      await _storage.write(AppConstants.tokenKey, apiResponse.data!.token);
      await _storage.write(AppConstants.userKey, apiResponse.data!.user.toJson());
      return apiResponse.data!;
    } else {
      throw Exception(apiResponse.message);
    }
  }

  Future<AuthResponse> register(String name, String email, String password, String passwordConfirmation) async {
    final response = await _apiService.post(
      AppConstants.authRegister,
      data: {
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
      },
    );

    final apiResponse = ApiResponse.fromJson(response, (data) => AuthResponse.fromJson(data));
    
    if (apiResponse.success && apiResponse.data != null) {
      await _storage.write(AppConstants.tokenKey, apiResponse.data!.token);
      await _storage.write(AppConstants.userKey, apiResponse.data!.user.toJson());
      return apiResponse.data!;
    } else {
      throw Exception(apiResponse.message);
    }
  }

  Future<void> logout() async {
    try {
      await _apiService.post(AppConstants.authLogout);
    } finally {
      await _storage.remove(AppConstants.tokenKey);
      await _storage.remove(AppConstants.userKey);
    }
  }

  Future<User> getProfile() async {
    final response = await _apiService.get(AppConstants.profile);
    final apiResponse = ApiResponse.fromJson(response, (data) => User.fromJson(data));
    
    if (apiResponse.success && apiResponse.data != null) {
      await _storage.write(AppConstants.userKey, apiResponse.data!.toJson());
      return apiResponse.data!;
    } else {
      throw Exception(apiResponse.message);
    }
  }

  Future<User> updateProfile(Map<String, dynamic> data) async {
    final response = await _apiService.put(AppConstants.profile, data: data);
    final apiResponse = ApiResponse.fromJson(response, (data) => User.fromJson(data));
    
    if (apiResponse.success && apiResponse.data != null) {
      await _storage.write(AppConstants.userKey, apiResponse.data!.toJson());
      return apiResponse.data!;
    } else {
      throw Exception(apiResponse.message);
    }
  }

  Future<bool> isLoggedIn() async {
    final token = _storage.read(AppConstants.tokenKey);
    return token != null;
  }

  Future<String?> getToken() async {
    return _storage.read(AppConstants.tokenKey);
  }

  Future<void> clearToken() async {
    await _storage.remove(AppConstants.tokenKey);
    await _storage.remove(AppConstants.userKey);
  }
}
