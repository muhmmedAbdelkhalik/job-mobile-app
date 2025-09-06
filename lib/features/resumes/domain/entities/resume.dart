class Resume {
  final String id;
  final String fileName;
  final String fileUrl;
  final String fileFullUrl;
  final String summary;
  final String skills;
  final int applicationsCount;
  final DateTime createdAt;

  Resume({
    required this.id,
    required this.fileName,
    required this.fileUrl,
    required this.fileFullUrl,
    required this.summary,
    required this.skills,
    required this.applicationsCount,
    required this.createdAt,
  });

  factory Resume.fromJson(Map<String, dynamic> json) {
    return Resume(
      id: json['id'] ?? '',
      fileName: json['file_name'] ?? '',
      fileUrl: json['file_url'] ?? '',
      fileFullUrl: json['file_full_url'] ?? '',
      summary: json['summary'] ?? '',
      skills: json['skills'] ?? '',
      applicationsCount: json['applications_count'] ?? 0,
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'file_name': fileName,
      'file_url': fileUrl,
      'file_full_url': fileFullUrl,
      'summary': summary,
      'skills': skills,
      'applications_count': applicationsCount,
      'created_at': createdAt.toIso8601String(),
    };
  }

  String get fileExtension {
    return fileName.split('.').last.toLowerCase();
  }

  String get formattedDate {
    return '${createdAt.day}/${createdAt.month}/${createdAt.year}';
  }
}
