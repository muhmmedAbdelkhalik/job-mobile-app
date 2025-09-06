import 'package:flutter/foundation.dart';
import '../../domain/entities/auth_response.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../../../../core/cache/hive_cache_manager.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl(this._remoteDataSource);

  @override
  Future<AuthResponse> login(String email, String password) async {
    return await _remoteDataSource.login(email, password);
  }

  @override
  Future<AuthResponse> register(String name, String email, String password, String passwordConfirmation) async {
    return await _remoteDataSource.register(name, email, password, passwordConfirmation);
  }

  @override
  Future<void> logout() async {
    // Clear user cache on logout
    await HiveCacheManager.clearCache('cached_user');
    return await _remoteDataSource.logout();
  }

  @override
  Future<User> getProfile() async {
    // Try to get from cache first
    final cachedUser = HiveCacheManager.getCachedUser();
    if (cachedUser != null) {
      try {
        return User.fromJson(cachedUser);
      } catch (e) {
        // If cached data is corrupted, clear it and continue with API call
        await HiveCacheManager.clearCache('cached_user');
      }
    }
    
    // Fetch from API
    final user = await _remoteDataSource.getProfile();
    
    // Cache the user data
    try {
      await HiveCacheManager.cacheUser(user.toJson());
    } catch (e) {
      // If caching fails, log error but don't fail the request
      debugPrint('Failed to cache user: $e');
    }
    
    return user;
  }

  @override
  Future<User> updateProfile(Map<String, dynamic> data) async {
    final user = await _remoteDataSource.updateProfile(data);
    
    // Update cached user data
    try {
      await HiveCacheManager.cacheUser(user.toJson());
    } catch (e) {
      debugPrint('Failed to update cached user: $e');
    }
    
    return user;
  }

  @override
  Future<bool> isLoggedIn() async {
    return await _remoteDataSource.isLoggedIn();
  }

  @override
  Future<void> saveToken(String token) async {
    // Token is automatically saved in the data source
  }

  @override
  Future<String?> getToken() async {
    return await _remoteDataSource.getToken();
  }

  @override
  Future<void> clearToken() async {
    return await _remoteDataSource.clearToken();
  }
}
