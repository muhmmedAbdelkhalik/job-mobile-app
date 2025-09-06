import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../controllers/job_controller.dart';
import '../widgets/enhanced_search_bar.dart';
import '../widgets/job_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final jobController = Get.find<JobController>();

    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          if (authController.currentUser != null) {
            return Column(
              children: [
                // Welcome Header
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome, ${authController.currentUser!.name}!',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Find your dream job today',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                ),

                // Enhanced Search Bar
                const Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: EnhancedSearchBar()),

                const SizedBox(height: 16),

                // Jobs List
                Expanded(
                  child: jobController.isLoading && jobController.jobs.isEmpty
                      ? const Center(child: CircularProgressIndicator())
                      : jobController.jobs.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.search_off,
                                size: 64,
                                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.3),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'No jobs found',
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Try adjusting your search criteria',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                                ),
                              ),
                            ],
                          ),
                        )
                      : RefreshIndicator(
                          onRefresh: () => jobController.loadJobs(refresh: true),
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            itemCount: jobController.jobs.length + (jobController.hasMorePages ? 1 : 0),
                            itemBuilder: (context, index) {
                              if (index == jobController.jobs.length) {
                                // Load more indicator
                                if (jobController.isLoading) {
                                  return const Padding(
                                    padding: EdgeInsets.all(16),
                                    child: Center(child: CircularProgressIndicator()),
                                  );
                                } else {
                                  // Load more button
                                  return Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: ElevatedButton(
                                      onPressed: () => jobController.loadMoreJobs(),
                                      child: const Text('Load More'),
                                    ),
                                  );
                                }
                              }

                              final job = jobController.jobs[index];
                              return JobCard(
                                job: job,
                                onTap: () async {
                                  // Load job details and navigate
                                  await jobController.getJobById(job.id);
                                  Get.toNamed('/job-details', arguments: {'jobId': job.id});
                                },
                              );
                            },
                          ),
                        ),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }),
      ),
    );
  }
}
