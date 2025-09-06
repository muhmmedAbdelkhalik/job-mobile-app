import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/application_controller.dart';
import '../widgets/application_card.dart';
import 'application_details_page.dart';

class ApplicationsPage extends StatelessWidget {
  const ApplicationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final applicationController = Get.find<ApplicationController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Applications'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => applicationController.forceRefreshApplications(),
            tooltip: 'Refresh Applications',
          ),
        ],
      ),
      body: Obx(() {
        if (applicationController.isLoading && applicationController.applications.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (applicationController.applications.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.assignment_outlined,
                  size: 64,
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.3),
                ),
                const SizedBox(height: 16),
                Text(
                  'No Applications Found',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Apply for jobs to see your applications here',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () => Get.offAllNamed('/home'),
                  icon: const Icon(Icons.search),
                  label: const Text('Browse Jobs'),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () => applicationController.loadApplications(refresh: true),
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: applicationController.applications.length,
            itemBuilder: (context, index) {
              final application = applicationController.applications[index];
              return ApplicationCard(
                application: application,
                onTap: () {
                  Get.to(() => ApplicationDetailsPage(applicationId: application.id));
                },
              );
            },
          ),
        );
      }),
    );
  }
}
