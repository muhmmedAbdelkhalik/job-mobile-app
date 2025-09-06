import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'core/theme/app_theme.dart';
import 'core/services/api_service.dart';
import 'core/services/theme_service.dart';
import 'core/cache/hive_cache_manager.dart';
import 'core/bindings/auth_binding.dart';
import 'core/bindings/home_binding.dart';
import 'core/controllers/splash_controller.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/auth/presentation/pages/register_page.dart';
import 'features/jobs/presentation/pages/job_details_page.dart';
import 'core/navigation/main_navigation.dart';
 
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize GetStorage
  await GetStorage.init();
  
  // Initialize Hive Cache
  await HiveCacheManager.init();
  
  // Initialize API Service
  ApiService().initialize();
  
  // Initialize only essential services
  _initializeEssentialServices();
  
  runApp(const MyApp());
}

void _initializeEssentialServices() {
  // Only initialize services that are needed globally
  Get.put(ThemeService());
  
  // Configure global snackbar settings
  _configureSnackbar();
}

void _configureSnackbar() {
  // Global snackbar configuration is handled by SnackbarService
  // No need to override Get.snackbar globally
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeService = Get.find<ThemeService>();
    
    return Obx(() => GetMaterialApp(
      title: 'Job App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeService.themeMode,
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => const SplashPage(),
          binding: BindingsBuilder(() {
            Get.put(SplashController());
          }),
        ),
        GetPage(
          name: '/login',
          page: () => const LoginPage(),
          binding: AuthBinding(),
        ),
        GetPage(
          name: '/register',
          page: () => const RegisterPage(),
          binding: AuthBinding(),
        ),
        GetPage(
          name: '/home',
          page: () => const MainNavigation(),
          binding: HomeBinding(),
        ),
        GetPage(
          name: '/job-details',
          page: () => JobDetailsPage(jobId: Get.arguments['jobId']),
          binding: HomeBinding(),
        ),
      ],
    ));
  }
}

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF3B82F6), Color(0xFF9333EA)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Icon(
                  Icons.work,
                  color: Color(0xFF3B82F6),
                  size: 60,
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'Job App',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Find your dream job',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 48),
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}