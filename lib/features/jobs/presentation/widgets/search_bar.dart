import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/job_controller.dart';

class JobSearchBar extends StatefulWidget {
  const JobSearchBar({super.key});

  @override
  State<JobSearchBar> createState() => _JobSearchBarState();
}

class _JobSearchBarState extends State<JobSearchBar> {
  final TextEditingController _searchController = TextEditingController();
  final JobController _jobController = Get.find<JobController>();

  @override
  void initState() {
    super.initState();
    _searchController.text = _jobController.searchQuery;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search jobs...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      onPressed: () {
                        _searchController.clear();
                        _jobController.searchJobs('');
                      },
                      icon: const Icon(Icons.clear),
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Theme.of(context).colorScheme.background,
            ),
            onSubmitted: (value) {
              _jobController.searchJobs(value);
            },
            onChanged: (value) {
              setState(() {});
            },
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip('All Jobs', '', _jobController.selectedType),
                const SizedBox(width: 8),
                ..._jobController.jobTypes
                    .where((type) => type != 'all')
                    .map((type) => Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: _buildFilterChip(
                            type.replaceAll('-', ' ').toUpperCase(),
                            type,
                            _jobController.selectedType,
                          ),
                        )),
                if (_jobController.selectedType.isNotEmpty ||
                    _jobController.selectedLocation.isNotEmpty ||
                    _jobController.searchQuery.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: _buildFilterChip('Clear', 'clear', ''),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, String value, String selectedValue) {
    final isSelected = value == selectedValue;
    final isClear = value == 'clear';

    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        if (isClear) {
          _jobController.clearFilters();
        } else {
          _jobController.filterByType(value);
        }
      },
      selectedColor: const Color(0xFF3B82F6).withOpacity(0.2),
      checkmarkColor: const Color(0xFF3B82F6),
      backgroundColor: Theme.of(context).colorScheme.background,
      side: BorderSide(
        color: isSelected ? const Color(0xFF3B82F6) : Colors.grey.withOpacity(0.3),
      ),
    );
  }
}
