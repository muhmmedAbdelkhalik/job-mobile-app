import 'package:hive_flutter/hive_flutter.dart';
import 'dart:convert';

/// Hive-based cache manager for the job mobile app
/// Provides efficient caching with expiration support
class HiveCacheManager {
  static late Box _cacheBox;
  static bool _initialized = false;

  // Cache duration constants
  static const Duration _defaultCacheDuration = Duration(minutes: 15);
  static const Duration _jobsCacheDuration = Duration(minutes: 30);
  static const Duration _userCacheDuration = Duration(hours: 1);
  static const Duration _resumesCacheDuration = Duration(minutes: 45);
  static const Duration _applicationsCacheDuration = Duration(minutes: 20);

  // Cache keys
  static const String _jobsKey = 'cached_jobs';
  static const String _jobDetailsKey = 'cached_job_details';
  static const String _userKey = 'cached_user';
  static const String _resumesKey = 'cached_resumes';
  static const String _applicationsKey = 'cached_applications';

  /// Initialize the cache manager
  static Future<void> init() async {
    if (_initialized) return;
    
    await Hive.initFlutter();
    _cacheBox = await Hive.openBox('app_cache');
    _initialized = true;
  }

  /// Generic method to set cache with expiration
  static Future<void> setCache(
    String key, 
    dynamic data, {
    Duration? duration,
  }) async {
    if (!_initialized) await init();
    
    final cacheData = {
      'data': data,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'expiry': duration?.inMilliseconds ?? _defaultCacheDuration.inMilliseconds,
    };
    
    await _cacheBox.put(key, jsonEncode(cacheData));
  }

  /// Generic method to get cache with expiration check
  static T? getCache<T>(String key) {
    if (!_initialized) return null;
    
    final cached = _cacheBox.get(key);
    if (cached == null) return null;
    
    try {
      final cacheData = jsonDecode(cached);
      final timestamp = cacheData['timestamp'] as int;
      final expiry = cacheData['expiry'] as int;
      
      // Check if cache has expired
      if (DateTime.now().millisecondsSinceEpoch - timestamp > expiry) {
        _cacheBox.delete(key);
        return null;
      }
      
      return cacheData['data'] as T?;
    } catch (e) {
      // If parsing fails, remove the corrupted cache
      _cacheBox.delete(key);
      return null;
    }
  }

  /// Check if cache exists and is valid
  static bool hasValidCache(String key) {
    if (!_initialized) return false;
    
    final cached = _cacheBox.get(key);
    if (cached == null) return false;
    
    try {
      final cacheData = jsonDecode(cached);
      final timestamp = cacheData['timestamp'] as int;
      final expiry = cacheData['expiry'] as int;
      
      return DateTime.now().millisecondsSinceEpoch - timestamp <= expiry;
    } catch (e) {
      _cacheBox.delete(key);
      return false;
    }
  }

  // ========== SPECIFIC CACHE METHODS ==========

  /// Cache jobs data
  static Future<void> cacheJobs(List<dynamic> jobs, {String? search, String? location, String? type, int page = 1}) async {
    final key = getJobsCacheKey(search: search, location: location, type: type, page: page);
    await setCache(key, jobs, duration: _jobsCacheDuration);
  }

  /// Get cached jobs data
  static List<dynamic>? getCachedJobs({String? search, String? location, String? type, int page = 1}) {
    final key = getJobsCacheKey(search: search, location: location, type: type, page: page);
    return getCache<List<dynamic>>(key);
  }

  /// Cache individual job details
  static Future<void> cacheJobDetails(String jobId, Map<String, dynamic> jobDetails) async {
    final key = '${_jobDetailsKey}_$jobId';
    await setCache(key, jobDetails, duration: _jobsCacheDuration);
  }

  /// Get cached job details
  static Map<String, dynamic>? getCachedJobDetails(String jobId) {
    final key = '${_jobDetailsKey}_$jobId';
    return getCache<Map<String, dynamic>>(key);
  }

  /// Cache user data
  static Future<void> cacheUser(Map<String, dynamic> user) async {
    await setCache(_userKey, user, duration: _userCacheDuration);
  }

  /// Get cached user data
  static Map<String, dynamic>? getCachedUser() {
    return getCache<Map<String, dynamic>>(_userKey);
  }

  /// Cache resumes data
  static Future<void> cacheResumes(List<dynamic> resumes) async {
    await setCache(_resumesKey, resumes, duration: _resumesCacheDuration);
  }

  /// Get cached resumes data
  static List<dynamic>? getCachedResumes() {
    return getCache<List<dynamic>>(_resumesKey);
  }

  /// Cache applications data
  static Future<void> cacheApplications(List<dynamic> applications) async {
    await setCache(_applicationsKey, applications, duration: _applicationsCacheDuration);
  }

  /// Get cached applications data
  static List<dynamic>? getCachedApplications() {
    return getCache<List<dynamic>>(_applicationsKey);
  }

  // ========== CACHE MANAGEMENT ==========

  /// Clear specific cache by key
  static Future<void> clearCache(String key) async {
    if (!_initialized) return;
    await _cacheBox.delete(key);
  }

  /// Clear all cache
  static Future<void> clearAllCache() async {
    if (!_initialized) return;
    await _cacheBox.clear();
  }

  /// Clear expired cache entries
  static Future<void> clearExpiredCache() async {
    if (!_initialized) return;
    
    final keys = _cacheBox.keys.toList();
    for (final key in keys) {
      if (!hasValidCache(key)) {
        await _cacheBox.delete(key);
      }
    }
  }

  /// Get cache statistics
  static Map<String, dynamic> getCacheStats() {
    if (!_initialized) return {};
    
    final keys = _cacheBox.keys.toList();
    int validEntries = 0;
    int expiredEntries = 0;
    
    for (final key in keys) {
      if (hasValidCache(key)) {
        validEntries++;
      } else {
        expiredEntries++;
      }
    }
    
    return {
      'total_entries': keys.length,
      'valid_entries': validEntries,
      'expired_entries': expiredEntries,
      'cache_size_bytes': _cacheBox.length,
    };
  }

  // ========== PRIVATE HELPER METHODS ==========

  /// Generate cache key for jobs based on filters
  static String getJobsCacheKey({
    String? search,
    String? location,
    String? type,
    int page = 1,
  }) {
    final searchKey = search?.toLowerCase().trim() ?? '';
    final locationKey = location?.toLowerCase().trim() ?? '';
    final typeKey = type?.toLowerCase().trim() ?? '';
    
    return '${_jobsKey}_${searchKey}_${locationKey}_${typeKey}_$page';
  }

  /// Close the cache box (call this when app is disposed)
  static Future<void> dispose() async {
    if (_initialized) {
      await _cacheBox.close();
      _initialized = false;
    }
  }
}
