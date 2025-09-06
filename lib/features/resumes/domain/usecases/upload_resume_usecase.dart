import 'dart:io';
import '../entities/resume.dart';
import '../repositories/resume_repository.dart';

class UploadResumeUseCase {
  final ResumeRepository _repository;

  UploadResumeUseCase(this._repository);

  Future<Resume> call(File file) async {
    if (!file.existsSync()) {
      throw Exception('File does not exist');
    }

    final fileSize = await file.length();
    if (fileSize > 10 * 1024 * 1024) { // 10MB
      throw Exception('File size must be less than 10MB');
    }

    final fileName = file.path.split('/').last.toLowerCase();
    final allowedExtensions = ['pdf', 'doc', 'docx'];
    final fileExtension = fileName.split('.').last;

    if (!allowedExtensions.contains(fileExtension)) {
      throw Exception('Only PDF, DOC, and DOCX files are allowed');
    }

    return await _repository.uploadResume(file);
  }
}
