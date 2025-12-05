import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../utils/app_colors.dart';
import '../utils/app_dimensions.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          const BoxConstraints(maxWidth: AppDimensions.containerMaxWidth),
      margin: const EdgeInsets.symmetric(
          horizontal: AppDimensions.containerPadding),
      padding: const EdgeInsets.symmetric(vertical: AppDimensions.spacingXXXL),
      child: Column(
        children: [
          // Footer Content
          // LayoutBuilder(
          //   builder: (context, constraints) {
          //     if (constraints.maxWidth > AppDimensions.tabletBreakpoint) {
          //       return _buildDesktopFooter(context);
          //     } else {
          //       return _buildMobileFooter(context);
          //     }
          //   },
          // ),

          // const SizedBox(height: AppDimensions.spacingXXXL),

          // // Divider
          // Container(
          //   height: 1,
          //   color: Theme.of(context).dividerColor.withOpacity(0.2),
          // ),

          const SizedBox(height: AppDimensions.spacingXL),

          // Copyright
          Text(
            '© 2025 Portfolio. Built with Flutter and GetX.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.color
                      ?.withOpacity(0.6),
                ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2),
        ],
      ),
    );
  }

  Widget _buildDesktopFooter(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left - Brand Info
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Portfolio',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryLight,
                    ),
              ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.2),

              const SizedBox(height: AppDimensions.spacingL),

              Text(
                'A passionate Flutter developer creating beautiful, responsive applications for web and mobile platforms.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.color
                          ?.withOpacity(0.7),
                      height: 1.6,
                    ),
              )
                  .animate()
                  .fadeIn(duration: 600.ms, delay: 200.ms)
                  .slideY(begin: -0.2),

              const SizedBox(height: AppDimensions.spacingXL),

              // Social Links
              Row(
                children: [
                  _buildSocialIcon(context, FontAwesomeIcons.github,
                      'https://github.com/kooo12'),
                  const SizedBox(width: AppDimensions.spacingM),
                  _buildSocialIcon(context, FontAwesomeIcons.linkedin,
                      'https://www.linkedin.com/in/aung-ko-oo-042342242/'),
                  const SizedBox(width: AppDimensions.spacingM),
                  _buildSocialIcon(context, FontAwesomeIcons.telegram,
                      'https://t.me/kooo2109'),
                  const SizedBox(width: AppDimensions.spacingM),
                  _buildSocialIcon(context, FontAwesomeIcons.facebook,
                      'https://facebook.com/kooo1210'),
                ],
              )
                  .animate()
                  .fadeIn(duration: 600.ms, delay: 400.ms)
                  .slideY(begin: -0.2),
            ],
          ),
        ),

        const SizedBox(width: AppDimensions.spacingXXXL),

        // Right - Quick Links
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Quick Links',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              )
                  .animate()
                  .fadeIn(duration: 600.ms, delay: 200.ms)
                  .slideY(begin: -0.2),
              const SizedBox(height: AppDimensions.spacingL),
              _buildFooterLink(context, 'About', () {})
                  .animate()
                  .fadeIn(duration: 600.ms, delay: 300.ms)
                  .slideY(begin: -0.2),
              _buildFooterLink(context, 'Skills', () {})
                  .animate()
                  .fadeIn(duration: 600.ms, delay: 400.ms)
                  .slideY(begin: -0.2),
              _buildFooterLink(context, 'Projects', () {})
                  .animate()
                  .fadeIn(duration: 600.ms, delay: 500.ms)
                  .slideY(begin: -0.2),
              _buildFooterLink(context, 'Contact', () {})
                  .animate()
                  .fadeIn(duration: 600.ms, delay: 600.ms)
                  .slideY(begin: -0.2),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMobileFooter(BuildContext context) {
    return Column(
      children: [
        // Brand Info
        Text(
          'Portfolio',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primaryLight,
              ),
        ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.2),

        const SizedBox(height: AppDimensions.spacingL),

        Text(
          'A passionate Flutter developer creating beautiful, responsive applications for web and mobile platforms.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.color
                    ?.withOpacity(0.7),
                height: 1.6,
              ),
          textAlign: TextAlign.center,
        ).animate().fadeIn(duration: 600.ms, delay: 200.ms).slideY(begin: -0.2),

        const SizedBox(height: AppDimensions.spacingXL),

        // Social Links
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSocialIcon(
                context, FontAwesomeIcons.github, 'https://github.com/kooo12'),
            const SizedBox(width: AppDimensions.spacingM),
            _buildSocialIcon(context, FontAwesomeIcons.linkedin,
                'https://www.linkedin.com/in/aung-ko-oo-042342242/'),
            const SizedBox(width: AppDimensions.spacingM),
            _buildSocialIcon(
                context, FontAwesomeIcons.telegram, 'https://t.me/kooo2109'),
            const SizedBox(width: AppDimensions.spacingM),
            _buildSocialIcon(context, FontAwesomeIcons.facebook,
                'https://facebook.com/kooo1210'),
          ],
        ).animate().fadeIn(duration: 600.ms, delay: 400.ms).slideY(begin: -0.2),

        const SizedBox(height: AppDimensions.spacingXXXL),

        // Quick Links
        Text(
          'Quick Links',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ).animate().fadeIn(duration: 600.ms, delay: 500.ms).slideY(begin: -0.2),

        const SizedBox(height: AppDimensions.spacingL),

        Wrap(
          spacing: AppDimensions.spacingM,
          runSpacing: AppDimensions.spacingM,
          alignment: WrapAlignment.center,
          children: [
            _buildFooterLink(context, 'About', () {})
                .animate()
                .fadeIn(duration: 600.ms, delay: 600.ms)
                .slideY(begin: -0.2),
            _buildFooterLink(context, 'Skills', () {})
                .animate()
                .fadeIn(duration: 600.ms, delay: 700.ms)
                .slideY(begin: -0.2),
            _buildFooterLink(context, 'Projects', () {})
                .animate()
                .fadeIn(duration: 600.ms, delay: 800.ms)
                .slideY(begin: -0.2),
            _buildFooterLink(context, 'Contact', () {})
                .animate()
                .fadeIn(duration: 600.ms, delay: 900.ms)
                .slideY(begin: -0.2),
          ],
        ),
      ],
    );
  }

  Widget _buildFooterLink(
      BuildContext context, String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.color
                  ?.withOpacity(0.7),
              fontWeight: FontWeight.w500,
            ),
      ),
    );
  }

  Widget _buildSocialIcon(BuildContext context, IconData icon, String url) {
    return GestureDetector(
      onTap: () {
        // Handle social link tap
      },
      child: Container(
        padding: const EdgeInsets.all(AppDimensions.spacingM),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(AppDimensions.radiusL),
          border: Border.all(
            color: Theme.of(context).dividerColor.withOpacity(0.2),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(
          icon,
          color: Theme.of(context).textTheme.bodyLarge?.color,
          size: 20,
        ),
      ),
    );
  }
}
