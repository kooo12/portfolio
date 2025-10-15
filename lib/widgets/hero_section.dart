import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:protfolio/controllers/navigation_controller.dart';
import 'package:protfolio/controllers/theme_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/personal_info.dart';
import '../utils/app_colors.dart';
import '../utils/app_dimensions.dart';

class HeroSection extends StatelessWidget {
  final PersonalInfo personalInfo;
  final GlobalKey contactKey;
  final ScrollController scrollController;

  const HeroSection({
    super.key,
    required this.personalInfo,
    required this.contactKey,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          const BoxConstraints(maxWidth: AppDimensions.containerMaxWidth),
      margin: const EdgeInsets.symmetric(
          horizontal: AppDimensions.containerPadding),
      padding: const EdgeInsets.symmetric(vertical: AppDimensions.spacingXXXL),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > AppDimensions.tabletBreakpoint) {
            return _buildDesktopLayout(context);
          } else {
            return _buildMobileLayout(context);
          }
        },
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    final themeCtrl = Get.find<ThemeController>();
    return Obx(
      () => Row(
        children: [
          // Left side - Text content
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Greeting
                Text(
                  'Hello, I\'m',
                  style: themeCtrl.activeTheme.textTheme.headlineMedium
                      ?.copyWith(
                          color: themeCtrl
                              .activeTheme.textTheme.bodyLarge?.color
                              ?.withOpacity(0.7),
                          fontSize: 20),
                )
                    .animate()
                    .fadeIn(duration: 800.ms, curve: Curves.easeOut)
                    .slideY(begin: -0.3, curve: Curves.easeOutBack)
                    .scale(
                        begin: const Offset(0.8, 0.8),
                        curve: Curves.easeOutBack),

                const SizedBox(height: AppDimensions.spacingS),

                // Name with Gradient Background
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.spacingL,
                    vertical: AppDimensions.spacingM,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        const Color(0xFF6366F1)
                            .withOpacity(themeCtrl.isDarkMode ? 0.3 : 0.1),
                        const Color(0xFF8B5CF6)
                            .withOpacity(themeCtrl.isDarkMode ? 0.3 : 0.1),
                        const Color(0xFFEC4899)
                            .withOpacity(themeCtrl.isDarkMode ? 0.3 : 0.1),
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.2, 0.5, 0.8, 1.0],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryLight.withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Text(
                    personalInfo.name,
                    style: themeCtrl.activeTheme.textTheme.displayLarge
                        ?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 50),
                  ),
                )
                    .animate()
                    .fadeIn(
                        duration: 1000.ms, delay: 300.ms, curve: Curves.easeOut)
                    .slideY(begin: -0.4, curve: Curves.easeOutBack)
                    .scale(
                        begin: const Offset(0.6, 0.6),
                        curve: Curves.easeOutBack)
                    .shimmer(
                        duration: 2000.ms,
                        delay: 800.ms,
                        color: Colors.white.withOpacity(0.3)),

                const SizedBox(height: AppDimensions.spacingM),

                // Title
                Text(
                  personalInfo.title,
                  style: themeCtrl.activeTheme.textTheme.headlineMedium
                      ?.copyWith(
                          color: AppColors.primaryLight,
                          fontWeight: FontWeight.w600,
                          fontSize: 30),
                )
                    .animate()
                    .fadeIn(duration: 800.ms, delay: 400.ms)
                    .slideY(begin: -0.2),

                const SizedBox(height: AppDimensions.spacingL),

                // Bio
                Text(
                  personalInfo.bio,
                  style: themeCtrl.activeTheme.textTheme.bodyLarge?.copyWith(
                    height: 1.6,
                    color: themeCtrl.activeTheme.textTheme.bodyLarge?.color
                        ?.withOpacity(0.8),
                  ),
                )
                    .animate()
                    .fadeIn(duration: 800.ms, delay: 600.ms)
                    .slideY(begin: -0.2),

                const SizedBox(height: AppDimensions.spacingXL),

                // CTA Buttons
                Row(
                  children: [
                    _buildPrimaryButton(context),
                    const SizedBox(width: AppDimensions.spacingM),
                    _buildSecondaryButton(context),
                  ],
                )
                    .animate()
                    .fadeIn(duration: 800.ms, delay: 800.ms)
                    .slideY(begin: -0.2),

                const SizedBox(height: AppDimensions.spacingXL),

