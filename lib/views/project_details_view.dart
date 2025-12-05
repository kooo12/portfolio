import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:protfolio/controllers/theme_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
                  child: _buildProjectImage(project.imageUrl),
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

                  // Warning banner for Fuel Energy project
                  if (_isFuelEnergyProject(project.title)) ...[
                    _buildWarningBanner(context),
                    const SizedBox(height: AppDimensions.spacingM),
                  ],

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
                  const SizedBox(height: AppDimensions.spacingM),

                  // Category and actions
                  Wrap(
                    spacing: AppDimensions.spacingS,
                    runSpacing: AppDimensions.spacingS,
                    children: [
                      if (project.githubUrl != null)
                        _ActionButton(
                          icon: FontAwesomeIcons.github,
                          label: 'View Code',
                          onTap: () => _launchUrl(project.githubUrl!),
                        ),
                      if (project.appStoreUrl != null)
                        _ActionButton(
                          icon: FontAwesomeIcons.appStore,
                          label: 'App Store',
                          onTap: () => _launchUrl(project.appStoreUrl!),
                        ),
                      if (project.playStoreUrl != null)
                        _ActionButton(
                          icon: FontAwesomeIcons.googlePlay,
                          label: 'Play Store',
                          onTap: () => _launchUrl(project.playStoreUrl!),
                        ),
                      if (project.liveUrl != null &&
                          project.playStoreUrl == null &&
                          project.appStoreUrl == null)
                        _ActionButton(
                          icon: FontAwesomeIcons.link,
                          label: 'Live Demo',
                          onTap: () => _launchUrl(project.liveUrl!),
                        ),
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
            child: _buildProjectImage(project.imageUrl),
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

        // Warning banner for Fuel Energy project
        if (_isFuelEnergyProject(project.title)) ...[
          _buildWarningBanner(context),
          const SizedBox(height: AppDimensions.spacingM),
        ],

        // Category and actions
        Wrap(
          spacing: AppDimensions.spacingS,
          runSpacing: AppDimensions.spacingS,
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
            if (project.githubUrl != null)
              _ActionButton(
                icon: FontAwesomeIcons.github,
                label: 'View Code',
                onTap: () => _launchUrl(project.githubUrl!),
              ),
            if (project.playStoreUrl != null)
              _ActionButton(
                icon: FontAwesomeIcons.googlePlay,
                label: 'Play Store',
                onTap: () => _launchUrl(project.playStoreUrl!),
              ),
            if (project.appStoreUrl != null)
              _ActionButton(
                icon: FontAwesomeIcons.appStore,
                label: 'App Store',
                onTap: () => _launchUrl(project.appStoreUrl!),
              ),
            if (project.liveUrl != null &&
                project.playStoreUrl == null &&
                project.appStoreUrl == null)
              _ActionButton(
                icon: FontAwesomeIcons.link,
                label: 'Live Demo',
                onTap: () => _launchUrl(project.liveUrl!),
              ),
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

  Widget _buildProjectImage(String imageUrl) {
    // Check if it's an asset image or network image
    final isAsset =
        imageUrl.startsWith('assets/') || !imageUrl.startsWith('http');

    if (isAsset) {
      // Use Image.asset for local assets
      return Image.asset(
        imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _buildErrorWidget();
        },
      );
    } else {
      // Use CachedNetworkImage for network images (better for web)
      return CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          color: AppColors.primaryLight.withOpacity(0.1),
          child: const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                AppColors.primaryLight,
              ),
            ),
          ),
        ),
        errorWidget: (context, url, error) => _buildErrorWidget(),
        // Add headers for CORS if needed
        httpHeaders: const {
          'Access-Control-Allow-Origin': '*',
        },
      );
    }
  }

  Widget _buildErrorWidget() {
    return Container(
      color: AppColors.primaryLight.withOpacity(0.1),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.image_not_supported,
              size: 48,
              color: AppColors.primaryLight.withOpacity(0.5),
            ),
            const SizedBox(height: 8),
            Text(
              'Image not available',
              style: TextStyle(
                color: AppColors.primaryLight.withOpacity(0.7),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _isFuelEnergyProject(String title) {
    return title.toLowerCase().contains('fuel energy') ||
        title.toLowerCase().contains('fuel & logistics') ||
        title.toLowerCase().contains('logistics management');
  }

  Widget _buildWarningBanner(BuildContext context) {
    final isDarkMode = themeCtrl.isDarkMode;
    return Container(
      padding: const EdgeInsets.all(AppDimensions.spacingM),
      decoration: BoxDecoration(
        color: isDarkMode
            ? Colors.orange.withOpacity(0.15)
            : Colors.orange.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        border: Border.all(
          color: Colors.orange.withOpacity(0.4),
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: Colors.orange.shade700,
            size: 24,
          ),
          const SizedBox(width: AppDimensions.spacingM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Enterprise Application Notice',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: Colors.orange.shade700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'This is a real-world enterprise application owned by the company. Please do not attempt to test or access the app as it is actively used in production.',
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.4,
                    color: isDarkMode
                        ? Colors.orange.shade200
                        : Colors.orange.shade900,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}

class _ActionButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  State<_ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<_ActionButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.spacingM,
            vertical: AppDimensions.spacingS,
          ),
          decoration: BoxDecoration(
            color: _isHovered
                ? (isDarkMode
                    ? AppColors.primaryLight.withOpacity(0.2)
                    : AppColors.primaryLight.withOpacity(0.1))
                : theme.cardColor,
            borderRadius: BorderRadius.circular(AppDimensions.radiusM),
            border: Border.all(
              color: _isHovered
                  ? AppColors.primaryLight.withOpacity(0.5)
                  : theme.dividerColor.withOpacity(0.3),
              width: _isHovered ? 1.5 : 1,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: AppColors.primaryLight.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                size: 16,
                color: _isHovered
                    ? AppColors.primaryLight
                    : theme.textTheme.bodyLarge?.color,
              ),
              const SizedBox(width: AppDimensions.spacingS),
              Text(
                widget.label,
                style: TextStyle(
                  color: _isHovered
                      ? AppColors.primaryLight
                      : theme.textTheme.bodyLarge?.color,
                  fontWeight: _isHovered ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
