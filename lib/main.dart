import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protfolio/bindings/app_binding.dart';
import 'package:protfolio/controllers/theme_controller.dart';
import 'views/portfolio_view.dart';

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
        home: PortfolioView(),
        defaultTransition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 300),
      );
    });
  }
}
