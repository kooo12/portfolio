import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../controllers/navigation_controller.dart';
import '../models/experience.dart';
import '../utils/app_colors.dart';
import '../utils/app_dimensions.dart';

class ExperienceSection extends StatelessWidget {
  final RxList<Experience> experiences;
  final NavigationController navigationController =
      Get.find<NavigationController>();

  ExperienceSection({
    super.key,
    required this.experiences,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final tick = navigationController.sectionAnimationTicks[3].value;
      return KeyedSubtree(
        key: ValueKey('experience-section-$tick'),
        child: _buildContent(context),
      );
    });
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      constraints:
          const BoxConstraints(maxWidth: AppDimensions.containerMaxWidth),
      margin: const EdgeInsets.symmetric(
          horizontal: AppDimensions.containerPadding),
      padding: const EdgeInsets.symmetric(vertical: AppDimensions.spacingS),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          Text(
            'Work Experience',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.headlineLarge?.color,
                ),
          ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.2),

          const SizedBox(height: AppDimensions.spacingL),

          Text(
            'My professional journey and the experiences that shaped my career',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.color
                      ?.withOpacity(0.7),
                ),
          )
              .animate()
              .fadeIn(duration: 600.ms, delay: 200.ms)
              .slideY(begin: -0.2),

          const SizedBox(height: AppDimensions.spacingXXXL),

          // Timeline
          _buildTimeline(context),
        ],
      ),
    );
  }

  Widget _buildTimeline(BuildContext context) {
    return Column(
      children: experiences.asMap().entries.map((entry) {
        final index = entry.key;
        final experience = entry.value;
        return _buildTimelineItem(context, experience, index);
      }).toList(),
    );
  }

  Widget _buildTimelineItem(
      BuildContext context, Experience experience, int index) {
    final isLeft = index % 2 == 0;

    return Container(
      margin: const EdgeInsets.only(bottom: AppDimensions.spacingXXXL),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline Line & Dot
          Column(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryLight.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              if (index < experiences.length - 1)
                Container(
                  width: 2,
                  height: 100,
                  color: Theme.of(context).dividerColor.withOpacity(0.3),
                ),
            ],
          ),

          const SizedBox(width: AppDimensions.spacingXL),

          // Experience Content
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(AppDimensions.spacingXL),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(AppDimensions.radiusL),
                border: Border.all(
                  color: Theme.of(context).dividerColor.withOpacity(0.1),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    children: [
                      // Company Logo
                      if (experience.logoUrl != null)
                        CachedNetworkImage(
                          width: 40,
                          height: 40,
                          imageUrl: experience.logoUrl!,
                          fit: BoxFit.cover,
                        ),

                      if (experience.logoUrl != null)
                        const SizedBox(width: AppDimensions.spacingM),

                      // Company & Position Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              experience.position,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryLight,
                                  ),
                            ),
                            Text(
                              experience.company,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            Text(
                              experience.duration,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.color
                                        ?.withOpacity(0.6),
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: AppDimensions.spacingL),

                  // Description
                  Text(
                    experience.description,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          height: 1.6,
                          color: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.color
                              ?.withOpacity(0.8),
                        ),
                  ),

                  const SizedBox(height: AppDimensions.spacingL),

                  // Achievements
                  Text(
                    'Key Achievements:',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryLight,
                        ),
                  ),

                  const SizedBox(height: AppDimensions.spacingM),

                  ...experience.achievements.map((achievement) {
                    return Container(
                      margin:
                          const EdgeInsets.only(bottom: AppDimensions.spacingS),
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
                              achievement,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    height: 1.5,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 800.ms, delay: (index * 200).ms)
        .slideX(begin: isLeft ? -0.2 : 0.2);
  }
}
