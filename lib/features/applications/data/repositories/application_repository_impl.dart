import 'package:flutter/foundation.dart';
import '../../domain/entities/application.dart';
import '../../domain/repositories/application_repository.dart';
import '../datasources/application_remote_datasource.dart';
import '../../../../core/cache/hive_cache_manager.dart';

class ApplicationRepositoryImpl implements ApplicationRepository {
  final ApplicationRemoteDataSource _remoteDataSource;

  ApplicationRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<Application>> getApplications({bool refresh = false}) async {
    // Clear cache if refreshing
    if (refresh) {
      debugPrint('🗑️ Clearing applications cache for refresh');
      await HiveCacheManager.clearCache('cached_applications');
    }
    
    // Try to get from cache first (only if not refreshing)
    if (!refresh) {
      final cachedApplications = HiveCacheManager.getCachedApplications();
      if (cachedApplications != null) {
        try {
          return cachedApplications.map((application) => Application.fromJson(application)).toList();
        } catch (e) {
          // If cached data is corrupted, clear it and continue with API call
          await HiveCacheManager.clearCache('cached_applications');
        }
      }
    }
    
    // Fetch from API
    debugPrint('🌐 Fetching applications from API (refresh: $refresh)');
    final applications = await _remoteDataSource.getApplications();
    
    // Cache the applications data
    try {
      final applicationsJson = applications.map((application) => application.toJson()).toList();
      await HiveCacheManager.cacheApplications(applicationsJson);
    } catch (e) {
      debugPrint('Failed to cache applications: $e');
    }
    
    return applications;
  }

  @override
  Future<Application> getApplicationById(String applicationId) async {
    return await _remoteDataSource.getApplicationById(applicationId);
  }

  @override
  Future<Application> applyForJob(String jobId, String resumeId) async {
    final application = await _remoteDataSource.applyForJob(jobId, resumeId);
    
    // Clear applications cache since we added a new application
    await HiveCacheManager.clearCache('cached_applications');
    
    return application;
  }
}
