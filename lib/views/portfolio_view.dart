import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/portfolio_controller.dart';
import '../controllers/navigation_controller.dart';
import '../controllers/theme_controller.dart';
import '../widgets/animated_background.dart';
import '../widgets/header.dart';
import '../widgets/hero_section.dart';
import '../widgets/about_section.dart';
import '../widgets/skills_section.dart';
import '../widgets/projects_section.dart';
import '../widgets/experience_section.dart';
import '../widgets/contact_section.dart';
import '../widgets/footer.dart';
import '../widgets/floating_scroll_button.dart';
import '../widgets/animated_loading.dart';

class PortfolioView extends StatelessWidget {
  PortfolioView({super.key});

  final ThemeController themeController = Get.find<ThemeController>();
  final PortfolioController portfolioController =
      Get.find<PortfolioController>();
  final NavigationController navigationController =
      Get.find<NavigationController>();

  // GlobalKeys for section tracking
  final GlobalKey heroKey = GlobalKey();
  final GlobalKey aboutKey = GlobalKey();
  final GlobalKey skillsKey = GlobalKey();
  final GlobalKey experienceKey = GlobalKey();
  final GlobalKey projectsKey = GlobalKey();
  final GlobalKey contactKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    // Initialize section keys in navigation controller
    WidgetsBinding.instance.addPostFrameCallback((_) {
      navigationController.setSectionKeys(
        hero: heroKey,
        about: aboutKey,
        skills: skillsKey,
        experience: experienceKey,
        projects: projectsKey,
        contact: contactKey,
      );
    });

    return Obx(
      () => Scaffold(
        appBar: portfolioController.isLoading.value
            ? null
            : Header(
                navigationController: navigationController,
                themeController: themeController,
              ),
        body: Obx(
          () => AnimatedSwitcher(
            duration: const Duration(milliseconds: 1600),
            switchInCurve: Curves.easeInOutCubicEmphasized,
            switchOutCurve: Curves.easeInOutCubic,
            layoutBuilder: (currentChild, previousChildren) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  ...previousChildren,
                  if (currentChild != null) currentChild,
                ],
              );
            },
            transitionBuilder: _oldTvTransition,
            child: portfolioController.isLoading.value
                ? const _LoaderStage()
                : _PortfolioContent(
                    navigationController: navigationController,
                    portfolioController: portfolioController,
                    heroKey: heroKey,
                    aboutKey: aboutKey,
                    skillsKey: skillsKey,
                    experienceKey: experienceKey,
                    projectsKey: projectsKey,
                    contactKey: contactKey,
                  ),
          ),
        ),
      ),
    );
  }

  Widget _oldTvTransition(Widget child, Animation<double> animation) {
    final curved =
        CurvedAnimation(parent: animation, curve: Curves.easeInOutCubic);

    return AnimatedBuilder(
      animation: curved,
      child: child,
      builder: (context, child) {
        final scaleY = lerpDouble(0.02, 1.0, curved.value) ?? 1.0;
        final rotation = lerpDouble(0.35, 0, curved.value) ?? 0;
        final borderRadius = lerpDouble(60, 0, curved.value) ?? 0;
        final glowOpacity = (1 - curved.value).clamp(0.0, 1.0);

        return Stack(
          children: [
            Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.0015)
                ..rotateX(rotation)
                ..scale(1, scaleY),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(borderRadius),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white.withOpacity(glowOpacity * 0.2),
                      width: 1.2,
                    ),
                  ),
                  child: child,
                ),
              ),
            ),
            if (glowOpacity > 0.01)
              IgnorePointer(
                child: Opacity(
                  opacity: glowOpacity * 0.8,
                  child: const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Colors.transparent,
                          Colors.white54,
                          Colors.transparent,
                        ],
                      ),
                    ),
                    child: SizedBox.expand(),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _LoaderStage extends StatelessWidget {
  const _LoaderStage();

  @override
  Widget build(BuildContext context) {
    return AnimatedBackground(
      child: Stack(
        fit: StackFit.expand,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.9),
                  Colors.black.withOpacity(0.6),
                ],
              ),
            ),
          ),
          const AnimatedLoading(),
        ],
      ),
    );
  }
}

class _PortfolioContent extends StatelessWidget {
  const _PortfolioContent({
    required this.navigationController,
    required this.portfolioController,
    required this.heroKey,
    required this.aboutKey,
    required this.skillsKey,
    required this.experienceKey,
    required this.projectsKey,
    required this.contactKey,
  });

  final NavigationController navigationController;
  final PortfolioController portfolioController;
  final GlobalKey heroKey;
  final GlobalKey aboutKey;
  final GlobalKey skillsKey;
  final GlobalKey experienceKey;
  final GlobalKey projectsKey;
  final GlobalKey contactKey;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedBackground(
          child: SingleChildScrollView(
            controller: navigationController.scrollController,
            child: Column(
              children: [
                HeroSection(
                  key: heroKey,
                  personalInfo: portfolioController.personalInfo.value!,
                  contactKey: contactKey,
                  scrollController: navigationController.scrollController,
                ),
                AboutSection(
                  key: aboutKey,
                  personalInfo: portfolioController.personalInfo.value!,
                ),
                SkillsSection(
                  key: skillsKey,
                  skills: portfolioController.skills,
                ),
                ExperienceSection(
                  key: experienceKey,
                  experiences: portfolioController.experiences,
                ),
                ProjectsSection(
                  key: projectsKey,
                  projects: portfolioController.filteredProjects,
                  categories: portfolioController.projectCategories,
                  selectedCategory:
                      portfolioController.selectedProjectCategory.value,
                  onCategoryChanged: portfolioController.selectProjectCategory,
                ),
                ContactSection(
                  key: contactKey,
                  personalInfo: portfolioController.personalInfo.value!,
                ),
                const Footer(),
              ],
            ),
          ),
        ),
        FloatingScrollButton(
          scrollController: navigationController.scrollController,
          navigationController: navigationController,
        ),
      ],
    );
  }
}
