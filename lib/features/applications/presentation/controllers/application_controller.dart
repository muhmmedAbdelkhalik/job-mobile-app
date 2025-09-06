import 'package:get/get.dart';
import '../../domain/entities/application.dart';
import '../../domain/usecases/get_applications_usecase.dart';
import '../../domain/usecases/apply_for_job_usecase.dart';
import '../../../../core/services/snackbar_service.dart';

class ApplicationController extends GetxController {
  final GetApplicationsUseCase _getApplicationsUseCase;
  final ApplyForJobUseCase _applyForJobUseCase;

  ApplicationController({
    required GetApplicationsUseCase getApplicationsUseCase,
    required ApplyForJobUseCase applyForJobUseCase,
  }) : _getApplicationsUseCase = getApplicationsUseCase,
       _applyForJobUseCase = applyForJobUseCase;

  // Observable variables
  final RxBool _isLoading = false.obs;
  final RxList<Application> _applications = <Application>[].obs;
  final RxString _errorMessage = ''.obs;

  // Getters
  bool get isLoading => _isLoading.value;
  List<Application> get applications => _applications;
  String get errorMessage => _errorMessage.value;

  @override
  void onInit() {
    super.onInit();
    loadApplications();
  }

  Future<void> loadApplications({bool refresh = false}) async {
    try {
      _isLoading.value = true;
      _errorMessage.value = '';

      final applications = await _getApplicationsUseCase(refresh: refresh);
      _applications.value = applications;
      
      if (refresh) {
        SnackbarService.showSuccess(
          title: 'Success',
          message: 'Applications refreshed successfully',
          duration: const Duration(seconds: 2),
        );
      }
    } catch (e) {
      _errorMessage.value = e.toString().replaceAll('Exception: ', '');
      SnackbarService.showError(title: 'Error', message: _errorMessage.value);
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> applyForJob(String jobId, String resumeId) async {
    try {
      _isLoading.value = true;
      _errorMessage.value = '';

      final application = await _applyForJobUseCase(jobId, resumeId);
      _applications.insert(0, application);
      
        SnackbarService.showSuccess(
          title: 'Success',
          message: 'Application submitted successfully',
        );
    } catch (e) {
      _errorMessage.value = e.toString().replaceAll('Exception: ', '');
      SnackbarService.showError(title: 'Error', message: _errorMessage.value);
    } finally {
      _isLoading.value = false;
    }
  }

  /// Force refresh applications (bypass cache)
  Future<void> forceRefreshApplications() async {
    await loadApplications(refresh: true);
  }

  void clearError() {
    _errorMessage.value = '';
  }
}
