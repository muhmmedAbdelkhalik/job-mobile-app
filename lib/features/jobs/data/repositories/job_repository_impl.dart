import 'package:flutter/foundation.dart';
import '../../../../shared/models/api_response.dart';
import '../../../../core/cache/hive_cache_manager.dart';
import '../../domain/entities/job.dart';
import '../../domain/repositories/job_repository.dart';
import '../datasources/job_remote_datasource.dart';

class JobRepositoryImpl implements JobRepository {
  final JobRemoteDataSource _remoteDataSource;

  JobRepositoryImpl(this._remoteDataSource);

  @override
  Future<ApiResponse<List<Job>>> getJobs({
    String? search,
    String? location,
    String? type,
    int page = 1,
    int perPage = 15,
    bool refresh = false,
  }) async {
    // Clear cache if refreshing
    if (refresh && page == 1) {
      debugPrint('🗑️ Clearing jobs cache for refresh');
      await HiveCacheManager.clearCache(
        HiveCacheManager.getJobsCacheKey(
          search: search,
          location: location,
          type: type,
          page: page,
        ),
      );
    }
    
    // Try to get from cache first (only for page 1, no filters, and not refreshing)
    if (page == 1 && search == null && location == null && type == null && !refresh) {
      final cachedJobs = HiveCacheManager.getCachedJobs(
        search: search,
        location: location,
        type: type,
        page: page,
      );
      
      if (cachedJobs != null) {
        try {
          final jobs = cachedJobs.map((job) => Job.fromJson(job)).toList();
          return ApiResponse<List<Job>>(
            success: true,
            data: jobs,
            message: 'Data loaded from cache',
          );
        } catch (e) {
          // If cached data is corrupted, clear it and continue with API call
          await HiveCacheManager.clearCache(
            HiveCacheManager.getJobsCacheKey(
              search: search,
              location: location,
              type: type,
              page: page,
            ),
          );
        }
      }
    }
    
    // Fetch from API
    debugPrint('🌐 Fetching jobs from API (refresh: $refresh)');
    final response = await _remoteDataSource.getJobs(
      search: search,
      location: location,
      type: type,
      page: page,
      perPage: perPage,
    );
    
    // Cache successful responses for page 1 with no filters
    if (response.success && 
        response.data != null && 
        page == 1 && 
        search == null && 
        location == null && 
        type == null) {
      try {
        final jobsJson = response.data!.map((job) => job.toJson()).toList();
        await HiveCacheManager.cacheJobs(
          jobsJson,
          search: search,
          location: location,
          type: type,
          page: page,
        );
      } catch (e) {
        // If caching fails, log error but don't fail the request
        // Log error but don't fail the request
        debugPrint('Failed to cache jobs: $e');
      }
    }
    
    return response;
  }

  @override
  Future<Job> getJobById(String jobId) async {
    // Try to get from cache first
    final cachedJobDetails = HiveCacheManager.getCachedJobDetails(jobId);
    if (cachedJobDetails != null) {
      try {
        return Job.fromJson(cachedJobDetails);
      } catch (e) {
        // If cached data is corrupted, clear it and continue with API call
        await HiveCacheManager.clearCache('cached_job_details_$jobId');
      }
    }
    
    // Fetch from API
    final job = await _remoteDataSource.getJobById(jobId);
    
    // Cache the job details
    try {
      await HiveCacheManager.cacheJobDetails(jobId, job.toJson());
    } catch (e) {
      // If caching fails, log error but don't fail the request
      debugPrint('Failed to cache job details: $e');
    }
    
    return job;
  }
}
