import 'package:get/get.dart';
import '../../features/auth/data/datasources/auth_remote_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/domain/usecases/register_usecase.dart';
import '../../features/auth/presentation/controllers/auth_controller.dart';

class SplashController extends GetxController {
  final RxBool _isLoading = true.obs;
  final RxBool _isLoggedIn = false.obs;

  bool get isLoading => _isLoading.value;
  bool get isLoggedIn => _isLoggedIn.value;

  @override
  void onInit() {
    super.onInit();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    try {
      // Create auth repository to check login status
      final authRemoteDataSource = AuthRemoteDataSource();
      final authRepository = AuthRepositoryImpl(authRemoteDataSource);
      
      final isLoggedIn = await authRepository.isLoggedIn();
      _isLoggedIn.value = isLoggedIn;
      
      // Navigate based on auth status
      if (isLoggedIn) {
        // Initialize auth controller and navigate to home
        final loginUseCase = LoginUseCase(authRepository);
        final registerUseCase = RegisterUseCase(authRepository);
        
        // Only create AuthController if it doesn't exist
        if (!Get.isRegistered<AuthController>()) {
          Get.put(AuthController(
            loginUseCase: loginUseCase,
            registerUseCase: registerUseCase,
            authRepository: authRepository,
          ), permanent: true);
        }
        
        Future.delayed(const Duration(seconds: 2), () {
          Get.offAllNamed('/home');
        });
      } else {
        Future.delayed(const Duration(seconds: 2), () {
          Get.offAllNamed('/login');
        });
      }
    } catch (e) {
      // If there's an error, go to login
      Future.delayed(const Duration(seconds: 2), () {
        Get.offAllNamed('/login');
      });
    } finally {
      _isLoading.value = false;
    }
  }
}