                // Social Links
                _buildSocialLinks(context)
                    .animate()
                    .fadeIn(duration: 800.ms, delay: 1000.ms)
                    .slideY(begin: -0.2),
              ],
            ),
          ),

          const SizedBox(width: AppDimensions.spacingXXXL),

          // Right side - Profile Image
          Expanded(
            flex: 1,
            child: Center(
              child: Container(
                width: 400,
                height: 400,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: AppColors.primaryGradient,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryLight.withOpacity(0.3),
                      blurRadius: 50,
                      offset: const Offset(0, 20),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(personalInfo.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              )
                  .animate()
                  .fadeIn(
                      duration: 1200.ms, delay: 500.ms, curve: Curves.easeOut)
                  .scale(
                      begin: const Offset(0.3, 0.3), curve: Curves.easeOutBack)
                  .rotate(
                      begin: -0.1,
                      end: 0,
                      duration: 1000.ms,
                      curve: Curves.easeOut)
                  .then(delay: 200.ms)
                  .shimmer(
                      duration: 1500.ms,
                      color: AppColors.primaryLight.withOpacity(0.2)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    final themeCtrl = Get.find<ThemeController>();
    return Column(
      children: [
        // Profile Image
        Container(
          width: 250,
          height: 250,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: AppColors.primaryGradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryLight.withOpacity(0.3),
                blurRadius: 50,
                offset: const Offset(0, 20),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(personalInfo.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        )
            .animate()
            .fadeIn(duration: 1000.ms)
            .scale(begin: const Offset(0.8, 0.8)),

        const SizedBox(height: AppDimensions.spacingXL),

        // Text content
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Greeting
            Text(
              'Hello, I\'m',
              style: themeCtrl.activeTheme.textTheme.headlineMedium?.copyWith(
                  color: themeCtrl.activeTheme.textTheme.bodyLarge?.color
                      ?.withOpacity(0.7),
                  fontSize: 20),
              textAlign: TextAlign.center,
            )
                .animate()
                .fadeIn(duration: 600.ms, delay: 200.ms)
                .slideY(begin: -0.2),

            const SizedBox(height: AppDimensions.spacingS),

            // Name with Gradient Background
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.spacingL,
                  vertical: AppDimensions.spacingM,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      const Color(0xFF6366F1)
                          .withOpacity(themeCtrl.isDarkMode ? 0.3 : 0.1),
                      const Color(0xFF8B5CF6)
                          .withOpacity(themeCtrl.isDarkMode ? 0.3 : 0.1),
                      const Color(0xFFEC4899)
                          .withOpacity(themeCtrl.isDarkMode ? 0.3 : 0.1),
                      Colors.transparent,
                    ],
                    stops: const [0.0, 0.2, 0.5, 0.8, 1.0],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryLight.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Text(
                  personalInfo.name,
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
            )
                .animate()
                .fadeIn(duration: 800.ms, delay: 400.ms)
                .slideY(begin: -0.2),

            const SizedBox(height: AppDimensions.spacingM),

            // Title
            Text(
              personalInfo.title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppColors.primaryLight,
                    fontWeight: FontWeight.w600,
                  ),
              textAlign: TextAlign.center,
            )
                .animate()
                .fadeIn(duration: 800.ms, delay: 600.ms)
                .slideY(begin: -0.2),

            const SizedBox(height: AppDimensions.spacingL),

            // Bio
            Text(
              personalInfo.bio,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    height: 1.6,
                    color: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.color
                        ?.withOpacity(0.8),
                  ),
              textAlign: TextAlign.center,
            )
                .animate()
                .fadeIn(duration: 800.ms, delay: 800.ms)
                .slideY(begin: -0.2),

            const SizedBox(height: AppDimensions.spacingXL),

            // CTA Buttons
            Column(
              children: [
                _buildPrimaryButton(context),
                const SizedBox(height: AppDimensions.spacingM),
                _buildSecondaryButton(context),
              ],
            )
                .animate()
                .fadeIn(duration: 800.ms, delay: 1000.ms)
                .slideY(begin: -0.2),

            const SizedBox(height: AppDimensions.spacingXL),

            // Social Links
            _buildSocialLinks(context)
                .animate()
                .fadeIn(duration: 800.ms, delay: 1200.ms)
                .slideY(begin: -0.2),
          ],
        ),
      ],
    );
  }

  Widget _buildPrimaryButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _launchUrl(personalInfo.resumeUrl),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryLight,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        ),
        elevation: 0,
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(FontAwesomeIcons.download),
          SizedBox(width: AppDimensions.spacingS),
          Text('Download Resume'),
        ],
      ),
    );
  }

  Widget _buildSecondaryButton(BuildContext context) {
    final navigationCtrl = Get.find<NavigationController>();
    return OutlinedButton(
      onPressed: () => _scrollToContact(navigationCtrl, 5),
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primaryLight,
        side: const BorderSide(color: AppColors.primaryLight),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        ),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(FontAwesomeIcons.envelope),
          SizedBox(width: AppDimensions.spacingS),
          Text('Get In Touch'),
        ],
      ),
    );
  }

  Widget _buildSocialLinks(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildSocialIcon(
            FontAwesomeIcons.github, personalInfo.socialLinks['github']!),
        const SizedBox(width: AppDimensions.spacingM),
        _buildSocialIcon(
            FontAwesomeIcons.linkedin, personalInfo.socialLinks['linkedin']!),
        const SizedBox(width: AppDimensions.spacingM),
        _buildSocialIcon(
            FontAwesomeIcons.xTwitter, personalInfo.socialLinks['twitter']!),
        const SizedBox(width: AppDimensions.spacingM),
        _buildSocialIcon(
            FontAwesomeIcons.instagram, personalInfo.socialLinks['instagram']!),
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon, String url) {
    final themeCtrl = Get.find<ThemeController>();
    return GestureDetector(
      onTap: () => _launchUrl(url),
      child: Obx(
        () => Container(
          padding: const EdgeInsets.all(AppDimensions.spacingM),
          decoration: BoxDecoration(
            color:
                themeCtrl.isDarkMode ? AppColors.cardDark : AppColors.cardLight,
            borderRadius: BorderRadius.circular(AppDimensions.radiusL),
            border: Border.all(
              color: themeCtrl.activeTheme.dividerColor.withOpacity(0.2),
            ),
          ),
          child: Icon(
            icon,
            color: themeCtrl.isDarkMode ? AppColors.light : AppColors.dark,
            size: 20,
          ),
        ),
      ),
    );
  }

  void _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  void _scrollToContact(NavigationController navigationCtrl, int index) {
    navigationCtrl.changeIndex(index);

    GlobalKey targetKey = contactKey;

    final RenderBox? renderBox =
        targetKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      final position = renderBox.localToGlobal(Offset.zero);
      final scrollOffset =
          scrollController.offset + position.dy - AppDimensions.headerHeight;

      scrollController.animateTo(
        scrollOffset,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }
}
