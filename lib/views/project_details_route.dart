import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/portfolio_controller.dart';
import 'project_details_view.dart';

class ProjectDetailsRoute extends StatelessWidget {
  const ProjectDetailsRoute({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PortfolioController>();
    final projectId = Get.parameters['id'];

    if (projectId == null) {
      return const Scaffold(
        body: Center(child: Text('Project id is missing.')),
      );
    }

    return Obx(() {
      if (controller.isLoading.value) {
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      }

      final project =
          controller.projects.firstWhereOrNull((p) => p.id == projectId);

      if (project == null) {
        return const Scaffold(
          body: Center(child: Text('Project not found.')),
        );
      }

      return ProjectDetailsView(project: project);
    });
  }
}
