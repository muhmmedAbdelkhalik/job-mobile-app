import 'package:get/get.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../../../core/services/snackbar_service.dart';

class ProfileController extends GetxController {
  final AuthController _authController = Get.find<AuthController>();

  // Observable variables
  final RxBool _isLoading = false.obs;
  final RxString _errorMessage = ''.obs;

  // Getters
  bool get isLoading => _isLoading.value;
  String get errorMessage => _errorMessage.value;

  Future<void> updateProfile({
    String? name,
    String? email,
  }) async {
    try {
      _isLoading.value = true;
      _errorMessage.value = '';

      final data = <String, dynamic>{};
      if (name != null) data['name'] = name;
      if (email != null) data['email'] = email;

      await _authController.updateProfile(data);
    } catch (e) {
      _errorMessage.value = e.toString().replaceAll('Exception: ', '');
      SnackbarService.showError(title: 'Error', message: _errorMessage.value);
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await _authController.logout();
  }

  void clearError() {
    _errorMessage.value = '';
  }
}
