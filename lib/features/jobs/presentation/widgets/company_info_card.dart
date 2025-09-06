import 'package:flutter/material.dart';
import '../../domain/entities/company.dart';

class CompanyInfoCard extends StatelessWidget {
  final Company company;

  const CompanyInfoCard({super.key, required this.company});

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
                Icon(Icons.business, color: Theme.of(context).colorScheme.primary, size: 24),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'About ${company.name}',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (company.description != null && company.description!.isNotEmpty) ...[
              Text(company.description!, style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.6)),
              const SizedBox(height: 16),
            ],
            Row(
              children: [
                Expanded(
                  child: _buildInfoItem(context, 'Industry', company.industry ?? 'Not specified', Icons.category),
                ),
                Expanded(child: _buildInfoItem(context, 'Size', company.size ?? 'Not specified', Icons.people)),
              ],
            ),
            if (company.website != null && company.website!.isNotEmpty) ...[
              const SizedBox(height: 12),
              _buildInfoItem(context, 'Website', company.website!, Icons.language, isClickable: true),
            ],
            if (company.location != null && company.location!.isNotEmpty) ...[
              const SizedBox(height: 12),
              _buildInfoItem(context, 'Location', company.location!, Icons.location_on),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(BuildContext context, String label, String value, IconData icon, {bool isClickable = false}) {
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
      ],
    );
  }
}
