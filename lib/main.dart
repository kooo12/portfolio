import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protfolio/bindings/app_binding.dart';
import 'package:protfolio/controllers/theme_controller.dart';
import 'views/portfolio_view.dart';
import 'views/project_details_route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var themeController = Get.put(ThemeController());

      return GetMaterialApp(
        title: 'Portfolio',
        binds: AppBinding().dependencies(),
        debugShowCheckedModeBanner: false,
        themeMode:
            themeController.isDarkMode ? ThemeMode.dark : ThemeMode.light,
        darkTheme: themeController.darkTheme,
        theme: themeController.activeTheme,
        initialRoute: '/',
        getPages: [
          GetPage(name: '/', page: () => PortfolioView()),
          GetPage(
              name: '/project/:id', page: () => const ProjectDetailsRoute()),
        ],
        unknownRoute: GetPage(name: '/404', page: () => PortfolioView()),
        defaultTransition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 300),
      );
    });
  }
}
