import 'package:get/get.dart';
import '../../features/auth/data/datasources/auth_remote_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/domain/usecases/register_usecase.dart';
import '../../features/auth/presentation/controllers/auth_controller.dart';
import '../../features/jobs/data/datasources/job_remote_datasource.dart';
import '../../features/jobs/data/repositories/job_repository_impl.dart';
import '../../features/jobs/domain/usecases/get_jobs_usecase.dart';
import '../../features/jobs/domain/usecases/get_job_by_id_usecase.dart';
import '../../features/jobs/presentation/controllers/job_controller.dart';
import '../../features/resumes/data/datasources/resume_remote_datasource.dart';
import '../../features/resumes/data/repositories/resume_repository_impl.dart';
import '../../features/resumes/domain/usecases/get_resumes_usecase.dart';
import '../../features/resumes/domain/usecases/upload_resume_usecase.dart';
import '../../features/resumes/domain/usecases/delete_resume_usecase.dart';
import '../../features/resumes/presentation/controllers/resume_controller.dart';
import '../../features/applications/data/datasources/application_remote_datasource.dart';
import '../../features/applications/data/repositories/application_repository_impl.dart';
import '../../features/applications/domain/usecases/get_applications_usecase.dart';
import '../../features/applications/domain/usecases/apply_for_job_usecase.dart';
import '../../features/applications/presentation/controllers/application_controller.dart';
import '../../features/profile/presentation/controllers/profile_controller.dart';
import '../navigation/navigation_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // Data sources
    final authRemoteDataSource = AuthRemoteDataSource();
    final jobRemoteDataSource = JobRemoteDataSource();
    final resumeRemoteDataSource = ResumeRemoteDataSource();
    final applicationRemoteDataSource = ApplicationRemoteDataSource();
    
    // Repositories
    final authRepository = AuthRepositoryImpl(authRemoteDataSource);
    final jobRepository = JobRepositoryImpl(jobRemoteDataSource);
    final resumeRepository = ResumeRepositoryImpl(resumeRemoteDataSource);
    final applicationRepository = ApplicationRepositoryImpl(applicationRemoteDataSource);
    
    // Use cases
    final loginUseCase = LoginUseCase(authRepository);
    final registerUseCase = RegisterUseCase(authRepository);
    final getJobsUseCase = GetJobsUseCase(jobRepository);
    final getJobByIdUseCase = GetJobByIdUseCase(jobRepository);
    final getResumesUseCase = GetResumesUseCase(resumeRepository);
    final uploadResumeUseCase = UploadResumeUseCase(resumeRepository);
    final deleteResumeUseCase = DeleteResumeUseCase(resumeRepository);
    final getApplicationsUseCase = GetApplicationsUseCase(applicationRepository);
    final applyForJobUseCase = ApplyForJobUseCase(applicationRepository);
    
    // Controllers - using lazyPut for better memory management
    // AuthController needs to be available globally since it's used by ProfileController
    // Check if AuthController already exists (from AuthBinding), if not create it
    if (!Get.isRegistered<AuthController>()) {
      Get.lazyPut<AuthController>(() => AuthController(
        loginUseCase: loginUseCase,
        registerUseCase: registerUseCase,
        authRepository: authRepository,
      ));
    }
    
    // Use Get.put for controllers that are accessed immediately in tab navigation
    Get.put<JobController>(JobController(
      getJobsUseCase: getJobsUseCase,
      getJobByIdUseCase: getJobByIdUseCase,
    ));
    
    Get.put<ResumeController>(ResumeController(
      getResumesUseCase: getResumesUseCase,
      uploadResumeUseCase: uploadResumeUseCase,
      deleteResumeUseCase: deleteResumeUseCase,
    ));
    
    Get.put<ApplicationController>(ApplicationController(
      getApplicationsUseCase: getApplicationsUseCase,
      applyForJobUseCase: applyForJobUseCase,
    ));
    
    Get.put<ProfileController>(ProfileController());
    Get.put<NavigationController>(NavigationController());
  }
}
