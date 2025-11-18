import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controllers/navigation_controller.dart';
import '../models/project.dart';
import '../utils/app_colors.dart';
import '../utils/app_dimensions.dart';

class ProjectsSection extends StatelessWidget {
  final List<Project> projects;
  final List<String> categories;
  final String selectedCategory;
  final Function(String) onCategoryChanged;

  const ProjectsSection({
    super.key,
    required this.projects,
    required this.categories,
    required this.selectedCategory,
    required this.onCategoryChanged,
  });

  @override
  Widget build(BuildContext context) {
    final navigationController = Get.find<NavigationController>();
    return Container(
      constraints:
          const BoxConstraints(maxWidth: AppDimensions.containerMaxWidth),
      margin: EdgeInsets.symmetric(
        horizontal:
            MediaQuery.of(context).size.width < AppDimensions.mobileBreakpoint
                ? AppDimensions.spacingM
                : AppDimensions.containerPadding,
      ),
      padding: EdgeInsets.symmetric(
        vertical:
            MediaQuery.of(context).size.width < AppDimensions.mobileBreakpoint
                ? AppDimensions.spacingXL
                : AppDimensions.spacingXXL,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          Obx(() {
            final shouldAnimate = navigationController.currentIndex.value >= 4;
            return Text(
              'Featured Projects',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.headlineLarge?.color,
                  ),
            )
                .animate(target: shouldAnimate ? 1 : 0)
                .fadeIn(duration: 600.ms)
                .slideY(begin: -0.2);
          }),

          const SizedBox(height: AppDimensions.spacingL),

          Obx(() {
            final shouldAnimate = navigationController.currentIndex.value >= 4;
            return Text(
              'Here are some of my recent projects that showcase my skills and experience',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.color
                        ?.withOpacity(0.7),
                  ),
            )
                .animate(target: shouldAnimate ? 1 : 0)
                .fadeIn(duration: 600.ms, delay: 200.ms)
                .slideY(begin: -0.2);
          }),

          const SizedBox(height: AppDimensions.spacingXXXL),

          // Category Filter
          Obx(() {
            final shouldAnimate = navigationController.currentIndex.value >= 4;
            return _buildCategoryFilter(context)
                .animate(target: shouldAnimate ? 1 : 0)
                .fadeIn(duration: 600.ms, delay: 400.ms)
                .slideY(begin: -0.2);
          }),

          const SizedBox(height: AppDimensions.spacingXXXL),

          // Projects Grid
          Obx(() {
            final shouldAnimate = navigationController.currentIndex.value >= 4;
            return _buildProjectsGrid(context)
                .animate(target: shouldAnimate ? 1 : 0)
                .fadeIn(duration: 800.ms, delay: 600.ms)
                .slideY(begin: 0.2);
          }),
        ],
      ),
    );
  }

  Widget _buildCategoryFilter(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.map((category) {
          final isSelected = category == selectedCategory;
          return Container(
            margin: const EdgeInsets.only(right: AppDimensions.spacingM),
            child: FilterChip(
              label: Text(category),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  onCategoryChanged(category);
                }
              },
              selectedColor: AppColors.primaryLight.withOpacity(0.2),
              checkmarkColor: AppColors.primaryLight,
              labelStyle: TextStyle(
                color: isSelected
                    ? AppColors.primaryLight
                    : Theme.of(context).textTheme.bodyLarge?.color,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
              backgroundColor: Theme.of(context).cardColor,
              side: BorderSide(
                color: isSelected
                    ? AppColors.primaryLight
                    : Theme.of(context).dividerColor.withOpacity(0.3),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildProjectsGrid(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.of(context).size.width;
        final isMobile = screenWidth < AppDimensions.mobileBreakpoint;
        final isSmallTablet = screenWidth >= AppDimensions.mobileBreakpoint &&
            screenWidth < 900; // Smaller tablet breakpoint
        final isLargeTablet =
            screenWidth >= 900 && screenWidth < AppDimensions.tabletBreakpoint;

        int crossAxisCount;
        double crossAxisSpacing;
        double mainAxisSpacing;
        double childAspectRatio;

        if (isMobile) {
          // Mobile: 1 column, compact spacing
          crossAxisCount = 1;
          crossAxisSpacing = AppDimensions.spacingM;
          mainAxisSpacing = AppDimensions.spacingL;
          childAspectRatio = 1;
        } else if (isSmallTablet) {
          // Smaller Tablet: 1 column, moderate spacing
          crossAxisCount = 2;
          crossAxisSpacing = AppDimensions.spacingL;
          mainAxisSpacing = AppDimensions.spacingXL;
          childAspectRatio = 1.0;
        } else if (isLargeTablet) {
          // Larger Tablet: 2 columns, moderate spacing
          crossAxisCount = 2;
          crossAxisSpacing = AppDimensions.spacingL;
          mainAxisSpacing = AppDimensions.spacingXL;
          childAspectRatio = 1.25;
        } else {
          // Desktop: 2 columns, generous spacing
          crossAxisCount = 2;
          crossAxisSpacing = AppDimensions.spacingXL;
          mainAxisSpacing = AppDimensions.spacingXL;
          childAspectRatio = 1.35;
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: isMobile || isSmallTablet ? 0 : AppDimensions.spacingM,
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: crossAxisSpacing,
            mainAxisSpacing: mainAxisSpacing,
            childAspectRatio: childAspectRatio,
          ),
          itemCount: projects.length,
          itemBuilder: (context, index) {
            final isTablet = isSmallTablet || isLargeTablet;
            return _buildProjectCard(
                context, projects[index], index, isMobile, isTablet);
          },
        );
      },
    );
  }

  Widget _buildProjectCard(BuildContext context, Project project, int index,
      bool isMobile, bool isTablet) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: InkWell(
        onTap: () => Get.toNamed('/project/${project.id}'),
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(AppDimensions.radiusL),
            border: Border.all(
              color: Theme.of(context).dividerColor.withOpacity(0.1),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 20,
                offset: const Offset(0, 8),
                spreadRadius: 0,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppDimensions.radiusL),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Project Image with Overlay
                Expanded(
                  flex: isMobile ? 5 : 5,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Image with error handling
                      project.imageUrl.startsWith('http')
                          ? Image.network(
                              project.imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color:
                                      AppColors.primaryLight.withOpacity(0.1),
                                  child: Icon(
                                    Icons.image_not_supported,
                                    size: 48,
                                    color:
                                        AppColors.primaryLight.withOpacity(0.5),
                                  ),
                                );
                              },
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Container(
                                  color:
                                      AppColors.primaryLight.withOpacity(0.1),
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                      strokeWidth: 2,
                                      valueColor:
                                          const AlwaysStoppedAnimation<Color>(
                                        AppColors.primaryLight,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )
                          : Image.asset(
                              project.imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color:
                                      AppColors.primaryLight.withOpacity(0.1),
                                  child: Icon(
                                    Icons.image_not_supported,
                                    size: 48,
                                    color:
                                        AppColors.primaryLight.withOpacity(0.5),
                                  ),
                                );
                              },
                            ),
                      // Gradient Overlay
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.6),
                            ],
                            stops: const [0.5, 1.0],
                          ),
                        ),
                      ),
                      // Category Badge
                      Positioned(
                        top: isMobile
                            ? AppDimensions.spacingS
                            : AppDimensions.spacingM,
                        left: isMobile
                            ? AppDimensions.spacingS
                            : AppDimensions.spacingM,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: isMobile
                                ? AppDimensions.spacingS
                                : AppDimensions.spacingM,
                            vertical: isMobile
                                ? AppDimensions.spacingXS
                                : AppDimensions.spacingS,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryLight.withOpacity(0.95),
                            borderRadius:
                                BorderRadius.circular(AppDimensions.radiusM),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Text(
                            project.category,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: isMobile ? 10 : 12,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),
                      // Action Buttons
                      Positioned(
                        bottom: isMobile
                            ? AppDimensions.spacingS
                            : AppDimensions.spacingM,
                        right: isMobile
                            ? AppDimensions.spacingS
                            : AppDimensions.spacingM,
                        child: Wrap(
                          spacing: AppDimensions.spacingS,
                          children: [
                            if (project.githubUrl != null)
                              _buildActionButton(
                                context,
                                FontAwesomeIcons.github,
                                project.githubUrl!,
                                'View Code',
                                isMobile,
                              ),
                            if (project.liveUrl != null)
                              _buildActionButton(
                                context,
                                FontAwesomeIcons.link,
                                project.liveUrl!,
                                'Live Demo',
                                isMobile,
                              ),
                            if (project.playStoreUrl != null)
                              _buildActionButton(
                                context,
                                FontAwesomeIcons.googlePlay,
                                project.playStoreUrl!,
                                'Play Store',
                                isMobile,
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Project Info
                Expanded(
                  flex: isMobile ? 2 : 4,
                  child: Padding(
                    padding: EdgeInsets.all(
                      isMobile
                          ? AppDimensions.spacingM
                          : AppDimensions.spacingL,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: isMobile
                          ? MainAxisAlignment.start
                          : MainAxisAlignment.spaceBetween,
                      children: [
                        // Title and Description
                        if (isMobile)
                          // Mobile: Only Title
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  project.title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                // Project Description
                                Expanded(
                                  child: Text(
                                    project.description,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.color
                                              ?.withOpacity(0.7),
                                          height: 1.5,
                                          fontSize: isTablet ? 13 : 14,
                                        ),
                                    maxLines: isTablet ? 2 : 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          )
                        else
                          // Tablet and Desktop: Title + Description
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Project Title
                                Text(
                                  project.title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: isTablet ? 18 : 20,
                                      ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: AppDimensions.spacingS),
                                // Project Description
                                Expanded(
                                  child: Text(
                                    project.description,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.color
                                              ?.withOpacity(0.7),
                                          height: 1.5,
                                          fontSize: isTablet ? 13 : 14,
                                        ),
                                    maxLines: isTablet ? 2 : 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),

                        SizedBox(
                            height: isMobile
                                ? AppDimensions.spacingS
                                : AppDimensions.spacingM),

                        // Technologies
                        Wrap(
                          spacing: AppDimensions.spacingXS,
                          runSpacing: AppDimensions.spacingXS,
                          children: project.technologies
                              .take(isMobile ? 3 : 4)
                              .map((tech) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: isMobile
                                    ? AppDimensions.spacingXS
                                    : AppDimensions.spacingS,
                                vertical: isMobile
                                    ? AppDimensions.spacingXS / 2
                                    : AppDimensions.spacingXS,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primaryLight.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(
                                    AppDimensions.radiusS),
                                border: Border.all(
                                  color:
                                      AppColors.primaryLight.withOpacity(0.3),
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                tech,
                                style: TextStyle(
                                  fontSize: isMobile ? 9 : 10,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primaryLight,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 600.ms, delay: (index * 100).ms)
        .scale(begin: const Offset(0.95, 0.95), curve: Curves.easeOutBack);
  }

  Widget _buildActionButton(BuildContext context, IconData icon, String url,
      String tooltip, bool isMobile) {
    return Tooltip(
      message: tooltip,
      child: GestureDetector(
        onTap: () => _launchUrl(url),
        child: Container(
          padding: EdgeInsets.all(
            isMobile ? AppDimensions.spacingS : AppDimensions.spacingM,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.25),
            borderRadius: BorderRadius.circular(AppDimensions.radiusM),
            border: Border.all(
              color: Colors.white.withOpacity(0.4),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: isMobile ? 14 : 16,
          ),
        ),
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
