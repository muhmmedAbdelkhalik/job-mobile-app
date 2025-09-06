import '../../../../core/constants/app_constants.dart';
import '../../../../core/services/api_service.dart';
import '../../../../shared/models/api_response.dart';
import '../../domain/entities/job.dart';

class JobRemoteDataSource {
  final ApiService _apiService = ApiService();

  Future<ApiResponse<List<Job>>> getJobs({
    String? search,
    String? location,
    String? type,
    int page = 1,
    int perPage = 15,
  }) async {
    final queryParams = <String, dynamic>{
      'page': page,
      'per_page': perPage,
    };

    if (search != null && search.isNotEmpty) {
      queryParams['search'] = search;
    }
    if (location != null && location.isNotEmpty) {
      queryParams['location'] = location;
    }
    if (type != null && type.isNotEmpty) {
      queryParams['type'] = type;
    }

    final response = await _apiService.get(
      AppConstants.jobs,
      queryParameters: queryParams,
    );

    final apiResponse = ApiResponse.fromJson(
      response,
      (data) => (data as List).map((job) => Job.fromJson(job)).toList(),
    );

    return apiResponse;
  }

  Future<Job> getJobById(String jobId) async {
    final response = await _apiService.get('${AppConstants.jobs}/$jobId');
    final apiResponse = ApiResponse.fromJson(response, (data) => Job.fromJson(data));
    
    if (apiResponse.success && apiResponse.data != null) {
      return apiResponse.data!;
    } else {
      throw Exception(apiResponse.message);
    }
  }
}
