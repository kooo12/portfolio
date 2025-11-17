import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:protfolio/utils/app_dimensions.dart';
import '../controllers/portfolio_controller.dart';
import '../models/skill.dart';

class SkillCard extends StatelessWidget {
  SkillCard({
    super.key,
    required this.skill,
    required this.delay,
  });

  final Skill skill;
  final int delay;
  final PortfolioController portfolioController =
      Get.find<PortfolioController>();

  Map<String, dynamic> _getSkillInfo(String skillName) {
    switch (skillName.toLowerCase()) {
      case 'flutter':
        return {
          'primaryColor': const Color(0xFF02569B),
          'secondaryColor': const Color(0xFF13B9FD),
          'accentColor': const Color(0xFF00D4FF),
          'bgGradient': [const Color(0xFF02569B), const Color(0xFF13B9FD)],
          'level': 'Expert',
          'levelColor': const Color(0xFF4CAF50),
          'yearsExp': 3,
          'icon': FontAwesomeIcons.mobileScreen,
          'description': 'Cross-platform mobile development',
          'extraDescription': '',
        };
      case 'dart':
        return {
          'primaryColor': const Color(0xFF00B4AB),
          'secondaryColor': const Color(0xFF01579B),
          'accentColor': const Color(0xFF00E5FF),
          'bgGradient': [const Color(0xFF00B4AB), const Color(0xFF01579B)],
          'level': 'Expert',
          'levelColor': const Color(0xFF4CAF50),
          'yearsExp': 3,
          'icon': FontAwesomeIcons.code,
          'description': 'Modern programming language',
          'extraDescription': '',
        };
      // case 'javascript':
      //   return {
      //     'primaryColor': const Color(0xFFF0DB4F),
      //     'secondaryColor': const Color(0xFF323330),
      //     'accentColor': const Color(0xFFFFF176),
      //     'bgGradient': [const Color(0xFFF0DB4F), const Color(0xFF323330)],
      //     'level': 'Advanced',
      //     'levelColor': const Color(0xFF2196F3),
      //     'yearsExp': 2,
      //     'icon': FontAwesomeIcons.squareJs,
      //     'description': 'Web development & scripting',
      //   };
      // case 'typescript':
      //   return {
      //     'primaryColor': const Color(0xFF3178C6),
      //     'secondaryColor': const Color(0xFF235A97),
      //     'accentColor': const Color(0xFF64B5F6),
      //     'bgGradient': [const Color(0xFF3178C6), const Color(0xFF235A97)],
      //     'level': 'Advanced',
      //     'levelColor': const Color(0xFF2196F3),
      //     'yearsExp': 2,
      //     'icon': FontAwesomeIcons.code,
      //     'description': 'Type-safe JavaScript',
      //   };
      // case 'python':
      //   return {
      //     'primaryColor': const Color(0xFF306998),
      //     'secondaryColor': const Color(0xFFFFD43B),
      //     'accentColor': const Color(0xFF81C784),
      //     'bgGradient': [const Color(0xFF306998), const Color(0xFFFFD43B)],
      //     'level': 'Intermediate',
      //     'levelColor': const Color(0xFFFF9800),
      //     'yearsExp': 1,
      //     'icon': FontAwesomeIcons.python,
      //     'description': 'Data science & automation',
      //   };
      // case 'react':
      //   return {
      //     'primaryColor': const Color(0xFF61DAFB),
      //     'secondaryColor': const Color(0xFF20232A),
      //     'accentColor': const Color(0xFFB3E5FC),
      //     'bgGradient': [const Color(0xFF61DAFB), const Color(0xFF20232A)],
      //     'level': 'Advanced',
      //     'levelColor': const Color(0xFF2196F3),
      //     'yearsExp': 2,
      //     'icon': FontAwesomeIcons.react,
      //     'description': 'Modern UI library',
      //   };
      // case 'node.js':
      //   return {
      //     'primaryColor': const Color(0xFF68A063),
      //     'secondaryColor': const Color(0xFF303030),
      //     'accentColor': const Color(0xFF8BC34A),
      //     'bgGradient': [const Color(0xFF68A063), const Color(0xFF303030)],
      //     'level': 'Advanced',
      //     'levelColor': const Color(0xFF4CAF50),
      //     'yearsExp': 2,
      //     'icon': FontAwesomeIcons.nodeJs,
      //     'description': 'Server-side JavaScript',
      //   };
      case 'firebase':
        return {
          'primaryColor': const Color(0xFFFFCA28),
          'secondaryColor': const Color(0xFFFF6F00),
          'accentColor': const Color(0xFFFFF176),
          'bgGradient': [const Color(0xFFFFCA28), const Color(0xFFFF6F00)],
          'level': 'Intermediate',
          'levelColor': const Color(0xFF4CAF50),
          'yearsExp': 3,
          'icon': FontAwesomeIcons.fire,
          'description': 'Backend-as-a-Service',
          'extraDescription': '',
        };
      case 'rest api':
        return {
          'primaryColor': const Color.fromARGB(255, 24, 255, 51),
          'secondaryColor': const Color.fromARGB(255, 10, 195, 124),
          'accentColor': const Color.fromARGB(255, 118, 250, 255),
          'bgGradient': [
            const Color.fromARGB(255, 40, 255, 90),
            const Color(0xFFFF6F00)
          ],
          'level': 'Intermediate',
          'levelColor': const Color(0xFF4CAF50),
          'yearsExp': 3,
          'icon': FontAwesomeIcons.cloud,
          'description': 'REST API Consumption, JSON Serialization',
          'extraDescription': '',
        };
      case 'git':
        return {
          'primaryColor': const Color(0xFFF05032),
          'secondaryColor': const Color(0xFFB74026),
          'accentColor': const Color(0xFFFF8A65),
          'bgGradient': [const Color(0xFFF05032), const Color(0xFFB74026)],
          'level': 'Advanced',
          'levelColor': const Color(0xFF2196F3),
          'yearsExp': 2,
          'icon': FontAwesomeIcons.gitAlt,
          'description': 'Version control system',
          'extraDescription': '',
        };
      // case 'docker':
      //   return {
      //     'primaryColor': const Color(0xFF2496ED),
      //     'secondaryColor': const Color(0xFF1D72AA),
      //     'accentColor': const Color(0xFF64B5F6),
      //     'bgGradient': [const Color(0xFF2496ED), const Color(0xFF1D72AA)],
      //     'level': 'Intermediate',
      //     'levelColor': const Color(0xFFFF9800),
      //     'yearsExp': 1,
      //     'icon': FontAwesomeIcons.docker,
      //     'description': 'Containerization platform',
      //   };
      case 'aws':
        return {
          'primaryColor': const Color(0xFFFF9900),
          'secondaryColor': const Color(0xFF232F3E),
          'accentColor': const Color(0xFFFFB74D),
          'bgGradient': [const Color(0xFFFF9900), const Color(0xFF232F3E)],
          'level': 'Beginner',
          'levelColor': const Color(0xFFFF9800),
          'yearsExp': 1,
          'icon': FontAwesomeIcons.aws,
          'description': 'Cloud computing platform',
          'extraDescription':
              "Built responsive Flutter applications integrating with MongoDB databases through REST APIs, deployed and managed on AWS cloud infrastructure.\n- Worked with AWS cloud services for application deployment\n- Managed data flow between frontend and database systems"
        };
      case 'mongodb':
        return {
          'primaryColor': const Color(0xFF47A248),
          'secondaryColor': const Color(0xFF3F8F29),
          'accentColor': const Color(0xFF81C784),
          'bgGradient': [const Color(0xFF47A248), const Color(0xFF3F8F29)],
          'level': 'Beginner',
          'levelColor': const Color(0xFF4CAF50),
          'yearsExp': 2,
          'icon': FontAwesomeIcons.database,
          'description':
              'NoSQL database, Integrated with MongoDB databases via REST API endpoints',
          'extraDescription':
              "Built responsive Flutter applications integrating with MongoDB databases through REST APIs, deployed and managed on AWS cloud infrastructure.\n- Integrated with MongoDB databases via REST API endpoints\n- Handled data serialization/deserialization between Flutter and MongoDB"
        };
      default:
        return {
          'primaryColor': const Color(0xFF6366F1),
          'secondaryColor': const Color(0xFF8B5CF6),
          'accentColor': const Color(0xFF9C27B0),
          'bgGradient': [const Color(0xFF6366F1), const Color(0xFF8B5CF6)],
          'level': 'Learning',
          'levelColor': const Color(0xFF757575),
          'yearsExp': 0,
          'icon': FontAwesomeIcons.code,
          'description': 'Currently learning',
          'extraDescription': '',
        };
    }
  }

