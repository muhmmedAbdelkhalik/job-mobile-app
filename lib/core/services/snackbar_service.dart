import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme/app_theme.dart';

class SnackbarService {
  static const Duration _defaultDuration = Duration(seconds: 3);
  static const SnackPosition _defaultPosition = SnackPosition.BOTTOM;
  static const double _defaultMargin = 16.0;
  static const double _defaultBorderRadius = 8.0;

  /// Show success snackbar
  static void showSuccess({
    required String title,
    required String message,
    Duration? duration,
    SnackPosition? position,
    double? margin,
  }) {
    Get.snackbar(
      title,
      message,
      duration: duration ?? _defaultDuration,
      snackPosition: position ?? _defaultPosition,
      margin: EdgeInsets.all(margin ?? _defaultMargin),
      borderRadius: _defaultBorderRadius,
      backgroundColor: AppTheme.success.withOpacity(0.9),
      colorText: Colors.white,
      icon: const Icon(
        Icons.check_circle,
        color: Colors.white,
        size: 20,
      ),
      shouldIconPulse: false,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
      reverseAnimationCurve: Curves.easeInBack,
      animationDuration: const Duration(milliseconds: 300),
    );
  }

  /// Show error snackbar
  static void showError({
    required String title,
    required String message,
    Duration? duration,
    SnackPosition? position,
    double? margin,
  }) {
    Get.snackbar(
      title,
      message,
      duration: duration ?? _defaultDuration,
      snackPosition: position ?? _defaultPosition,
      margin: EdgeInsets.all(margin ?? _defaultMargin),
      borderRadius: _defaultBorderRadius,
      backgroundColor: AppTheme.error.withOpacity(0.9),
      colorText: Colors.white,
      icon: const Icon(
        Icons.error,
        color: Colors.white,
        size: 20,
      ),
      shouldIconPulse: false,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
      reverseAnimationCurve: Curves.easeInBack,
      animationDuration: const Duration(milliseconds: 300),
    );
  }

  /// Show warning snackbar
  static void showWarning({
    required String title,
    required String message,
    Duration? duration,
    SnackPosition? position,
    double? margin,
  }) {
    Get.snackbar(
      title,
      message,
      duration: duration ?? _defaultDuration,
      snackPosition: position ?? _defaultPosition,
      margin: EdgeInsets.all(margin ?? _defaultMargin),
      borderRadius: _defaultBorderRadius,
      backgroundColor: AppTheme.warning.withOpacity(0.9),
      colorText: Colors.white,
      icon: const Icon(
        Icons.warning,
        color: Colors.white,
        size: 20,
      ),
      shouldIconPulse: false,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
      reverseAnimationCurve: Curves.easeInBack,
      animationDuration: const Duration(milliseconds: 300),
    );
  }

  /// Show info snackbar
  static void showInfo({
    required String title,
    required String message,
    Duration? duration,
    SnackPosition? position,
    double? margin,
  }) {
    Get.snackbar(
      title,
      message,
      duration: duration ?? _defaultDuration,
      snackPosition: position ?? _defaultPosition,
      margin: EdgeInsets.all(margin ?? _defaultMargin),
      borderRadius: _defaultBorderRadius,
      backgroundColor: AppTheme.info.withOpacity(0.9),
      colorText: Colors.white,
      icon: const Icon(
        Icons.info,
        color: Colors.white,
        size: 20,
      ),
      shouldIconPulse: false,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
      reverseAnimationCurve: Curves.easeInBack,
      animationDuration: const Duration(milliseconds: 300),
    );
  }

  /// Show custom snackbar with theme-aware colors
  static void showCustom({
    required String title,
    required String message,
    Color? backgroundColor,
    Color? textColor,
    IconData? icon,
    Duration? duration,
    SnackPosition? position,
    double? margin,
    bool? isDismissible,
  }) {
    final context = Get.context;
    if (context == null) return;

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final defaultBgColor = isDark ? AppTheme.cardDark : AppTheme.cardLight;
    final defaultTextColor = isDark ? AppTheme.textPrimaryDark : AppTheme.textPrimaryLight;

    Get.snackbar(
      title,
      message,
      duration: duration ?? _defaultDuration,
      snackPosition: position ?? _defaultPosition,
      margin: EdgeInsets.all(margin ?? _defaultMargin),
      borderRadius: _defaultBorderRadius,
      backgroundColor: backgroundColor ?? defaultBgColor.withOpacity(0.95),
      colorText: textColor ?? defaultTextColor,
      icon: icon != null
          ? Icon(
              icon,
              color: textColor ?? defaultTextColor,
              size: 20,
            )
          : null,
      shouldIconPulse: false,
      isDismissible: isDismissible ?? true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
      reverseAnimationCurve: Curves.easeInBack,
      animationDuration: const Duration(milliseconds: 300),
    );
  }

  /// Show loading snackbar (for long operations)
  static void showLoading({
    required String title,
    required String message,
    Duration? duration,
    SnackPosition? position,
    double? margin,
  }) {
    Get.snackbar(
      title,
      message,
      duration: duration ?? const Duration(seconds: 5),
      snackPosition: position ?? _defaultPosition,
      margin: EdgeInsets.all(margin ?? _defaultMargin),
      borderRadius: _defaultBorderRadius,
      backgroundColor: AppTheme.primaryBlue.withOpacity(0.9),
      colorText: Colors.white,
      icon: const Icon(
        Icons.hourglass_empty,
        color: Colors.white,
        size: 20,
      ),
      shouldIconPulse: true,
      isDismissible: false,
      forwardAnimationCurve: Curves.easeOutBack,
      reverseAnimationCurve: Curves.easeInBack,
      animationDuration: const Duration(milliseconds: 300),
    );
  }

  /// Close all snackbars
  static void closeAll() {
    Get.closeAllSnackbars();
  }
}