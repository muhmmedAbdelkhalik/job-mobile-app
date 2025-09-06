import 'dart:io';
import 'package:flutter/foundation.dart';
import '../../domain/entities/resume.dart';
import '../../domain/repositories/resume_repository.dart';
import '../datasources/resume_remote_datasource.dart';
import '../../../../core/cache/hive_cache_manager.dart';

class ResumeRepositoryImpl implements ResumeRepository {
  final ResumeRemoteDataSource _remoteDataSource;

  ResumeRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<Resume>> getResumes({bool refresh = false}) async {
    // Clear cache if refreshing
    if (refresh) {
      debugPrint('🗑️ Clearing resumes cache for refresh');
      await HiveCacheManager.clearCache('cached_resumes');
    }
    
    // Try to get from cache first (only if not refreshing)
    if (!refresh) {
      final cachedResumes = HiveCacheManager.getCachedResumes();
      if (cachedResumes != null) {
        try {
          return cachedResumes.map((resume) => Resume.fromJson(resume)).toList();
        } catch (e) {
          // If cached data is corrupted, clear it and continue with API call
          await HiveCacheManager.clearCache('cached_resumes');
        }
      }
    }
    
    // Fetch from API
    debugPrint('🌐 Fetching resumes from API (refresh: $refresh)');
    final resumes = await _remoteDataSource.getResumes();
    
    // Cache the resumes data
    try {
      final resumesJson = resumes.map((resume) => resume.toJson()).toList();
      await HiveCacheManager.cacheResumes(resumesJson);
    } catch (e) {
      debugPrint('Failed to cache resumes: $e');
    }
    
    return resumes;
  }

  @override
  Future<Resume> uploadResume(File file) async {
    final resume = await _remoteDataSource.uploadResume(file);
    
    // Clear resumes cache since we added a new resume
    await HiveCacheManager.clearCache('cached_resumes');
    
    return resume;
  }

  @override
  Future<Resume> getResumeById(String resumeId) async {
    return await _remoteDataSource.getResumeById(resumeId);
  }

  @override
  Future<Resume> updateResume(String resumeId, Map<String, dynamic> data) async {
    final resume = await _remoteDataSource.updateResume(resumeId, data);
    
    // Clear resumes cache since we updated a resume
    await HiveCacheManager.clearCache('cached_resumes');
    
    return resume;
  }

  @override
  Future<void> deleteResume(String resumeId) async {
    await _remoteDataSource.deleteResume(resumeId);
    
    // Clear resumes cache since we deleted a resume
    await HiveCacheManager.clearCache('cached_resumes');
  }
}
