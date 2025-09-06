import '../entities/resume.dart';
import '../repositories/resume_repository.dart';

class GetResumesUseCase {
  final ResumeRepository _repository;

  GetResumesUseCase(this._repository);

  Future<List<Resume>> call({bool refresh = false}) async {
    return await _repository.getResumes(refresh: refresh);
  }
}
