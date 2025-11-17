import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:protfolio/controllers/navigation_controller.dart';
import 'package:protfolio/controllers/theme_controller.dart';
import '../models/personal_info.dart';
import '../utils/app_colors.dart';
import '../utils/app_dimensions.dart';

class AboutSection extends StatelessWidget {
  final PersonalInfo personalInfo;
  final ThemeController themeCtrl = Get.find<ThemeController>();
  final NavigationController navigationController =
      Get.find<NavigationController>();

  AboutSection({
    super.key,
    required this.personalInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final tick = navigationController.sectionAnimationTicks[1].value;
      return KeyedSubtree(
        key: ValueKey('about-section-$tick'),
        child: Obx(
          () => Container(
            constraints:
                const BoxConstraints(maxWidth: AppDimensions.containerMaxWidth),
            margin: const EdgeInsets.symmetric(
                horizontal: AppDimensions.containerPadding),
            padding:
                const EdgeInsets.symmetric(vertical: AppDimensions.spacingS),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section Title
                Text(
                  'About Me',
                  style: themeCtrl.activeTheme.textTheme.displayMedium
                      ?.copyWith(fontWeight: FontWeight.bold, fontSize: 45),
                ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.2),

                const SizedBox(height: AppDimensions.spacingL),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left side - Content
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Bio
                          Text(
                            personalInfo.bio,
                            style: themeCtrl.activeTheme.textTheme.bodyLarge
                                ?.copyWith(
                              height: 1.8,
                              color: themeCtrl
                                  .activeTheme.textTheme.bodyLarge?.color
                                  ?.withOpacity(0.8),
                            ),
                          )
                              .animate()
                              .fadeIn(duration: 800.ms, delay: 200.ms)
                              .slideY(begin: -0.2),

                          const SizedBox(height: AppDimensions.spacingXL),

                          // Additional Info
                          _buildInfoRow(context, Icons.location_on, 'Location',
                                  personalInfo.location, themeCtrl)
                              .animate()
                              .fadeIn(duration: 600.ms, delay: 400.ms)
                              .slideX(begin: -0.2),

                          const SizedBox(height: AppDimensions.spacingM),

                          _buildInfoRow(context, Icons.email, 'Email',
                                  personalInfo.email, themeCtrl)
                              .animate()
                              .fadeIn(duration: 600.ms, delay: 500.ms)
                              .slideX(begin: -0.2),

                          const SizedBox(height: AppDimensions.spacingM),

                          _buildInfoRow(context, Icons.phone, 'Phone',
                                  personalInfo.phone, themeCtrl)
                              .animate()
                              .fadeIn(duration: 600.ms, delay: 600.ms)
                              .slideX(begin: -0.2),

                          const SizedBox(height: AppDimensions.spacingXL),

                          // Stats
                          Row(
                            children: [
                              Expanded(
                                child: _buildStatCard(context, '3+',
                                        'Years Experience', themeCtrl)
                                    .animate()
                                    .fadeIn(duration: 600.ms, delay: 700.ms)
                                    .scale(begin: const Offset(0.8, 0.8)),
                              ),
                              const SizedBox(width: AppDimensions.spacingL),
                              Expanded(
                                child: _buildStatCard(context, '20+',
                                        'Projects Completed', themeCtrl)
                                    .animate()
                                    .fadeIn(duration: 600.ms, delay: 800.ms)
                                    .scale(begin: const Offset(0.8, 0.8)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Right side - Skills Preview
                    if (MediaQuery.of(context).size.width >
                        AppDimensions.tabletBreakpoint) ...[
                      const SizedBox(width: AppDimensions.spacingXXXL),
                      Expanded(
                        flex: 1,
                        child: _buildSkillsPreview(context, themeCtrl)
                            .animate()
                            .fadeIn(duration: 800.ms, delay: 300.ms)
                            .slideX(begin: 0.2),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildInfoRow(BuildContext context, IconData icon, String label,
      String value, ThemeController themeCtrl) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(AppDimensions.spacingM),
          decoration: BoxDecoration(
            color: AppColors.primaryLight.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          ),
          child: Icon(
            icon,
            color: AppColors.primaryLight,
            size: 20,
          ),
        ),
        const SizedBox(width: AppDimensions.spacingM),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: themeCtrl.activeTheme.textTheme.bodyMedium?.copyWith(
                color: themeCtrl.activeTheme.textTheme.bodyLarge?.color
                    ?.withOpacity(0.6),
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              value,
              style: themeCtrl.activeTheme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(BuildContext context, String number, String label,
      ThemeController themeCtrl) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.spacingL),
      decoration: BoxDecoration(
        color: themeCtrl.isDarkMode ? AppColors.cardDark : AppColors.light,
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        border: Border.all(
          color: themeCtrl.activeTheme.dividerColor.withOpacity(0.1),
        ),
        boxShadow: [
          BoxShadow(
            color: themeCtrl.isDarkMode ? AppColors.darkerGrey : AppColors.grey,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            number,
            style: themeCtrl.activeTheme.textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.primaryLight,
            ),
          ),
          const SizedBox(height: AppDimensions.spacingS),
          Text(
            label,
            style: themeCtrl.activeTheme.textTheme.bodyMedium?.copyWith(
              color: themeCtrl.activeTheme.textTheme.bodyLarge?.color
                  ?.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsPreview(BuildContext context, ThemeController themeCtrl) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.spacingL),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primaryLight.withOpacity(0.1),
            AppColors.secondaryLight.withOpacity(0.1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
        border: Border.all(
          color: AppColors.primaryLight.withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Core Skills',
            style: themeCtrl.activeTheme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.primaryLight,
            ),
          ),
          const SizedBox(height: AppDimensions.spacingL),
          _buildSkillChip(context, 'Flutter', themeCtrl),
          _buildSkillChip(context, 'Dart', themeCtrl),
          _buildSkillChip(context, 'Firebase', themeCtrl),
          _buildSkillChip(context, 'REST API', themeCtrl),
          _buildSkillChip(context, 'Git', themeCtrl),
          _buildSkillChip(context, 'GetX', themeCtrl),
          _buildSkillChip(context, 'BLoC', themeCtrl),
          _buildSkillChip(context, 'Provider', themeCtrl),
          _buildSkillChip(context, 'Mobile Development', themeCtrl),
        ],
      ),
    );
  }

  Widget _buildSkillChip(
      BuildContext context, String skill, ThemeController themeCtrl) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppDimensions.spacingS),
      padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.spacingM, vertical: AppDimensions.spacingS),
      decoration: BoxDecoration(
        color: themeCtrl.isDarkMode ? AppColors.cardDark : AppColors.cardLight,
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        border: Border.all(
          color: AppColors.primaryLight.withOpacity(0.2),
        ),
      ),
      child: Text(
        skill,
        style: themeCtrl.activeTheme.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
