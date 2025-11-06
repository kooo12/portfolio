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

    return Scaffold(
      appBar: Header(
        navigationController: navigationController,
        themeController: themeController,
      ),
      body: Obx(() => portfolioController.isLoading.value
          ? const AnimatedBackground(
              child: AnimatedLoading(),
            )
          : Stack(
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
                          scrollController:
                              navigationController.scrollController,
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
                          onCategoryChanged:
                              portfolioController.selectProjectCategory,
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
            )),
    );
  }
}
