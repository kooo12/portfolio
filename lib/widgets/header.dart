import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../controllers/navigation_controller.dart';
import '../controllers/theme_controller.dart';
import '../utils/app_colors.dart';
import '../utils/app_dimensions.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  final NavigationController navigationController;
  final ThemeController themeController;

  const Header({
    super.key,
    required this.navigationController,
    required this.themeController,
  });

  @override
  Widget build(BuildContext context) {
    final themeCtrl = Get.find<ThemeController>();
    return Obx(
      () => Container(
        height: AppDimensions.headerHeight,
        decoration: BoxDecoration(
          color: themeCtrl.activeTheme.scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Container(
          constraints:
              const BoxConstraints(maxWidth: AppDimensions.containerMaxWidth),
          margin: const EdgeInsets.symmetric(
              horizontal: AppDimensions.containerPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Logo
              Text(
                'Portfolio',
                style: themeCtrl.activeTheme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryLight,
                ),
              ),

              // Desktop Navigation
              if (MediaQuery.of(context).size.width >
                  AppDimensions.mobileBreakpoint)
                Row(
                  children: [
                    _buildNavItem('Home', 0, context, themeCtrl),
                    _buildNavItem('About', 1, context, themeCtrl),
                    _buildNavItem('Skills', 2, context, themeCtrl),
                    _buildNavItem('Experience', 3, context, themeCtrl),
                    _buildNavItem('Projects', 4, context, themeCtrl),
                    _buildNavItem('Contact', 5, context, themeCtrl),
                  ],
                ),

              // Theme Toggle & Mobile Menu
              Row(
                children: [
                  // Theme Toggle
                  Obx(() => IconButton(
                        onPressed: themeController.toggleTheme,
                        icon: Icon(
                          themeController.isDarkMode
                              ? FontAwesomeIcons.sun
                              : FontAwesomeIcons.moon,
                          color:
                              themeCtrl.activeTheme.textTheme.bodyLarge?.color,
                        ),
                      )),

                  // Mobile Menu Button
                  if (MediaQuery.of(context).size.width <=
                      AppDimensions.mobileBreakpoint)
                    IconButton(
                      onPressed: () => _showMobileMenu(context),
                      icon: const Icon(Icons.menu),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(String title, int index, BuildContext context,
      ThemeController themeCtrl) {
    return Obx(() => GestureDetector(
          onTap: () => _scrollToSection(index),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color: navigationController.currentIndex.value == index
                  ? AppColors.primaryLight.withOpacity(0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(AppDimensions.radiusM),
            ),
            child: Text(
              title,
              style: themeCtrl.activeTheme.textTheme.bodyLarge?.copyWith(
                color: navigationController.currentIndex.value == index
                    ? AppColors.primaryLight
                    : themeCtrl.activeTheme.textTheme.bodyLarge?.color,
                fontWeight: navigationController.currentIndex.value == index
                    ? FontWeight.w600
                    : FontWeight.normal,
              ),
            ),
          ),
        ));
  }

  void _scrollToSection(int index) {
    navigationController.scrollToSection(index);
  }

  void _showMobileMenu(BuildContext context) {
    final themeCtrl = Get.find<ThemeController>();
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: themeCtrl.activeTheme.scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(top: 12, bottom: 20),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            _buildMobileNavItem('Home', 0, context, themeCtrl),
            _buildMobileNavItem('About', 1, context, themeCtrl),
            _buildMobileNavItem('Skills', 2, context, themeCtrl),
            _buildMobileNavItem('Experience', 3, context, themeCtrl),
            _buildMobileNavItem('Projects', 4, context, themeCtrl),
            _buildMobileNavItem('Contact', 5, context, themeCtrl),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileNavItem(String title, int index, BuildContext context,
      ThemeController themeCtrl) {
    return Obx(() => ListTile(
          title: Text(
            title,
            style: themeCtrl.activeTheme.textTheme.bodyLarge?.copyWith(
              color: navigationController.currentIndex.value == index
                  ? AppColors.primaryLight
                  : themeCtrl.activeTheme.textTheme.bodyLarge?.color,
              fontWeight: navigationController.currentIndex.value == index
                  ? FontWeight.w600
                  : FontWeight.normal,
            ),
          ),
          onTap: () {
            Navigator.pop(context);
            _scrollToSection(index);
          },
        ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(AppDimensions.headerHeight);
}
