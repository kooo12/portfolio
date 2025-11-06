import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:protfolio/controllers/theme_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/project.dart';
import '../utils/app_dimensions.dart';
import '../utils/app_colors.dart';

class ProjectDetailsView extends StatelessWidget {
  final Project project;

  ProjectDetailsView({super.key, required this.project});

  final themeCtrl = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(project.title),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          constraints:
              const BoxConstraints(maxWidth: AppDimensions.containerMaxWidth),
          margin: const EdgeInsets.symmetric(
              horizontal: AppDimensions.containerPadding,
              vertical: AppDimensions.spacingXL),
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > AppDimensions.mobileBreakpoint) {
                return _buildDesktopView(context);
              } else {
                return _buildMobileView(context);
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image banner
        Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppDimensions.radiusL),
                child: AspectRatio(
                  aspectRatio: 12 / 9,
                  child: Image.network(
                    project.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppDimensions.spacingXXXL),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    project.title,
                    style: themeCtrl.activeTheme.textTheme.headlineLarge
                        ?.copyWith(fontWeight: FontWeight.bold, fontSize: 26),
                  ),

                  const SizedBox(height: AppDimensions.spacingM),

                  // Category and actions
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppDimensions.spacingM,
                          vertical: AppDimensions.spacingXS,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryLight.withOpacity(0.1),
                          borderRadius:
                              BorderRadius.circular(AppDimensions.radiusS),
                          border: Border.all(
                            color: AppColors.primaryLight.withOpacity(0.3),
                          ),
                        ),
                        child: Text(
                          project.category,
                          style: const TextStyle(
                            color: AppColors.primaryLight,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: AppDimensions.spacingS,
                      ),
                      if (project.githubUrl != null)
                        _ActionButton(
                          icon: FontAwesomeIcons.github,
                          label: 'View Code',
                          onTap: () => _launchUrl(project.githubUrl!),
                        ),
                      if (project.liveUrl != null) ...[
                        const SizedBox(width: AppDimensions.spacingS),
                        _ActionButton(
                          icon: FontAwesomeIcons.googlePlay,
                          label: 'Play Store',
                          onTap: () => _launchUrl(project.liveUrl!),
                        ),
                      ]
                    ],
                  ),
                ],
              ),
            )
          ],
        ),

        const SizedBox(height: AppDimensions.spacingXL),

        // Description
        Text(
          project.description,
          style: themeCtrl.activeTheme.textTheme.bodyLarge?.copyWith(
            height: 1.5,
            color: themeCtrl.activeTheme.textTheme.bodyLarge?.color
                ?.withOpacity(0.8),
          ),
        ),

        const SizedBox(height: AppDimensions.spacingXL),

        // Technologies
        Text(
          'Technologies',
          style: themeCtrl.activeTheme.textTheme.titleLarge
              ?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: AppDimensions.spacingM),
        Wrap(
          spacing: AppDimensions.spacingS,
          runSpacing: AppDimensions.spacingS,
          children: project.technologies
              .map(
                (tech) => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.spacingM,
                    vertical: AppDimensions.spacingXS,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppDimensions.radiusS),
                    border: Border.all(
                      color: AppColors.primaryLight.withOpacity(0.3),
                    ),
                  ),
                  child: Text(
                    tech,
                    style: const TextStyle(
                      color: AppColors.primaryLight,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: AppDimensions.spacingXL),

        // Responsibilities
        Text(
          'Responsibilities',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),

        const SizedBox(height: AppDimensions.spacingM),

        ...project.responsibilities.map((response) {
          return Container(
            margin: const EdgeInsets.only(bottom: AppDimensions.spacingS),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  margin: const EdgeInsets.only(
                      top: 8, right: AppDimensions.spacingM),
                  decoration: const BoxDecoration(
                    color: AppColors.primaryLight,
                    shape: BoxShape.circle,
                  ),
                ),
                Expanded(
                  child: Text(
                    response,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          height: 1.5,
                        ),
                  ),
                ),
              ],
            ),
          );
        }),

        const SizedBox(height: AppDimensions.spacingXL),
        // Core Features
        Text(
          'Core Features',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),

        const SizedBox(height: AppDimensions.spacingM),

        ...project.coreFeatures.map((feature) {
          return Container(
            margin: const EdgeInsets.only(bottom: AppDimensions.spacingS),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  margin: const EdgeInsets.only(
                      top: 8, right: AppDimensions.spacingM),
                  decoration: const BoxDecoration(
                    color: AppColors.primaryLight,
                    shape: BoxShape.circle,
                  ),
                ),
                Expanded(
                  child: Text(
                    feature,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          height: 1.5,
                        ),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildMobileView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image banner
        ClipRRect(
          borderRadius: BorderRadius.circular(AppDimensions.radiusL),
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.network(
              project.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),

        const SizedBox(height: AppDimensions.spacingXL),

        // Title
        Text(
          project.title,
          style: themeCtrl.activeTheme.textTheme.headlineSmall
              ?.copyWith(fontWeight: FontWeight.bold, fontSize: 24),
        ),

        const SizedBox(height: AppDimensions.spacingM),

        // Category and actions
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.spacingM,
                vertical: AppDimensions.spacingXS,
              ),
              decoration: BoxDecoration(
                color: AppColors.primaryLight.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppDimensions.radiusS),
                border: Border.all(
                  color: AppColors.primaryLight.withOpacity(0.3),
                ),
              ),
              child: Text(
                project.category,
                style: const TextStyle(
                  color: AppColors.primaryLight,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            // const Spacer(),
            if (project.githubUrl != null)
              _ActionButton(
                icon: FontAwesomeIcons.github,
                label: 'View Code',
                onTap: () => _launchUrl(project.githubUrl!),
              ),
            if (project.playStoreUrl != null) ...[
              const SizedBox(width: AppDimensions.spacingS),
              _ActionButton(
                icon: FontAwesomeIcons.googlePlay,
                label: 'Play Store',
                onTap: () => _launchUrl(project.liveUrl!),
              ),
            ]
          ],
        ),

        const SizedBox(height: AppDimensions.spacingXL),

        // Description
        Text(
          project.description,
          style: themeCtrl.activeTheme.textTheme.bodyLarge?.copyWith(
            height: 1.5,
            color: themeCtrl.activeTheme.textTheme.bodyLarge?.color
                ?.withOpacity(0.8),
          ),
        ),

        const SizedBox(height: AppDimensions.spacingXL),

        // Technologies
        Text(
          'Technologies',
          style: themeCtrl.activeTheme.textTheme.titleLarge
              ?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: AppDimensions.spacingM),
        Wrap(
          spacing: AppDimensions.spacingS,
          runSpacing: AppDimensions.spacingS,
          children: project.technologies
              .map(
                (tech) => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.spacingM,
                    vertical: AppDimensions.spacingXS,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppDimensions.radiusS),
                    border: Border.all(
                      color: AppColors.primaryLight.withOpacity(0.3),
                    ),
                  ),
                  child: Text(
                    tech,
                    style: const TextStyle(
                      color: AppColors.primaryLight,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: AppDimensions.spacingXL),

        // Responsibilities
        Text(
          'Responsibilities',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),

        const SizedBox(height: AppDimensions.spacingM),

        ...project.responsibilities.map((response) {
          return Container(
            margin: const EdgeInsets.only(bottom: AppDimensions.spacingS),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  margin: const EdgeInsets.only(
                      top: 8, right: AppDimensions.spacingM),
                  decoration: const BoxDecoration(
                    color: AppColors.primaryLight,
                    shape: BoxShape.circle,
                  ),
                ),
                Expanded(
                  child: Text(
                    response,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          height: 1.5,
                        ),
                  ),
                ),
              ],
            ),
          );
        }),

        const SizedBox(height: AppDimensions.spacingXL),
        // Core Features
        Text(
          'Core Features',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),

        const SizedBox(height: AppDimensions.spacingM),

        ...project.coreFeatures.map((feature) {
          return Container(
            margin: const EdgeInsets.only(bottom: AppDimensions.spacingS),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  margin: const EdgeInsets.only(
                      top: 8, right: AppDimensions.spacingM),
                  decoration: const BoxDecoration(
                    color: AppColors.primaryLight,
                    shape: BoxShape.circle,
                  ),
                ),
                Expanded(
                  child: Text(
                    feature,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          height: 1.5,
                        ),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  void _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimensions.radiusM),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.spacingM,
          vertical: AppDimensions.spacingS,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          border: Border.all(
            color: Theme.of(context).dividerColor.withOpacity(0.3),
          ),
        ),
        child: Row(
          children: [
            Icon(icon, size: 16),
            const SizedBox(width: AppDimensions.spacingS),
            Text(label),
          ],
        ),
      ),
    );
  }
}
