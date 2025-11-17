import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/app_colors.dart';
import '../utils/app_dimensions.dart';

class AnimatedLoading extends StatefulWidget {
  const AnimatedLoading({super.key});

  @override
  State<AnimatedLoading> createState() => _AnimatedLoadingState();
}

class _AnimatedLoadingState extends State<AnimatedLoading>
    with SingleTickerProviderStateMixin {
  static const _headline = "I'M FLUTTER DEVELOPER";
  // static const _subline = "Portfolio preview is warming up";
  static const _caption = "Stay tuned for curated projects";

  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 4200),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final progress = _controller.value;
        return Stack(
          fit: StackFit.expand,
          children: [
            const _AuroraBackdrop(),
            _ForegroundContent(headline: _headline, progress: progress),
          ],
        );
      },
    );
  }
}

class _ForegroundContent extends StatelessWidget {
  const _ForegroundContent({
    required this.headline,
    required this.progress,
  });

  final String headline;
  final double progress;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final caretOpacity = progress % 0.25 > 0.12 ? 0.0 : 1.0;
    final arrowOffset = math.sin(progress * math.pi * 2) * 8;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Text(
            //   "HELLO! I'M",
            //   style: theme.textTheme.labelLarge?.copyWith(
            //     letterSpacing: 6,
            //     color: Colors.white70,
            //   ),
            // ),
            // const SizedBox(height: AppDimensions.spacingS),
            _TypingHeadline(
              text: headline,
              progress: progress,
              caretOpacity: caretOpacity,
            ),
            const SizedBox(height: AppDimensions.spacingL),
            // Text(
            //   _AnimatedLoadingState._subline,
            //   textAlign: TextAlign.center,
            //   style: theme.textTheme.titleMedium?.copyWith(
            //     color: Colors.white,
            //     letterSpacing: 2,
            //     fontWeight: FontWeight.w600,
            //   ),
            // ),
            // const SizedBox(height: AppDimensions.spacingS),
            Text(
              _AnimatedLoadingState._caption,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.white70,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: AppDimensions.spacingXL),
            _SocialRow(progress: progress),
            const SizedBox(height: AppDimensions.spacingXL),
            Transform.translate(
              offset: Offset(0, arrowOffset),
              child: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Colors.white.withOpacity(0.8),
                size: 42,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TypingHeadline extends StatelessWidget {
  const _TypingHeadline({
    required this.text,
    required this.progress,
    required this.caretOpacity,
  });

  final String text;
  final double progress;
  final double caretOpacity;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final letters = text.split('');
    const typingPortion = 0.7;
    const resetPortion = 0.15;
    final typeProgress = progress % 1.0;
    int visibleChars;

    if (typeProgress < typingPortion) {
      final normalized = (typeProgress / typingPortion).clamp(0.0, 1.0);
      visibleChars =
          (normalized * letters.length).clamp(0, letters.length).ceil();
    } else if (typeProgress > (1 - resetPortion)) {
      final fade =
          ((typeProgress - (1 - resetPortion)) / resetPortion).clamp(0.0, 1.0);
      visibleChars = ((1 - fade) * letters.length).floor();
    } else {
      visibleChars = letters.length;
    }

    final typedText = letters.take(visibleChars).join();

    final textStyle = theme.textTheme.displayLarge?.copyWith(
          fontSize: 64,
          fontWeight: FontWeight.w800,
          letterSpacing: 4,
          color: Colors.white,
        ) ??
        const TextStyle(
          fontSize: 64,
          fontWeight: FontWeight.w800,
          letterSpacing: 4,
          color: Colors.white,
        );

    return LayoutBuilder(
      builder: (context, constraints) {
        final measurableText = typedText.isEmpty ? ' ' : typedText;
        final painter = TextPainter(
          text: TextSpan(
            text: measurableText,
            style: textStyle,
          ),
          maxLines: 2,
          textDirection: TextDirection.ltr,
        )..layout(maxWidth: constraints.maxWidth);

        final caretX = typedText.isEmpty ? 0.0 : painter.width;
        final caretHeight = painter.height;

        return Container(
          constraints:
              const BoxConstraints(maxWidth: AppDimensions.tabletBreakpoint),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 28),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                left: caretX,
                top: (painter.height - caretHeight) / 2,
                child: AnimatedOpacity(
                  opacity: caretOpacity,
                  duration: const Duration(milliseconds: 120),
                  child: Container(
                    width: 6,
                    height: 72,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ),
              Text(
                typedText,
                style: textStyle,
                softWrap: true,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SocialRow extends StatelessWidget {
  const _SocialRow({required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    final icons = [
      Icons.facebook,
      FontAwesomeIcons.github,
      FontAwesomeIcons.linkedin,
      FontAwesomeIcons.instagram,
    ];

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < icons.length; i++)
          _SocialDot(
            icon: icons[i],
            delay: i * 0.08,
            progress: progress,
          ),
      ],
    );
  }
}

class _SocialDot extends StatelessWidget {
  const _SocialDot({
    required this.icon,
    required this.delay,
    required this.progress,
  });

  final IconData icon;
  final double delay;
  final double progress;

  @override
  Widget build(BuildContext context) {
    final local = ((progress - delay) / 0.4).clamp(0.0, 1.0);
    final eased = Curves.easeInOut.transform(local);
    final opacity = eased;
    final lift = (1 - eased) * 10;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Opacity(
        opacity: opacity,
        child: Transform.translate(
          offset: Offset(0, lift),
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.08),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
              ),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}

class _AuroraBackdrop extends StatelessWidget {
  const _AuroraBackdrop();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFF02050F),
            AppColors.primaryDark.withOpacity(0.5),
            const Color(0xFF090E1F),
          ],
        ),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: const EdgeInsets.only(top: 80),
              height: 2,
              width: 280,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0),
                    Colors.white.withOpacity(0.4),
                    Colors.white.withOpacity(0),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: -60,
            left: -30,
            child: _GlowBlob(
              size: 240,
              color: AppColors.primaryLight.withOpacity(0.3),
            ),
          ),
          Positioned(
            bottom: 20,
            right: -60,
            child: _GlowBlob(
              size: 320,
              color: const Color(0xFF8B5CF6).withOpacity(0.25),
            ),
          ),
          Positioned.fill(
            child: IgnorePointer(
              ignoring: true,
              child: CustomPaint(
                painter: _LineGridPainter(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GlowBlob extends StatelessWidget {
  const _GlowBlob({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.5),
            blurRadius: 120,
            spreadRadius: 40,
          ),
        ],
      ),
    );
  }
}

class _LineGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.04)
      ..strokeWidth = 1;

    for (double y = size.height * 0.5; y < size.height; y += 24) {
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
