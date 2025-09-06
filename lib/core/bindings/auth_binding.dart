import 'package:get/get.dart';
import '../../features/auth/data/datasources/auth_remote_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/domain/usecases/register_usecase.dart';
import '../../features/auth/presentation/controllers/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    // Data sources
    final authRemoteDataSource = AuthRemoteDataSource();
    
    // Repositories
    final authRepository = AuthRepositoryImpl(authRemoteDataSource);
    
    // Use cases
    final loginUseCase = LoginUseCase(authRepository);
    final registerUseCase = RegisterUseCase(authRepository);
    
  // Controllers - using put with permanent to ensure it persists across bindings
  Get.put<AuthController>(AuthController(
    loginUseCase: loginUseCase,
    registerUseCase: registerUseCase,
    authRepository: authRepository,
  ), permanent: true);
  }
}
