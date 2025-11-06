import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  final ScrollController scrollController = ScrollController();

  var currentIndex = 0.obs;
  var isScrolling = false.obs;

  GlobalKey? heroKey;
  GlobalKey? aboutKey;
  GlobalKey? skillsKey;
  GlobalKey? experienceKey;
  GlobalKey? projectsKey;
  GlobalKey? contactKey;

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_onScroll);
  }

  @override
  void onClose() {
    scrollController.removeListener(_onScroll);
    super.onClose();
  }

  void setSectionKeys({
    GlobalKey? hero,
    GlobalKey? about,
    GlobalKey? skills,
    GlobalKey? experience,
    GlobalKey? projects,
    GlobalKey? contact,
  }) {
    heroKey = hero;
    aboutKey = about;
    skillsKey = skills;
    experienceKey = experience;
    projectsKey = projects;
    contactKey = contact;
  }

  void _onScroll() {
    if (isScrolling.value) return;

    final context = scrollController.position.context.notificationContext;
    if (context == null) return;

    final sections = [
      (heroKey, 0),
      (aboutKey, 1),
      (skillsKey, 2),
      (experienceKey, 3),
      (projectsKey, 4),
      (contactKey, 5),
    ];

    final viewportHeight = MediaQuery.of(context).size.height;
    const headerOffset = 100.0;
    int newIndex = 0;

    double closestDistance = double.infinity;

    for (final (key, index) in sections) {
      if (key?.currentContext != null) {
        final RenderBox? renderBox =
            key!.currentContext!.findRenderObject() as RenderBox?;

        if (renderBox != null) {
          final position = renderBox.localToGlobal(Offset.zero);
          final sectionTop = position.dy;
          final sectionHeight = renderBox.size.height;
          final sectionBottom = sectionTop + sectionHeight;

          final isVisible = sectionTop < viewportHeight && sectionBottom > 0;

          if (isVisible) {
            final distance = (sectionTop - headerOffset).abs();

            if (index == 0 || index == 1 || index == 2) {
              final sectionNames = ['Hero', 'About', 'Skills'];
              debugPrint(
                  '${sectionNames[index]} - Top: ${sectionTop.toStringAsFixed(1)}, '
                  'Distance: ${distance.toStringAsFixed(1)}, '
                  'Visible: $isVisible');
            }

            if (distance < closestDistance) {
              closestDistance = distance;
              newIndex = index;
            }
          }
        }
      }
    }

    if (newIndex != currentIndex.value) {
      debugPrint(
          'Switching to section: $newIndex (distance: ${closestDistance.toStringAsFixed(1)})');
      currentIndex.value = newIndex;
    }
  }

  void changeIndex(int index) {
    currentIndex.value = index;
  }

  void scrollToSection(int index) {
    changeIndex(index);
    isScrolling.value = true;

    GlobalKey? targetKey;
    switch (index) {
      case 0:
        targetKey = heroKey;
        break;
      case 1:
        targetKey = aboutKey;
        break;
      case 2:
        targetKey = skillsKey;
        break;
      case 3:
        targetKey = experienceKey;
        break;
      case 4:
        targetKey = projectsKey;
        break;
      case 5:
        targetKey = contactKey;
        break;
    }

    if (targetKey?.currentContext != null) {
      Scrollable.ensureVisible(
        targetKey!.currentContext!,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        alignment: 0.1, // Offset for header
      );
    }

    Future.delayed(const Duration(milliseconds: 600), () {
      isScrolling.value = false;
    });
  }
}
