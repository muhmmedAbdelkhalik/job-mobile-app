import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/services/theme_service.dart';

class ThemeToggleWidget extends StatelessWidget {
  final bool showLabel;
  final bool isCompact;
  
  const ThemeToggleWidget({
    super.key,
    this.showLabel = true,
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    final themeService = Get.find<ThemeService>();
    
    if (isCompact) {
      return Obx(() => IconButton(
        onPressed: () => themeService.toggleTheme(),
        icon: Icon(themeService.getThemeModeIcon()),
        tooltip: 'Toggle theme',
      ));
    }
    
    return Obx(() => PopupMenuButton<ThemeMode>(
      icon: Icon(themeService.getThemeModeIcon()),
      tooltip: 'Theme settings',
      onSelected: (ThemeMode mode) => themeService.setThemeMode(mode),
      itemBuilder: (BuildContext context) => [
        PopupMenuItem<ThemeMode>(
          value: ThemeMode.light,
          child: Row(
            children: [
              const Icon(Icons.light_mode),
              const SizedBox(width: 8),
              const Text('Light'),
              if (themeService.isLightMode) ...[
                const Spacer(),
                const Icon(Icons.check, color: Colors.blue),
              ],
            ],
          ),
        ),
        PopupMenuItem<ThemeMode>(
          value: ThemeMode.dark,
          child: Row(
            children: [
              const Icon(Icons.dark_mode),
              const SizedBox(width: 8),
              const Text('Dark'),
              if (themeService.isDarkMode) ...[
                const Spacer(),
                const Icon(Icons.check, color: Colors.blue),
              ],
            ],
          ),
        ),
        PopupMenuItem<ThemeMode>(
          value: ThemeMode.system,
          child: Row(
            children: [
              const Icon(Icons.brightness_auto),
              const SizedBox(width: 8),
              const Text('System'),
              if (themeService.isSystemMode) ...[
                const Spacer(),
                const Icon(Icons.check, color: Colors.blue),
              ],
            ],
          ),
        ),
      ],
    ));
  }
}

class ThemeToggleButton extends StatelessWidget {
  final bool showLabel;
  
  const ThemeToggleButton({
    super.key,
    this.showLabel = true,
  });

  @override
  Widget build(BuildContext context) {
    final themeService = Get.find<ThemeService>();
    
    return Obx(() => ElevatedButton.icon(
      onPressed: () => themeService.toggleTheme(),
      icon: Icon(themeService.getThemeModeIcon()),
      label: showLabel ? Text(themeService.getThemeModeString()) : const SizedBox.shrink(),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    ));
  }
}

class ThemeToggleSwitch extends StatelessWidget {
  const ThemeToggleSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final themeService = Get.find<ThemeService>();
    
    return Obx(() => Switch(
      value: themeService.isDarkMode,
      onChanged: (bool value) {
        if (value) {
          themeService.setDarkTheme();
        } else {
          themeService.setLightTheme();
        }
      },
    ));
  }
}
