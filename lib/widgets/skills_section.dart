import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../controllers/navigation_controller.dart';
import '../models/skill.dart';
import '../utils/app_colors.dart';
import '../utils/app_dimensions.dart';
import 'skill_card.dart';

class SkillsSection extends StatelessWidget {
  final RxList<Skill> skills;
  final NavigationController navigationController =
      Get.find<NavigationController>();

  SkillsSection({
    super.key,
    required this.skills,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final tick = navigationController.sectionAnimationTicks[2].value;
      return KeyedSubtree(
        key: ValueKey('skills-section-$tick'),
        child: _buildContent(context),
      );
    });
  }

  Widget _buildContent(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Container(
      constraints:
          const BoxConstraints(maxWidth: AppDimensions.containerMaxWidth),
      margin: EdgeInsets.symmetric(
          horizontal: isMobile
              ? AppDimensions.spacingM
              : AppDimensions.containerPadding),
      padding: EdgeInsets.symmetric(
          vertical:
              isMobile ? AppDimensions.spacingXL : AppDimensions.spacingXXXL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title - Responsive
          Text(
            'Skills & Technologies',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.headlineLarge?.color,
                  fontSize: isMobile ? 28 : null,
                ),
          )
              .animate()
              .fadeIn(duration: 800.ms, curve: Curves.easeOut)
              .slideY(begin: -0.3, curve: Curves.easeOutBack)
              .scale(begin: const Offset(0.8, 0.8), curve: Curves.easeOutBack)
              .shimmer(
                  duration: 2000.ms,
                  delay: 600.ms,
                  color: AppColors.primaryLight.withOpacity(0.3)),

          SizedBox(
              height:
                  isMobile ? AppDimensions.spacingM : AppDimensions.spacingL),

          Text(
            'Here are the technologies and tools I work with',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.color
                      ?.withOpacity(0.7),
                  fontSize: isMobile ? 14 : null,
                ),
          )
              .animate()
              .fadeIn(duration: 600.ms, delay: 200.ms)
              .slideY(begin: -0.2),

          SizedBox(
              height:
                  isMobile ? AppDimensions.spacingXL : AppDimensions.spacingXL),

          // Skills Grid - Mobile Responsive
          Obx(() {
            final skillsList = skills.toList();
            return LayoutBuilder(
              builder: (context, constraints) {
                final screenWidth = MediaQuery.of(context).size.width;

                int crossAxisCount;
                double crossAxisSpacing;
                double mainAxisSpacing;
                double childAspectRatio;

                if (screenWidth < AppDimensions.mobileBreakpoint) {
                  // Mobile screens
                  if (screenWidth < 480) {
                    crossAxisCount = 2;
                    crossAxisSpacing = 6;
                    mainAxisSpacing = 8;
                    childAspectRatio = 1.0; // Square cards
                  } else {
                    crossAxisCount = 3;
                    crossAxisSpacing = 10;
                    mainAxisSpacing = 12;
                    childAspectRatio = 1.0; // Square cards
                  }
                } else if (screenWidth < AppDimensions.tabletBreakpoint) {
                  // Tablet screens
                  crossAxisCount = 4;
                  crossAxisSpacing = AppDimensions.spacingL;
                  mainAxisSpacing = AppDimensions.spacingL;
                  childAspectRatio = 1.0; // Square cards
                } else if (screenWidth < AppDimensions.desktopBreakpoint) {
                  crossAxisCount = 5;
                  crossAxisSpacing = AppDimensions.spacingL;
                  mainAxisSpacing = AppDimensions.spacingL;
                  childAspectRatio = 1.0; // Square cards
                } else {
                  // Large desktop screens
                  crossAxisCount = 6;
                  crossAxisSpacing = AppDimensions.spacingXL;
                  mainAxisSpacing = AppDimensions.spacingXL;
                  childAspectRatio = 1.0; // Square cards
                }

                return GridView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.spacingXL),
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: crossAxisSpacing,
                    mainAxisSpacing: mainAxisSpacing,
                    childAspectRatio: childAspectRatio,
                  ),
                  itemCount: skillsList.length,
                  itemBuilder: (context, skillIndex) {
                    return SkillCard(
                      skill: skillsList[skillIndex],
                      delay: skillIndex * 100,
                    );
                  },
                );
              },
            );
          }),
        ],
      ),
    );
  }
}
