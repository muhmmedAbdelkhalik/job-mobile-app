import 'package:flutter/material.dart';
import '../../domain/entities/job.dart';

class JobRequirementsCard extends StatelessWidget {
  final Job job;

  const JobRequirementsCard({
    super.key,
    required this.job,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.checklist,
                  color: Theme.of(context).colorScheme.primary,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  'Job Requirements',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Job Type
            _buildRequirementItem(
              context,
              'Job Type',
              job.formattedType,
              Icons.work,
            ),
            
            const SizedBox(height: 12),
            
            // Location
            _buildRequirementItem(
              context,
              'Location',
              job.location,
              Icons.location_on,
            ),
            
            const SizedBox(height: 12),
            
            // Salary
            _buildRequirementItem(
              context,
              'Salary',
              job.formattedSalary,
              Icons.attach_money,
            ),
            
            const SizedBox(height: 12),
            
            // Category
            _buildRequirementItem(
              context,
              'Category',
              job.category.name,
              Icons.category,
            ),
            
            const SizedBox(height: 16),
            
            // Additional Requirements (placeholder)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Additional Requirements',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '• Minimum 2 years of experience in ${job.category.name}\n'
                    '• Strong communication skills\n'
                    '• Ability to work in a team environment\n'
                    '• Problem-solving and analytical skills',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRequirementItem(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
