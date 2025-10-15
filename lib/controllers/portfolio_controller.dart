import 'package:get/get.dart';
import '../models/personal_info.dart';
import '../models/project.dart';
import '../models/skill.dart';
import '../models/experience.dart';
import '../services/portfolio_service.dart';

class PortfolioController extends GetxController {
  var personalInfo = Rxn<PersonalInfo>();
  var projects = <Project>[].obs;
  var skills = <Skill>[].obs;
  var experiences = <Experience>[].obs;
  var isLoading = true.obs;
  var selectedProjectCategory = 'All'.obs;

  @override
  void onInit() {
    super.onInit();
    loadPortfolioData();
  }

  void loadPortfolioData() {
    isLoading.value = true;

    Future.delayed(const Duration(milliseconds: 500), () {
      personalInfo.value = PortfolioService.getPersonalInfo();
      projects.value = PortfolioService.getProjects();
      skills.value = PortfolioService.getSkills();
      experiences.value = PortfolioService.getExperiences();
      isLoading.value = false;
    });
  }

  List<Project> get filteredProjects {
    if (selectedProjectCategory.value == 'All') {
      return projects;
    }
    return projects
        .where((project) => project.category == selectedProjectCategory.value)
        .toList();
  }

  List<String> get projectCategories {
    Set<String> categories = {'All'};
    categories.addAll(projects.map((project) => project.category).toSet());
    return categories.toList();
  }

  void selectProjectCategory(String category) {
    selectedProjectCategory.value = category;
  }

  List<Skill> getSkillsByCategory(String category) {
    return skills.where((skill) => skill.category == category).toList();
  }

  List<String> get skillCategories {
    return skills.map((skill) => skill.category).toSet().toList();
  }
}
