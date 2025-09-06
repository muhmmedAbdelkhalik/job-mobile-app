import '../entities/job.dart';
import '../../../../shared/models/api_response.dart';

abstract class JobRepository {
  Future<ApiResponse<List<Job>>> getJobs({
    String? search,
    String? location,
    String? type,
    int page = 1,
    int perPage = 15,
    bool refresh = false,
  });
  
  Future<Job> getJobById(String jobId);
}
