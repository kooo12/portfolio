import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:protfolio/controllers/theme_controller.dart';
import '../utils/app_colors.dart';

class AnimatedBackground extends StatelessWidget {
  final Widget child;

  const AnimatedBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final themeCtrl = Get.find<ThemeController>();
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              themeCtrl.activeTheme.scaffoldBackgroundColor,
              themeCtrl.activeTheme.scaffoldBackgroundColor.withOpacity(0.8),
              themeCtrl.activeTheme.scaffoldBackgroundColor,
            ],
          ),
        ),
        child: Stack(
          children: [
            // Geometric background patterns
            Positioned(
              top: -100,
              right: -100,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.primaryLight.withOpacity(0.1),
                      AppColors.primaryLight.withOpacity(0.05),
                      Colors.transparent,
                    ],
                  ),
                ),
              )
                  .animate(onPlay: (controller) => controller.repeat())
                  .rotate(duration: 20.seconds)
                  .fadeIn(duration: 2.seconds),
            ),

            Positioned(
              bottom: -150,
              left: -150,
              child: Container(
                width: 400,
                height: 400,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.secondaryLight.withOpacity(0.08),
                      AppColors.secondaryLight.withOpacity(0.03),
                      Colors.transparent,
                    ],
                  ),
                ),
              )
                  .animate(onPlay: (controller) => controller.repeat())
                  .rotate(
                    duration: 25.seconds,
                  )
                  .fadeIn(duration: 2.seconds, delay: 500.ms),
            ),

            // Floating geometric shapes with various sizes and positions
            ...List.generate(8, (index) {
              // Generate sizes between 60 and 120
              final size = 60.0 + (index % 4) * 20.0;
              // Fixed positions to ensure visibility
              final positions = [
                const Offset(100, 200),
                const Offset(300, 150),
                const Offset(500, 300),
                const Offset(200, 400),
                const Offset(400, 100),
                const Offset(600, 250),
                const Offset(150, 350),
                const Offset(350, 500),
              ];
              final position = positions[index % positions.length];

              return Positioned(
                  top: position.dy,
                  left: position.dx,
                  child: Container(
                    width: size,
                    height: size,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          AppColors.accentLight.withOpacity(0.4),
                          AppColors.primaryLight.withOpacity(0.3),
                          AppColors.secondaryLight.withOpacity(0.2),
                          Colors.transparent,
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.accentLight.withOpacity(0.3),
                          blurRadius: 20,
                          spreadRadius: 3,
                        ),
                      ],
                    ),
                  )
                      .animate(onPlay: (controller) => controller.repeat())
                      .fadeIn(duration: 2.seconds, delay: (index * 300).ms)
                      .move(
                        duration: 4.seconds,
                        begin: const Offset(0, 0),
                        end: Offset(
                          (index % 2 == 0) ? 30 : -30,
                          (index % 3 == 0) ? -20 : 20,
                        ),
                        curve: Curves.easeInOut,
                      )
                      .then()
                      .move(
                        duration: 4.seconds,
                        begin: Offset(
                          (index % 2 == 0) ? 30 : -30,
                          (index % 3 == 0) ? -20 : 20,
                        ),
                        end: const Offset(0, 0),
                        curve: Curves.easeInOut,
                      )
                      .scale(
                        duration: 3.seconds,
                        begin: const Offset(1.0, 1.0),
                        end: const Offset(1.1, 1.1),
                        curve: Curves.easeInOut,
                      )
                      .then()
                      .scale(
                        duration: 3.seconds,
                        begin: const Offset(1.1, 1.1),
                        end: const Offset(1.0, 1.0),
                        curve: Curves.easeInOut,
                      )
                      .fadeOut(duration: 2.seconds)
                  // .then(duration: 1.seconds)
                  // .fadeIn(duration: 2.seconds),
                  );
            }),

            // Additional smaller floating particles
            ...List.generate(6, (index) {
              final size = 40.0 + (index % 3) * 20.0;
              // Fixed positions for smaller particles
              final positions = [
                const Offset(250, 300),
                const Offset(450, 200),
                const Offset(350, 450),
                const Offset(150, 250),
                const Offset(500, 350),
                const Offset(200, 150),
              ];
              final position = positions[index % positions.length];

              return Positioned(
                  top: position.dy,
                  left: position.dx,
                  child: Container(
                    width: size,
                    height: size,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          AppColors.primaryLight.withOpacity(0.6),
                          AppColors.secondaryLight.withOpacity(0.4),
                          AppColors.accentLight.withOpacity(0.2),
                          Colors.transparent,
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryLight.withOpacity(0.4),
                          blurRadius: 25,
                          spreadRadius: 4,
                        ),
                        BoxShadow(
                          color: AppColors.secondaryLight.withOpacity(0.3),
                          blurRadius: 15,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                  )
                      .animate(onPlay: (controller) => controller.repeat())
                      .fadeIn(duration: 2.seconds, delay: (index * 400).ms)
                      .rotate(
                        duration: 8.seconds,
                        curve: Curves.linear,
                      )
                      .move(
                        duration: 5.seconds,
                        begin: const Offset(0, 0),
                        end: Offset(
                          (index % 3 == 0) ? 40 : -40,
                          (index % 2 == 0) ? -25 : 25,
                        ),
                        curve: Curves.easeInOut,
                      )
                      .then()
                      .move(
                        duration: 5.seconds,
                        begin: Offset(
                          (index % 3 == 0) ? 40 : -40,
                          (index % 2 == 0) ? -25 : 25,
                        ),
                        end: const Offset(0, 0),
                        curve: Curves.easeInOut,
                      )
                      .scale(
                        duration: 4.seconds,
                        begin: const Offset(0.9, 0.9),
                        end: const Offset(1.1, 1.1),
                        curve: Curves.easeInOut,
                      )
                      .then()
                      .scale(
                        duration: 4.seconds,
                        begin: const Offset(1.1, 1.1),
                        end: const Offset(0.9, 0.9),
                        curve: Curves.easeInOut,
                      )
                      .fadeOut(duration: 1.5.seconds)
                  // .then(duration: 0.5.seconds)
                  // .fadeIn(duration: 1.5.seconds),
                  );
            }),

            // Grid pattern overlay
            Positioned.fill(
              child: CustomPaint(
                painter: GridPainter(
                  color: themeCtrl.activeTheme.dividerColor.withOpacity(0.05),
                ),
              ),
            ),

            // Main content
            child,
          ],
        ),
      ),
    );
  }
}

class GridPainter extends CustomPainter {
  final Color color;

  GridPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.0;

    const spacing = 50.0;

    // Vertical lines
    for (double x = 0; x <= size.width; x += spacing) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        paint,
      );
    }

    // Horizontal lines
    for (double y = 0; y <= size.height; y += spacing) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
