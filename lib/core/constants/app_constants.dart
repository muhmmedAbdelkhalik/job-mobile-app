class AppConstants {
  // API Configuration
  static const String baseUrl = 'https://job-app-main-2uhwu4.laravel.cloud/api/v1';
  static const String apiVersion = 'v1';
  
  // API Endpoints
  static const String authRegister = '/auth/register';
  static const String authLogin = '/auth/login';
  static const String authLogout = '/auth/logout';
  static const String profile = '/profile';
  static const String jobs = '/jobs';
  static const String applications = '/applications';
  static const String resumes = '/resumes';
  
  // Storage Keys
  static const String tokenKey = 'auth_token';
  static const String userKey = 'user_data';
  static const String themeKey = 'theme_mode';
  
  // Pagination
  static const int defaultPageSize = 15;
  static const int maxPageSize = 50;
  
  // File Upload
  static const int maxFileSize = 10 * 1024 * 1024; // 10MB
  static const List<String> allowedFileTypes = ['pdf', 'doc', 'docx'];
  
  // Rate Limiting
  static const int apiRateLimit = 60; // requests per minute
  static const int authRateLimit = 5; // requests per minute
}
