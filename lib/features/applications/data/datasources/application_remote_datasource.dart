import '../../../../core/constants/app_constants.dart';
import '../../../../core/services/api_service.dart';
import '../../../../shared/models/api_response.dart';
import '../../domain/entities/application.dart';

class ApplicationRemoteDataSource {
  final ApiService _apiService = ApiService();

  Future<List<Application>> getApplications() async {
    final response = await _apiService.get(AppConstants.applications);
    final apiResponse = ApiResponse.fromJson(
      response,
      (data) => (data as List).map((application) => Application.fromJson(application)).toList(),
    );

    if (apiResponse.success && apiResponse.data != null) {
      return apiResponse.data!;
    } else {
      throw Exception(apiResponse.message);
    }
  }

  Future<Application> getApplicationById(String applicationId) async {
    final response = await _apiService.get('${AppConstants.applications}/$applicationId');
    final apiResponse = ApiResponse.fromJson(response, (data) => Application.fromJson(data));
    
    if (apiResponse.success && apiResponse.data != null) {
      return apiResponse.data!;
    } else {
      throw Exception(apiResponse.message);
    }
  }

  Future<Application> applyForJob(String jobId, String resumeId) async {
    final response = await _apiService.post(
      '${AppConstants.jobs}/$jobId/apply',
      data: {'resume_id': resumeId},
    );
    final apiResponse = ApiResponse.fromJson(response, (data) => Application.fromJson(data));
    
    if (apiResponse.success && apiResponse.data != null) {
      return apiResponse.data!;
    } else {
      throw Exception(apiResponse.message);
    }
  }
}
