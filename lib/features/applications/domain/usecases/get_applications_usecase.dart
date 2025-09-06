import '../entities/application.dart';
import '../repositories/application_repository.dart';

class GetApplicationsUseCase {
  final ApplicationRepository _repository;

  GetApplicationsUseCase(this._repository);

  Future<List<Application>> call({bool refresh = false}) async {
    return await _repository.getApplications(refresh: refresh);
  }
}
