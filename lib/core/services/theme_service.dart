import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../theme/app_theme.dart';

class ThemeService extends GetxController {
  static const String _themeKey = 'theme_mode';
  
  final GetStorage _storage = GetStorage();
  
  // Observable theme mode
  final Rx<ThemeMode> _themeMode = ThemeMode.system.obs;
  
  // Getters
  ThemeMode get themeMode => _themeMode.value;
  bool get isDarkMode => _themeMode.value == ThemeMode.dark;
  bool get isLightMode => _themeMode.value == ThemeMode.light;
  bool get isSystemMode => _themeMode.value == ThemeMode.system;
  
  @override
  void onInit() {
    super.onInit();
    _loadThemeMode();
  }
  
  /// Load theme mode from storage
  void _loadThemeMode() {
    final String? savedTheme = _storage.read(_themeKey);
    if (savedTheme != null) {
      switch (savedTheme) {
        case 'light':
          _themeMode.value = ThemeMode.light;
          break;
        case 'dark':
          _themeMode.value = ThemeMode.dark;
          break;
        case 'system':
        default:
          _themeMode.value = ThemeMode.system;
          break;
      }
    }
  }
  
  /// Save theme mode to storage
  void _saveThemeMode(ThemeMode mode) {
    String themeString;
    switch (mode) {
      case ThemeMode.light:
        themeString = 'light';
        break;
      case ThemeMode.dark:
        themeString = 'dark';
        break;
      case ThemeMode.system:
        themeString = 'system';
        break;
    }
    _storage.write(_themeKey, themeString);
  }
  
  /// Set theme mode
  void setThemeMode(ThemeMode mode) {
    _themeMode.value = mode;
    _saveThemeMode(mode);
    Get.changeThemeMode(mode);
  }
  
  /// Toggle between light and dark mode
  void toggleTheme() {
    if (isDarkMode) {
      setThemeMode(ThemeMode.light);
    } else {
      setThemeMode(ThemeMode.dark);
    }
  }
  
  /// Set light theme
  void setLightTheme() {
    setThemeMode(ThemeMode.light);
  }
  
  /// Set dark theme
  void setDarkTheme() {
    setThemeMode(ThemeMode.dark);
  }
  
  /// Set system theme
  void setSystemTheme() {
    setThemeMode(ThemeMode.system);
  }
  
  /// Get current theme data based on brightness
  ThemeData getCurrentTheme(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    final isDark = _themeMode.value == ThemeMode.dark || 
                   (_themeMode.value == ThemeMode.system && brightness == Brightness.dark);
    
    return isDark ? AppTheme.darkTheme : AppTheme.lightTheme;
  }
  
  /// Get theme mode string for display
  String getThemeModeString() {
    switch (_themeMode.value) {
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
      case ThemeMode.system:
        return 'System';
    }
  }
  
  /// Get theme mode icon
  IconData getThemeModeIcon() {
    switch (_themeMode.value) {
      case ThemeMode.light:
        return Icons.light_mode;
      case ThemeMode.dark:
        return Icons.dark_mode;
      case ThemeMode.system:
        return Icons.brightness_auto;
    }
  }
}
