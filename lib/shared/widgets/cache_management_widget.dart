import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/cache/hive_cache_manager.dart';
import '../../core/services/snackbar_service.dart';

/// Widget for managing cache in the app
/// Can be used in settings or debug screens
class CacheManagementWidget extends StatelessWidget {
  const CacheManagementWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Cache Management',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildCacheStats(),
            const SizedBox(height: 16),
            _buildCacheActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildCacheStats() {
    return FutureBuilder<Map<String, dynamic>>(
      future: Future.value(HiveCacheManager.getCacheStats()),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final stats = snapshot.data!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Total Entries: ${stats['total_entries'] ?? 0}'),
              Text('Valid Entries: ${stats['valid_entries'] ?? 0}'),
              Text('Expired Entries: ${stats['expired_entries'] ?? 0}'),
              Text('Cache Size: ${stats['cache_size_bytes'] ?? 0} bytes'),
            ],
          );
        }
        return const Text('Loading cache stats...');
      },
    );
  }

  Widget _buildCacheActions() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () async {
              await HiveCacheManager.clearExpiredCache();
              SnackbarService.showSuccess(title: 'Success', message: 'Expired cache cleared');
            },
            icon: const Icon(Icons.cleaning_services),
            label: const Text('Clear Expired Cache'),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () async {
              await HiveCacheManager.clearAllCache();
              SnackbarService.showSuccess(title: 'Success', message: 'All cache cleared');
            },
            icon: const Icon(Icons.delete_forever),
            label: const Text('Clear All Cache'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

/// Simple cache status indicator
class CacheStatusIndicator extends StatelessWidget {
  final String cacheKey;
  final String label;

  const CacheStatusIndicator({
    super.key,
    required this.cacheKey,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final hasCache = HiveCacheManager.hasValidCache(cacheKey);
    
    return Row(
      children: [
        Icon(
          hasCache ? Icons.cached : Icons.cached_outlined,
          color: hasCache ? Colors.green : Colors.grey,
          size: 16,
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            color: hasCache ? Colors.green : Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
