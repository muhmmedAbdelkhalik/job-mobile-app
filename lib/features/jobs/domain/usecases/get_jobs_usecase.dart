import '../../../../shared/models/api_response.dart';
import '../entities/job.dart';
import '../repositories/job_repository.dart';

class GetJobsUseCase {
  final JobRepository _repository;

  GetJobsUseCase(this._repository);

  Future<ApiResponse<List<Job>>> call({
    String? search,
    String? location,
    String? type,
    int page = 1,
    int perPage = 15,
    bool refresh = false,
  }) async {
    return await _repository.getJobs(
      search: search,
      location: location,
      type: type,
      page: page,
      perPage: perPage,
      refresh: refresh,
    );
  }
}
