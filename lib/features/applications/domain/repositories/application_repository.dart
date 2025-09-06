import '../entities/application.dart';

abstract class ApplicationRepository {
  Future<List<Application>> getApplications({bool refresh = false});
  Future<Application> getApplicationById(String applicationId);
  Future<Application> applyForJob(String jobId, String resumeId);
}