  @override
  Widget build(BuildContext context) {
    final skillInfo = _getSkillInfo(skill.name);
    final primaryColor = skillInfo['primaryColor'] as Color;
    final accentColor = skillInfo['accentColor'] as Color;
    final icon = skillInfo['icon'] as IconData;
    final isMobile =
        MediaQuery.of(context).size.width < AppDimensions.mobileBreakpoint;
    final baseColor = Theme.of(context).cardColor.withOpacity(0.05);
    final hoverColor = primaryColor.withOpacity(0.18);

    return MouseRegion(
      onEnter: (_) => portfolioController.setHoveredSkill(skill.name),
      onExit: (_) => portfolioController.setHoveredSkill(null),
      child: GestureDetector(
        onTap: () => _showSkillDetails(context, skill),
        child: Obx(() {
          final isHovered =
              isMobile ? true : portfolioController.isSkillHovered(skill.name);
          final showLabel = isHovered;

          return AnimatedScale(
            scale: isHovered ? 1.04 : 1.0,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOutBack,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOut,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isHovered ? hoverColor : baseColor,
                borderRadius: BorderRadius.circular(AppDimensions.radiusL),
                border: Border.all(
                  color: isHovered
                      ? primaryColor.withOpacity(0.7)
                      : Colors.white.withOpacity(0.05),
                  width: 1.2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: isHovered ? 22 : 10,
                    offset: Offset(0, isHovered ? 16 : 8),
                  ),
                  if (isHovered)
                    BoxShadow(
                      color: accentColor.withOpacity(0.45),
                      blurRadius: 30,
                      spreadRadius: 6,
                    ),
                ],
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: FaIcon(
                      icon,
                      size: isMobile ? 28 : 34,
                      color: Colors.white,
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: AnimatedSlide(
                      duration: const Duration(milliseconds: 220),
                      offset: showLabel ? Offset.zero : const Offset(0, -0.2),
                      curve: Curves.easeOut,
                      child: AnimatedOpacity(
                        opacity: showLabel ? 1 : 0,
                        duration: const Duration(milliseconds: 200),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(999),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Text(
                            skill.name,
                            style: TextStyle(
                              color: primaryColor.darken(),
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.4,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    )
        .animate()
        .fadeIn(duration: 700.ms, delay: delay.ms)
        .slideY(begin: 0.2, curve: Curves.easeOutBack);
  }

  void _showSkillDetails(BuildContext context, Skill skill) {
    final skillInfo = _getSkillInfo(skill.name);
    final primaryColor = skillInfo['primaryColor'] as Color;
    final accentColor = skillInfo['accentColor'] as Color;
    final levelColor = skillInfo['levelColor'] as Color;
    final years = skillInfo['yearsExp'] as int;
    final description = skillInfo['description'] as String;
    final extraDescription = skillInfo['extraDescription'] as String;

    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width > 600
                ? 500
                : MediaQuery.of(context).size.width * 0.9,
            maxHeight: MediaQuery.of(context).size.height * 0.8,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                primaryColor.withOpacity(0.05),
                primaryColor.withOpacity(0.02),
                const Color.fromARGB(255, 156, 156, 156),
              ],
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          padding:
              EdgeInsets.all(MediaQuery.of(context).size.width > 600 ? 32 : 20),
          child: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header with icon and title
                    Container(
                      width: MediaQuery.of(context).size.width > 600 ? 80 : 60,
                      height: MediaQuery.of(context).size.width > 600 ? 80 : 60,
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                          colors: [primaryColor, primaryColor.withOpacity(0.8)],
                        ),
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: primaryColor.withOpacity(0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Center(
                        child: FaIcon(
                          skillInfo['icon'] as IconData,
                          color: Colors.white,
                          size:
                              MediaQuery.of(context).size.width > 600 ? 36 : 28,
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Skill name with gradient
                    ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        colors: [primaryColor, accentColor],
                      ).createShader(bounds),
                      child: Text(
                        skill.name,
                        style: TextStyle(
                          fontSize:
                              MediaQuery.of(context).size.width > 600 ? 28 : 24,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Description
                    Text(
                      description,
                      style: TextStyle(
                        fontSize:
                            MediaQuery.of(context).size.width > 600 ? 16 : 14,
                        color: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.color
                            ?.withOpacity(0.7),
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    // Level badge
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal:
                            MediaQuery.of(context).size.width > 600 ? 16 : 12,
                        vertical:
                            MediaQuery.of(context).size.width > 600 ? 8 : 6,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [levelColor, levelColor.withOpacity(0.8)]),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        skillInfo['level'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize:
                              MediaQuery.of(context).size.width > 600 ? 14 : 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Skill details grid
                    Container(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.width > 600 ? 20 : 16),
                      decoration: BoxDecoration(
                        color: primaryColor.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: primaryColor.withOpacity(0.1),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Progress section
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Proficiency',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.color,
                                ),
                              ),
                              Text(
                                '${skill.proficiency}%',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 8),

                          // Progress bar
                          Container(
                            height: 8,
                            decoration: BoxDecoration(
                              color: primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: skill.proficiency / 100,
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [primaryColor, accentColor]),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Experience
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Experience',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.color,
                                ),
                              ),
                              Text(
                                years > 0
                                    ? '$years+ ${years == 1 ? 'Year' : 'Years'}'
                                    : 'Learning',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),

                          // Description
                          extraDescription.isNotEmpty
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      Text(
                                        'Description',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.color,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        extraDescription,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w800,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ])
                              : const SizedBox.shrink(),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Close button
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient:
                            LinearGradient(colors: [primaryColor, accentColor]),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Close',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}

extension on Color {
  Color darken([double amount = .2]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }
}
