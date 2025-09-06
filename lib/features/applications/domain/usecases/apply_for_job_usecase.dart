import '../entities/application.dart';
import '../repositories/application_repository.dart';

class ApplyForJobUseCase {
  final ApplicationRepository _repository;

  ApplyForJobUseCase(this._repository);

  Future<Application> call(String jobId, String resumeId) async {
    if (jobId.isEmpty || resumeId.isEmpty) {
      throw Exception('Job ID and Resume ID are required');
    }
    return await _repository.applyForJob(jobId, resumeId);
  }
}
