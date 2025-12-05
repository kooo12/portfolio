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
            // Geometric background patterns - wrapped in RepaintBoundary for performance
            // Large circle - top right from center
            RepaintBoundary(
              child: Align(
                alignment: const Alignment(0.2, -0.3),
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
            ),

            // Large circle - bottom left from center
            RepaintBoundary(
              child: Align(
                alignment: const Alignment(-0.3, 0.2),
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
            ),

            // Floating geometric shapes - reduced from 8 to 4 for better performance
            // Positions relative to center using Align
            ...List.generate(4, (index) {
              // Generate sizes between 60 and 120
              final size = 60.0 + (index % 4) * 20.0;
              // Alignment values (x, y) where 0,0 is center, -1,-1 is top-left, 1,1 is bottom-right
              final alignments = [
                const Alignment(-0.4, -0.3), // Top-left from center
                const Alignment(0.4, 0.0), // Right from center
                const Alignment(-0.3, 0.3), // Bottom-left from center
                const Alignment(0.3, -0.2), // Top-right from center
              ];
              final alignment = alignments[index % alignments.length];

              return RepaintBoundary(
                child: Align(
                  alignment: alignment,
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
                      .fadeOut(duration: 2.seconds),
                  // .then(duration: 1.seconds)
                  // .fadeIn(duration: 2.seconds)
                ),
              );
            }),

            // Additional smaller floating particles - reduced from 6 to 3 for better performance
            // Positions relative to center using Align
            ...List.generate(3, (index) {
              final size = 40.0 + (index % 3) * 20.0;
              // Alignment values relative to center
              final alignments = [
                const Alignment(0.0, -0.4), // Top from center
                const Alignment(0.3, 0.15), // Bottom-right from center
                const Alignment(-0.3, 0.25), // Bottom-left from center
              ];
              final alignment = alignments[index % alignments.length];

              return RepaintBoundary(
                child: Align(
                  alignment: alignment,
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
                      .fadeOut(duration: 1.5.seconds),
                  // .then(duration: 0.5.seconds)
                  // .fadeIn(duration: 1.5.seconds)
                ),
              );
            }),

            // Grid pattern overlay - wrapped in RepaintBoundary
            Positioned.fill(
              child: RepaintBoundary(
                child: CustomPaint(
                  painter: GridPainter(
                    color: themeCtrl.activeTheme.dividerColor.withOpacity(0.05),
                  ),
                ),
              ),
            ),

            // Main content
            Center(child: child),
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

    // Optimize: Only draw visible lines
    final maxWidth = size.width;
    final maxHeight = size.height;

    // Vertical lines
    for (double x = 0; x <= maxWidth; x += spacing) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, maxHeight),
        paint,
      );
    }

    // Horizontal lines
    for (double y = 0; y <= maxHeight; y += spacing) {
      canvas.drawLine(
        Offset(0, y),
        Offset(maxWidth, y),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
