import 'package:get/get.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../../../core/cache/hive_cache_manager.dart';
import '../../../../core/services/snackbar_service.dart';

class AuthController extends GetxController {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final AuthRepository _authRepository;

  AuthController({
    required LoginUseCase loginUseCase,
    required RegisterUseCase registerUseCase,
    required AuthRepository authRepository,
  }) : _loginUseCase = loginUseCase,
       _registerUseCase = registerUseCase,
       _authRepository = authRepository;

  // Observable variables
  final RxBool _isLoading = false.obs;
  final RxBool _isLoggedIn = false.obs;
  final Rx<User?> _currentUser = Rx<User?>(null);
  final RxString _errorMessage = ''.obs;

  // Getters
  bool get isLoading => _isLoading.value;
  bool get isLoggedIn => _isLoggedIn.value;
  User? get currentUser => _currentUser.value;
  String get errorMessage => _errorMessage.value;

  @override
  void onInit() {
    super.onInit();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    try {
      _isLoggedIn.value = await _authRepository.isLoggedIn();
      if (_isLoggedIn.value) {
        await getProfile();
      }
    } catch (e) {
      _isLoggedIn.value = false;
    }
  }

  Future<void> login(String email, String password) async {
    try {
      _isLoading.value = true;
      _errorMessage.value = '';

      final authResponse = await _loginUseCase(email, password);

      _currentUser.value = authResponse.user;
      _isLoggedIn.value = true;

      SnackbarService.showSuccess(title: 'Success', message: 'Login successful');

      Get.offAllNamed('/home');
    } catch (e) {
      _errorMessage.value = e.toString().replaceAll('Exception: ', '');
      SnackbarService.showError(title: 'Error', message: _errorMessage.value);
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> register(String name, String email, String password, String passwordConfirmation) async {
    try {
      _isLoading.value = true;
      _errorMessage.value = '';

      final authResponse = await _registerUseCase(name, email, password, passwordConfirmation);

      _currentUser.value = authResponse.user;
      _isLoggedIn.value = true;

      SnackbarService.showSuccess(title: 'Success', message: 'Registration successful');

      Get.offAllNamed('/home');
    } catch (e) {
      _errorMessage.value = e.toString().replaceAll('Exception: ', '');
      SnackbarService.showError(title: 'Error', message: _errorMessage.value);
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> logout() async {
    try {
      _isLoading.value = true;

      // Clear all cache first
      await HiveCacheManager.clearAllCache();

      // Call repository logout (clears token and user data)
      await _authRepository.logout();

      // Reset auth state
      _currentUser.value = null;
      _isLoggedIn.value = false;
      _errorMessage.value = '';

      SnackbarService.showSuccess(title: 'Success', message: 'Logged out successfully');

      // Navigate to login page
      Get.offAllNamed('/login');
    } catch (e) {
      _errorMessage.value = e.toString().replaceAll('Exception: ', '');
      SnackbarService.showError(title: 'Error', message: _errorMessage.value);
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> getProfile() async {
    try {
      final user = await _authRepository.getProfile();
      _currentUser.value = user;
    } catch (e) {
      _errorMessage.value = e.toString().replaceAll('Exception: ', '');
    }
  }

  Future<void> updateProfile(Map<String, dynamic> data) async {
    try {
      _isLoading.value = true;
      _errorMessage.value = '';

      final user = await _authRepository.updateProfile(data);
      _currentUser.value = user;

      SnackbarService.showSuccess(title: 'Success', message: 'Profile updated successfully');
    } catch (e) {
      _errorMessage.value = e.toString().replaceAll('Exception: ', '');
      SnackbarService.showError(title: 'Error', message: _errorMessage.value);
    } finally {
      _isLoading.value = false;
    }
  }

  void clearError() {
    _errorMessage.value = '';
  }

  // ========== CACHE MANAGEMENT METHODS ==========

  /// Clear user cache
  Future<void> clearUserCache() async {
    await HiveCacheManager.clearCache('cached_user');
    SnackbarService.showSuccess(title: 'Success', message: 'User cache cleared');
  }

  /// Clear all cache
  Future<void> clearAllCache() async {
    await HiveCacheManager.clearAllCache();
    SnackbarService.showSuccess(title: 'Success', message: 'All cache cleared');
  }

  /// Get cache statistics
  Map<String, dynamic> getCacheStats() {
    return HiveCacheManager.getCacheStats();
  }

  /// Check if user is cached
  bool hasCachedUser() {
    return HiveCacheManager.hasValidCache('cached_user');
  }
}
