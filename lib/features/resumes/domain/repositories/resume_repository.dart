import 'dart:io';
import '../entities/resume.dart';

abstract class ResumeRepository {
  Future<List<Resume>> getResumes({bool refresh = false});
  Future<Resume> uploadResume(File file);
  Future<Resume> getResumeById(String resumeId);
  Future<Resume> updateResume(String resumeId, Map<String, dynamic> data);
  Future<void> deleteResume(String resumeId);
}
