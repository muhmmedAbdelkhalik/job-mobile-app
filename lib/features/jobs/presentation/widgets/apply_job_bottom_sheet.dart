import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/entities/job.dart';
import '../../../resumes/presentation/controllers/resume_controller.dart';
import '../../../resumes/domain/entities/resume.dart';
import '../../../applications/presentation/controllers/application_controller.dart';
import '../../../../core/navigation/navigation_controller.dart';

class ApplyJobBottomSheet extends StatefulWidget {
  final Job job;
  final Function(String resumeId) onApply;

  const ApplyJobBottomSheet({
    super.key,
    required this.job,
    required this.onApply,
  });

  @override
  State<ApplyJobBottomSheet> createState() => _ApplyJobBottomSheetState();
}

class _ApplyJobBottomSheetState extends State<ApplyJobBottomSheet> {
  Resume? _selectedResume;

  @override
  Widget build(BuildContext context) {
    final resumeController = Get.find<ResumeController>();
    final applicationController = Get.find<ApplicationController>();

    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle bar
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Header
          Row(
            children: [
              Icon(
                Icons.send,
                color: Theme.of(context).colorScheme.primary,
                size: 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Apply for Job',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.job.title,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Resume Selection
          Text(
            'Select Resume',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          
          const SizedBox(height: 12),
          
          Obx(() {
            if (resumeController.isLoading) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: CircularProgressIndicator(),
                ),
              );
            }
            
            if (resumeController.resumes.isEmpty) {
              return Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.description_outlined,
                      size: 48,
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'No Resumes Found',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Please upload a resume first to apply for jobs.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () {
                        Get.back(); // Close this bottom sheet
                        // Navigate to resumes tab
                        final navigationController = Get.find<NavigationController>();
                        navigationController.changeIndex(1);
                      },
                      icon: const Icon(Icons.upload),
                      label: const Text('Upload Resume'),
                    ),
                  ],
                ),
              );
            }
            
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: resumeController.resumes.length,
              itemBuilder: (context, index) {
                final resume = resumeController.resumes[index];
                return _buildResumeItem(context, resume);
              },
            );
          }),
          
          const SizedBox(height: 20),
          
          // Apply Button
          SizedBox(
            width: double.infinity,
            child: Obx(() => ElevatedButton(
              onPressed: (_selectedResume != null && !applicationController.isLoading) ? () {
                widget.onApply(_selectedResume!.id);
              } : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: applicationController.isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Text(
                      _selectedResume != null 
                          ? 'Apply with ${_selectedResume!.fileName}'
                          : 'Select a resume to apply',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            )),
          ),
          
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildResumeItem(BuildContext context, Resume resume) {
    final isSelected = _selectedResume?.id == resume.id;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: isSelected 
            ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
            : Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: () {
            setState(() {
              _selectedResume = resume;
            });
          },
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: isSelected 
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    _getFileIcon(resume.fileExtension),
                    color: isSelected 
                        ? Colors.white
                        : Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        resume.fileName,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Uploaded ${resume.formattedDate}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                        ),
                      ),
                      if (resume.applicationsCount > 0) ...[
                        const SizedBox(height: 4),
                        Text(
                          '${resume.applicationsCount} applications',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (isSelected) ...[
                  Icon(
                    Icons.check_circle,
                    color: Theme.of(context).colorScheme.primary,
                    size: 24,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconData _getFileIcon(String extension) {
    switch (extension.toLowerCase()) {
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'doc':
      case 'docx':
        return Icons.description;
      default:
        return Icons.insert_drive_file;
    }
  }
}
