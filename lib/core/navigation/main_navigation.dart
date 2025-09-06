import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../navigation/navigation_controller.dart';
import '../../features/jobs/presentation/pages/home_page.dart';
import '../../features/resumes/presentation/pages/resumes_page.dart';
import '../../features/applications/presentation/pages/applications_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';

class MainNavigation extends StatelessWidget {
  const MainNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationController = Get.find<NavigationController>();

    return Scaffold(
      body: Obx(() {
        switch (navigationController.currentIndex) {
          case 0:
            return const HomePage();
          case 1:
            return const ResumesPage();
          case 2:
            return const ApplicationsPage();
          case 3:
            return const ProfilePage();
          default:
            return const HomePage();
        }
      }),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: navigationController.currentIndex,
        onTap: navigationController.changeIndex,
        selectedItemColor: const Color(0xFF3B82F6),
        unselectedItemColor: Colors.grey,
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 8,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Jobs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.description_outlined),
            activeIcon: Icon(Icons.description),
            label: 'Resumes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_outlined),
            activeIcon: Icon(Icons.assignment),
            label: 'Applications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      )),
    );
  }
}
