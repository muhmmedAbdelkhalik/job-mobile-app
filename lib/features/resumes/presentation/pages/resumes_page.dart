import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/resume_controller.dart';
import '../widgets/resume_card.dart';
import '../../../../core/services/snackbar_service.dart';

class ResumesPage extends StatelessWidget {
  const ResumesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final resumeController = Get.find<ResumeController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Resumes'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => resumeController.forceRefreshResumes(),
            tooltip: 'Refresh Resumes',
          ),
        ],
      ),
      body: Obx(() {
        if (resumeController.isLoading && resumeController.resumes.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (resumeController.resumes.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.description_outlined,
                  size: 64,
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
                ),
                const SizedBox(height: 16),
                Text(
                  'No Resumes Found',
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7)),
                ),
                const SizedBox(height: 8),
                Text(
                  'Upload your first resume to get started',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5)),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () => resumeController.pickAndUploadResume(),
                  icon: const Icon(Icons.upload),
                  label: const Text('Upload Resume'),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () => resumeController.loadResumes(refresh: true),
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: resumeController.resumes.length,
            itemBuilder: (context, index) {
              final resume = resumeController.resumes[index];
              return ResumeCard(resume: resume, onDelete: () => resumeController.deleteResume(resume.id));
            },
          ),
        );
      }),
      floatingActionButton: Obx(
        () => FloatingActionButton.extended(
          onPressed: resumeController.isLoading ? null : () => resumeController.pickAndUploadResume(),
          icon: resumeController.isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : const Icon(Icons.upload),
          label: Text(resumeController.isLoading ? 'Uploading...' : 'Upload Resume'),
          backgroundColor: const Color(0xFF3B82F6),
        ),
      ),
    );
  }
}
