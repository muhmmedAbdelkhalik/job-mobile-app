import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../domain/entities/job.dart';
import '../../domain/usecases/get_jobs_usecase.dart';
import '../../domain/usecases/get_job_by_id_usecase.dart';
import '../../../../core/cache/hive_cache_manager.dart';
import '../../../../core/services/snackbar_service.dart';

class JobController extends GetxController {
  final GetJobsUseCase _getJobsUseCase;
  final GetJobByIdUseCase _getJobByIdUseCase;

  JobController({
    required GetJobsUseCase getJobsUseCase,
    required GetJobByIdUseCase getJobByIdUseCase,
  }) : _getJobsUseCase = getJobsUseCase,
       _getJobByIdUseCase = getJobByIdUseCase;

  // Observable variables
  final RxBool _isLoading = false.obs;
  final RxList<Job> _jobs = <Job>[].obs;
  final Rx<Job?> _selectedJob = Rx<Job?>(null);
  final RxString _searchQuery = ''.obs;
  final RxString _selectedType = ''.obs;
  final RxString _selectedLocation = ''.obs;
  final RxInt _currentPage = 1.obs;
  final RxBool _hasMorePages = false.obs;
  final RxString _errorMessage = ''.obs;

  // Getters
  bool get isLoading => _isLoading.value;
  List<Job> get jobs => _jobs;
  Job? get selectedJob => _selectedJob.value;
  String get searchQuery => _searchQuery.value;
  String get selectedType => _selectedType.value;
  String get selectedLocation => _selectedLocation.value;
  int get currentPage => _currentPage.value;
  bool get hasMorePages => _hasMorePages.value;
  String get errorMessage => _errorMessage.value;

  // Filter options
  final List<String> jobTypes = ['all', 'full-time', 'part-time', 'hybrid', 'remote'];
  final List<String> locations = ['all', 'remote', 'new-york', 'san-francisco', 'london'];

  @override
  void onInit() {
    super.onInit();
    loadJobs();
  }

  Future<void> loadJobs({bool refresh = false}) async {
    try {
      _isLoading.value = true;
      _errorMessage.value = '';

      if (refresh) {
        debugPrint('🔄 Refreshing jobs - clearing cache and resetting pagination');
        _currentPage.value = 1;
        _jobs.clear();
      }

      final response = await _getJobsUseCase(
        search: _searchQuery.value.isNotEmpty ? _searchQuery.value : null,
        location: _selectedLocation.value.isNotEmpty && _selectedLocation.value != 'all' 
            ? _selectedLocation.value 
            : null,
        type: _selectedType.value.isNotEmpty && _selectedType.value != 'all' 
            ? _selectedType.value 
            : null,
        page: _currentPage.value,
        refresh: refresh,
      );

      if (response.success && response.data != null) {
        if (refresh) {
          _jobs.value = response.data!;
          SnackbarService.showSuccess(
            title: 'Success',
            message: 'Jobs refreshed successfully',
            duration: const Duration(seconds: 2),
          );
        } else {
          _jobs.addAll(response.data!);
        }

        // Update pagination info
        if (response.meta != null && response.meta!['pagination'] != null) {
          final pagination = response.meta!['pagination'];
          _hasMorePages.value = pagination['has_more_pages'] ?? false;
        }
      } else {
        _errorMessage.value = response.message;
        SnackbarService.showError(title: 'Error', message: response.message);
      }
    } catch (e) {
      _errorMessage.value = e.toString().replaceAll('Exception: ', '');
      SnackbarService.showError(title: 'Error', message: _errorMessage.value);
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> loadMoreJobs() async {
    if (!_isLoading.value && _hasMorePages.value) {
      _currentPage.value++;
      await loadJobs();
    }
  }

  Future<void> searchJobs(String query) async {
    _searchQuery.value = query;
    await loadJobs(refresh: true);
  }

  void filterByType(String type) {
    _selectedType.value = type;
    loadJobs(refresh: true);
  }

  void filterByLocation(String location) {
    _selectedLocation.value = location;
    loadJobs(refresh: true);
  }

  void clearFilters() {
    _searchQuery.value = '';
    _selectedType.value = '';
    _selectedLocation.value = '';
    loadJobs(refresh: true);
  }

  Future<void> getJobById(String jobId) async {
    try {
      _isLoading.value = true;
      _errorMessage.value = '';

      final job = await _getJobByIdUseCase(jobId);
      _selectedJob.value = job;
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

  /// Clear jobs cache
  Future<void> clearJobsCache() async {
    await HiveCacheManager.clearCache('cached_jobs');
    SnackbarService.showSuccess(title: 'Success', message: 'Jobs cache cleared');
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

  /// Check if jobs are cached
  bool hasCachedJobs() {
    return HiveCacheManager.hasValidCache('cached_jobs');
  }

  /// Check if specific job details are cached
  bool hasCachedJobDetails(String jobId) {
    return HiveCacheManager.hasValidCache('cached_job_details_$jobId');
  }

  /// Clear specific job details cache
  Future<void> clearJobDetailsCache(String jobId) async {
    await HiveCacheManager.clearCache('cached_job_details_$jobId');
  }

  /// Force refresh jobs (bypass cache)
  Future<void> forceRefreshJobs() async {
    await clearJobsCache();
    await loadJobs(refresh: true);
  }

  /// Force refresh job details (bypass cache)
  Future<void> forceRefreshJobDetails(String jobId) async {
    await clearJobDetailsCache(jobId);
    await getJobById(jobId);
  }
}
