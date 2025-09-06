class Application {
  final String id;
  final String status;
  final num aiScore;
  final String aiFeedback;
  final DateTime createdAt;
  final ApplicationJob job;
  final ApplicationResume resume;
  final String? jobTitle;
  final String? companyName;

  Application({
    required this.id,
    required this.status,
    required this.aiScore,
    required this.aiFeedback,
    required this.createdAt,
    required this.job,
    required this.resume,
    this.jobTitle,
    this.companyName,
  });

  factory Application.fromJson(Map<String, dynamic> json) {
    return Application(
      id: json['id'] ?? '',
      status: json['status'] ?? '',
      aiScore: json['ai_score'] ?? 0,
      aiFeedback: json['ai_feedback'] ?? '',
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      job: ApplicationJob.fromJson(json['job'] ?? {}),
      resume: ApplicationResume.fromJson(json['resume'] ?? {}),
      jobTitle: json['job_title'],
      companyName: json['company_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'ai_score': aiScore,
      'ai_feedback': aiFeedback,
      'created_at': createdAt.toIso8601String(),
      'job': job.toJson(),
      'resume': resume.toJson(),
      'job_title': jobTitle,
      'company_name': companyName,
    };
  }

  String get formattedDate {
    return '${createdAt.day}/${createdAt.month}/${createdAt.year}';
  }

  String get statusColor {
    switch (status.toLowerCase()) {
      case 'pending':
        return '#F59E0B'; // amber
      case 'accepted':
        return '#10B981'; // green
      case 'rejected':
        return '#EF4444'; // red
      default:
        return '#6B7280'; // gray
    }
  }

  String get displayJobTitle {
    return jobTitle ?? job.title;
  }

  String get displayCompanyName {
    return companyName ?? job.companyName;
  }
}

class ApplicationJob {
  final String id;
  final String title;
  final String location;
  final String companyName;

  ApplicationJob({
    required this.id,
    required this.title,
    required this.location,
    required this.companyName,
  });

  factory ApplicationJob.fromJson(Map<String, dynamic> json) {
    return ApplicationJob(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      location: json['location'] ?? '',
      companyName: json['company_name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'location': location,
      'company_name': companyName,
    };
  }
}

class ApplicationResume {
  final String id;
  final String fileName;

  ApplicationResume({
    required this.id,
    required this.fileName,
  });

  factory ApplicationResume.fromJson(Map<String, dynamic> json) {
    return ApplicationResume(
      id: json['id'] ?? '',
      fileName: json['file_name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'file_name': fileName,
    };
  }
}
