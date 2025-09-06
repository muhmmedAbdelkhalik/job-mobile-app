import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/job_controller.dart';
import '../../../resumes/presentation/controllers/resume_controller.dart';
import '../../../applications/presentation/controllers/application_controller.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../widgets/company_info_card.dart';
import '../widgets/job_requirements_card.dart';
import '../widgets/apply_job_bottom_sheet.dart';
import '../../../../shared/widgets/cache_management_widget.dart';
import '../../../../core/services/snackbar_service.dart';

class JobDetailsPage extends StatelessWidget {
  final String jobId;

  const JobDetailsPage({super.key, required this.jobId});

  @override
  Widget build(BuildContext context) {
    final jobController = Get.find<JobController>();
    final resumeController = Get.find<ResumeController>();
    final applicationController = Get.find<ApplicationController>();
    final authController = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Details'),
        centerTitle: true,
        actions: [
          // Cache status indicator
          CacheStatusIndicator(cacheKey: 'cached_job_details_$jobId', label: 'Cache Status'),
          const SizedBox(width: 8),
          // Cache management menu
          PopupMenuButton<String>(
            onSelected: (value) async {
              switch (value) {
                case 'refresh':
                  await jobController.forceRefreshJobDetails(jobId);
                  break;
                case 'clear_cache':
                  await jobController.clearJobDetailsCache(jobId);
                  SnackbarService.showSuccess(title: 'Success', message: 'Job details cache cleared');
                  break;
                case 'cache_stats':
                  _showCacheStats(context, jobController);
                  break;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'refresh',
                child: Row(children: [Icon(Icons.refresh), SizedBox(width: 8), Text('Force Refresh')]),
              ),
              const PopupMenuItem(
                value: 'clear_cache',
                child: Row(children: [Icon(Icons.cached), SizedBox(width: 8), Text('Clear Job Cache')]),
              ),
              const PopupMenuItem(
                value: 'cache_stats',
                child: Row(children: [Icon(Icons.analytics), SizedBox(width: 8), Text('Cache Statistics')]),
              ),
            ],
          ),
        ],
      ),
      body: Obx(() {
        if (jobController.isLoading && jobController.selectedJob == null) {
          return const Center(child: CircularProgressIndicator());
        }

        if (jobController.selectedJob == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 64, color: Theme.of(context).colorScheme.error),
                const SizedBox(height: 16),
                Text('Job not found', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 8),
                Text(
                  'The job you are looking for does not exist or has been removed.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ElevatedButton(onPressed: () => Get.back(), child: const Text('Go Back')),
              ],
            ),
          );
        }

        final job = jobController.selectedJob!;
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Job Header Card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  job.title,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '${job.company.name} • ${job.location}',
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF3B82F6),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Text(
                                        job.formattedType,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF10B981),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Text(
                                        job.formattedSalary,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Icon(
                            Icons.category_outlined,
                            size: 16,
                            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            job.category.name,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                            ),
                          ),
                          const Spacer(),
                          if (job.viewCount != null) ...[
                            Icon(
                              Icons.visibility_outlined,
                              size: 16,
                              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${job.viewCount} views',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Job Description
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Job Description',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      Text(job.description, style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.6)),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Company Information
              CompanyInfoCard(company: job.company),

              const SizedBox(height: 16),

              // Job Requirements (placeholder for now)
              JobRequirementsCard(job: job),

              const SizedBox(height: 16),

              // Job Stats
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Job Information',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _buildInfoItem(context, 'Posted', _formatDate(job.createdAt), Icons.schedule),
                          ),
                          Expanded(
                            child: _buildInfoItem(
                              context,
                              'Applications',
                              '${job.applicationsCount ?? 0}',
                              Icons.people,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(child: _buildInfoItem(context, 'Location', job.location, Icons.location_on)),
                          Expanded(child: _buildInfoItem(context, 'Type', job.formattedType, Icons.work)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 100), // Space for floating button
            ],
          ),
        );
      }),
      floatingActionButton: Obx(() {
        if (jobController.selectedJob == null) return const SizedBox.shrink();

        return FloatingActionButton.extended(
          onPressed: () {
            if (authController.isLoggedIn) {
              // Load resumes first
              resumeController.loadResumes();
              // Show apply bottom sheet
              Get.bottomSheet(
                ApplyJobBottomSheet(
                  job: jobController.selectedJob!,
                  onApply: (resumeId) async {
                    try {
                      await applicationController.applyForJob(jobController.selectedJob!.id, resumeId);
                      Get.back(); // Close bottom sheet
                      SnackbarService.showSuccess(title: 'Success', message: 'Application submitted successfully!');
                    } catch (e) {
                      SnackbarService.showError(
                        title: 'Error',
                        message: 'Failed to submit application: ${e.toString()}',
                      );
                    }
                  },
                ),
                isScrollControlled: true,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
              );
            } else {
              SnackbarService.showWarning(title: 'Login Required', message: 'Please login to apply for jobs');
            }
          },
          icon: const Icon(Icons.send),
          label: const Text('Apply Now'),
          backgroundColor: const Color(0xFF3B82F6),
        );
      }),
    );
  }

  Widget _buildInfoItem(BuildContext context, String label, String value, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(value, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
      ],
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  void _showCacheStats(BuildContext context, JobController controller) {
    final stats = controller.getCacheStats();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cache Statistics'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Total Entries: ${stats['total_entries'] ?? 0}'),
            Text('Valid Entries: ${stats['valid_entries'] ?? 0}'),
            Text('Expired Entries: ${stats['expired_entries'] ?? 0}'),
            Text('Cache Size: ${stats['cache_size_bytes'] ?? 0} bytes'),
            const SizedBox(height: 16),
            Text('Jobs Cached: ${controller.hasCachedJobs() ? "Yes" : "No"}'),
            Text('This Job Cached: ${controller.hasCachedJobDetails(jobId) ? "Yes" : "No"}'),
          ],
        ),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close'))],
      ),
    );
  }
}
