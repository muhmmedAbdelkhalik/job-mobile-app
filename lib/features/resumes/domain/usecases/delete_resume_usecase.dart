import '../repositories/resume_repository.dart';

class DeleteResumeUseCase {
  final ResumeRepository _repository;

  DeleteResumeUseCase(this._repository);

  Future<void> call(String resumeId) async {
    if (resumeId.isEmpty) {
      throw Exception('Resume ID cannot be empty');
    }

    return await _repository.deleteResume(resumeId);
  }
}
