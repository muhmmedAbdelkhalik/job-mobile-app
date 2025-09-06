import '../entities/job.dart';
import '../repositories/job_repository.dart';

class GetJobByIdUseCase {
  final JobRepository _repository;

  GetJobByIdUseCase(this._repository);

  Future<Job> call(String jobId) async {
    if (jobId.isEmpty) {
      throw Exception('Job ID is required');
    }
    return await _repository.getJobById(jobId);
  }
}
