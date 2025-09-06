import 'company.dart';
import 'category.dart';

class Job {
  final String id;
  final String title;
  final String description;
  final String location;
  final String salary;
  final String type;
  final int? viewCount;
  final int? applicationsCount;
  final Company company;
  final Category category;
  final DateTime createdAt;
  final DateTime updatedAt;

  Job({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.salary,
    required this.type,
    this.viewCount,
    this.applicationsCount,
    required this.company,
    required this.category,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      location: json['location'] ?? '',
      salary: json['salary'] ?? '0',
      type: json['type'] ?? '',
      viewCount: json['view_count'],
      applicationsCount: json['applications_count'],
      company: Company.fromJson(json['company'] ?? {}),
      category: Category.fromJson(json['category'] ?? {}),
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updated_at'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'location': location,
      'salary': salary,
      'type': type,
      'view_count': viewCount,
      'applications_count': applicationsCount,
      'company': company.toJson(),
      'category': category.toJson(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  String get formattedSalary {
    final salaryValue = double.tryParse(salary) ?? 0;
    return '\$${salaryValue.toStringAsFixed(0)} / Year';
  }

  String get formattedType {
    return type.replaceAll('-', ' ').split(' ').map((word) => 
      word.isNotEmpty ? word[0].toUpperCase() + word.substring(1) : ''
    ).join(' ');
  }
}
