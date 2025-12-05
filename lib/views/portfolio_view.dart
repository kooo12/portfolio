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
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 900),
          switchInCurve: Curves.easeInOutCubic,
          switchOutCurve: Curves.easeInOutCubic,
          transitionBuilder: _bottomToTopTransition,
          child: portfolioController.isLoading.value
              ? const _LoaderStage(key: ValueKey('loader'))
              : _PortfolioContent(
                  key: const ValueKey('content'),
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
    );
  }

  Widget _bottomToTopTransition(Widget child, Animation<double> animation) {
    // Smooth page-scrolling-like animation from bottom to top
    final slideAnimation = CurvedAnimation(
      parent: animation,
      curve: Curves.easeInOutCubic,
    );

    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0.0, 1.0), // Start from bottom (full screen height)
        end: Offset.zero, // End at normal position
      ).animate(slideAnimation),
      child: child,
    );
  }
}

class _LoaderStage extends StatelessWidget {
  const _LoaderStage({super.key});

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
    super.key,
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
                RepaintBoundary(
                  child: HeroSection(
                    key: heroKey,
                    personalInfo: portfolioController.personalInfo.value!,
                    contactKey: contactKey,
                    scrollController: navigationController.scrollController,
                  ),
                ),
                RepaintBoundary(
                  child: AboutSection(
                    key: aboutKey,
                    personalInfo: portfolioController.personalInfo.value!,
                  ),
                ),
                RepaintBoundary(
                  child: SkillsSection(
                    key: skillsKey,
                    skills: portfolioController.skills,
                  ),
                ),
                RepaintBoundary(
                  child: ExperienceSection(
                    key: experienceKey,
                    experiences: portfolioController.experiences,
                  ),
                ),
                RepaintBoundary(
                  child: Obx(
                    () => ProjectsSection(
                      key: projectsKey,
                      projects: portfolioController.filteredProjects,
                      categories: portfolioController.projectCategories,
                      selectedCategory:
                          portfolioController.selectedProjectCategory.value,
                      onCategoryChanged:
                          portfolioController.selectProjectCategory,
                    ),
                  ),
                ),
                RepaintBoundary(
                  child: ContactSection(
                    key: contactKey,
                    personalInfo: portfolioController.personalInfo.value!,
                  ),
                ),
                const RepaintBoundary(child: Footer()),
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
