import 'dart:io';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/services/api_service.dart';
import '../../../../shared/models/api_response.dart';
import '../../domain/entities/resume.dart';

class ResumeRemoteDataSource {
  final ApiService _apiService = ApiService();

  Future<List<Resume>> getResumes() async {
    final response = await _apiService.get(AppConstants.resumes);
    final apiResponse = ApiResponse.fromJson(
      response,
      (data) => (data as List).map((resume) => Resume.fromJson(resume)).toList(),
    );

    if (apiResponse.success && apiResponse.data != null) {
      return apiResponse.data!;
    } else {
      throw Exception(apiResponse.message);
    }
  }

  Future<Resume> uploadResume(File file) async {
    final response = await _apiService.uploadFile(AppConstants.resumes, file);
    final apiResponse = ApiResponse.fromJson(response, (data) => Resume.fromJson(data));
    
    if (apiResponse.success && apiResponse.data != null) {
      return apiResponse.data!;
    } else {
      throw Exception(apiResponse.message);
    }
  }

  Future<Resume> getResumeById(String resumeId) async {
    final response = await _apiService.get('${AppConstants.resumes}/$resumeId');
    final apiResponse = ApiResponse.fromJson(response, (data) => Resume.fromJson(data));
    
    if (apiResponse.success && apiResponse.data != null) {
      return apiResponse.data!;
    } else {
      throw Exception(apiResponse.message);
    }
  }

  Future<Resume> updateResume(String resumeId, Map<String, dynamic> data) async {
    final response = await _apiService.put('${AppConstants.resumes}/$resumeId', data: data);
    final apiResponse = ApiResponse.fromJson(response, (data) => Resume.fromJson(data));
    
    if (apiResponse.success && apiResponse.data != null) {
      return apiResponse.data!;
    } else {
      throw Exception(apiResponse.message);
    }
  }

  Future<void> deleteResume(String resumeId) async {
    final response = await _apiService.delete('${AppConstants.resumes}/$resumeId');
    final apiResponse = ApiResponse.fromJson(response, (data) => data);
    
    if (!apiResponse.success) {
      throw Exception(apiResponse.message);
    }
  }
}
