import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:protfolio/controllers/navigation_controller.dart';
import 'package:protfolio/controllers/contact_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/personal_info.dart';
import '../utils/app_colors.dart';
import '../utils/app_dimensions.dart';

class ContactSection extends StatelessWidget {
  final PersonalInfo personalInfo;
  final NavigationController navigationController =
      Get.find<NavigationController>();
  final ContactController contactController = Get.find<ContactController>();

  ContactSection({
    super.key,
    required this.personalInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final tick = navigationController.sectionAnimationTicks[5].value;
      return KeyedSubtree(
        key: ValueKey('contact-section-$tick'),
        child: Container(
          constraints:
              const BoxConstraints(maxWidth: AppDimensions.containerMaxWidth),
          margin: const EdgeInsets.symmetric(
              horizontal: AppDimensions.containerPadding),
          padding:
              const EdgeInsets.symmetric(vertical: AppDimensions.spacingXXL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section Title
              Text(
                'Get In Touch',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.headlineLarge?.color,
                    ),
              ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.2),

              const SizedBox(height: AppDimensions.spacingL),

              Text(
                'I\'m always open to discussing new opportunities and interesting projects',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.color
                          ?.withOpacity(0.7),
                    ),
              )
                  .animate()
                  .fadeIn(duration: 600.ms, delay: 200.ms)
                  .slideY(begin: -0.2),

              const SizedBox(height: AppDimensions.spacingXXXL),

              // Contact Content
              LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth > AppDimensions.tabletBreakpoint) {
                    return _buildDesktopLayout(context);
                  } else {
                    return _buildMobileLayout(context);
                  }
                },
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left side - Contact Info
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildContactInfo(
                context,
                FontAwesomeIcons.envelope,
                'Email',
                personalInfo.email,
                'mailto:${personalInfo.email}',
              )
                  .animate()
                  .fadeIn(duration: 600.ms, delay: 400.ms)
                  .slideX(begin: -0.2),

              const SizedBox(height: AppDimensions.spacingXL),

              _buildContactInfo(
                context,
                FontAwesomeIcons.phone,
                'Phone',
                personalInfo.phone,
                'tel:${personalInfo.phone}',
              )
                  .animate()
                  .fadeIn(duration: 600.ms, delay: 500.ms)
                  .slideX(begin: -0.2),

              const SizedBox(height: AppDimensions.spacingXL),

              _buildContactInfo(
                context,
                FontAwesomeIcons.mapLocation,
                'Location',
                personalInfo.location,
                null,
              )
                  .animate()
                  .fadeIn(duration: 600.ms, delay: 600.ms)
                  .slideX(begin: -0.2),

              const SizedBox(height: AppDimensions.spacingXXXL),

              // Social Links
              Text(
                'Follow Me',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              )
                  .animate()
                  .fadeIn(duration: 600.ms, delay: 700.ms)
                  .slideY(begin: -0.2),

              const SizedBox(height: AppDimensions.spacingL),

              _buildSocialLinks(context)
                  .animate()
                  .fadeIn(duration: 600.ms, delay: 800.ms)
                  .slideY(begin: -0.2),
            ],
          ),
        ),

        const SizedBox(width: AppDimensions.spacingXXXL),

        // Right side - Contact Form
        Expanded(
          flex: 1,
          child: _buildContactForm(context)
              .animate()
              .fadeIn(duration: 800.ms, delay: 400.ms)
              .slideX(begin: 0.2),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Contact Info
        _buildContactInfo(
          context,
          FontAwesomeIcons.envelope,
          'Email',
          personalInfo.email,
          'mailto:${personalInfo.email}',
        ).animate().fadeIn(duration: 600.ms, delay: 400.ms).slideY(begin: -0.2),

        const SizedBox(height: AppDimensions.spacingXL),

        _buildContactInfo(
          context,
          FontAwesomeIcons.phone,
          'Phone',
          personalInfo.phone,
          'tel:${personalInfo.phone}',
        ).animate().fadeIn(duration: 600.ms, delay: 500.ms).slideY(begin: -0.2),

        const SizedBox(height: AppDimensions.spacingXL),

        _buildContactInfo(
          context,
          FontAwesomeIcons.mapPin,
          'Location',
          personalInfo.location,
          null,
        ).animate().fadeIn(duration: 600.ms, delay: 600.ms).slideY(begin: -0.2),

        const SizedBox(height: AppDimensions.spacingXXXL),

        // Social Links
        Text(
          'Follow Me',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ).animate().fadeIn(duration: 600.ms, delay: 700.ms).slideY(begin: -0.2),

        const SizedBox(height: AppDimensions.spacingL),

        _buildSocialLinks(context)
            .animate()
            .fadeIn(duration: 600.ms, delay: 800.ms)
            .slideY(begin: -0.2),

        const SizedBox(height: AppDimensions.spacingXXXL),

        // Contact Form
        _buildContactForm(context)
            .animate()
            .fadeIn(duration: 800.ms, delay: 900.ms)
            .slideY(begin: 0.2),
      ],
    );
  }

  Widget _buildContactInfo(BuildContext context, IconData icon, String title,
      String value, String? link) {
    return GestureDetector(
      onTap: link != null ? () => _launchUrl(link) : null,
      child: Container(
        padding: const EdgeInsets.all(AppDimensions.spacingL),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(AppDimensions.radiusL),
          border: Border.all(
            color: Theme.of(context).dividerColor.withOpacity(0.1),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(AppDimensions.spacingM),
              decoration: BoxDecoration(
                color: AppColors.primaryLight.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppDimensions.radiusM),
              ),
              child: Icon(
                icon,
                color: AppColors.primaryLight,
                size: 24,
              ),
            ),
            const SizedBox(width: AppDimensions.spacingM),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.color
                              ?.withOpacity(0.6),
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  Text(
                    value,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
            ),
            if (link != null)
              Icon(
                Icons.open_in_new,
                color: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.color
                    ?.withOpacity(0.4),
                size: 16,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialLinks(BuildContext context) {
    return Row(
      children: [
        _buildSocialLink(context, FontAwesomeIcons.github,
            personalInfo.socialLinks['github']!),
        const SizedBox(width: AppDimensions.spacingM),
        _buildSocialLink(context, FontAwesomeIcons.linkedin,
            personalInfo.socialLinks['linkedin']!),
        const SizedBox(width: AppDimensions.spacingM),
        _buildSocialLink(context, FontAwesomeIcons.telegram,
            personalInfo.socialLinks['telegram']!),
        const SizedBox(width: AppDimensions.spacingM),
        _buildSocialLink(context, FontAwesomeIcons.facebook,
            personalInfo.socialLinks['facebook']!),
      ],
    );
  }

  Widget _buildSocialLink(BuildContext context, IconData icon, String url) {
    return GestureDetector(
      onTap: () => _launchUrl(url),
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
          size: 24,
        ),
      ),
    );
  }

  Widget _buildContactForm(BuildContext context) {
    return Obx(() {
      return Container(
        padding: const EdgeInsets.all(AppDimensions.spacingXL),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(AppDimensions.radiusL),
          border: Border.all(
            color: Theme.of(context).dividerColor.withOpacity(0.1),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Form(
          key: contactController.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Send me a message',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),

              const SizedBox(height: AppDimensions.spacingL),

              // Name Field
              TextFormField(
                controller: contactController.nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                    borderSide: const BorderSide(color: AppColors.primaryLight),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                    borderSide: const BorderSide(color: Colors.red),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                    borderSide: const BorderSide(color: Colors.red),
                  ),
                ),
                validator: contactController.validateName,
              ),

              const SizedBox(height: AppDimensions.spacingM),

              // Email Field
              TextFormField(
                controller: contactController.emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                    borderSide: const BorderSide(color: AppColors.primaryLight),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                    borderSide: const BorderSide(color: Colors.red),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                    borderSide: const BorderSide(color: Colors.red),
                  ),
                ),
                validator: contactController.validateEmail,
              ),

              const SizedBox(height: AppDimensions.spacingM),

              // Message Field
              TextFormField(
                controller: contactController.messageController,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'Message',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                    borderSide: const BorderSide(color: AppColors.primaryLight),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                    borderSide: const BorderSide(color: Colors.red),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                    borderSide: const BorderSide(color: Colors.red),
                  ),
                ),
                validator: contactController.validateMessage,
              ),

              if (contactController.errorMessage.value.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: AppDimensions.spacingM),
                  child: Text(
                    contactController.errorMessage.value,
                    style: const TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),

              const SizedBox(height: AppDimensions.spacingL),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: Obx(() {
                  return ElevatedButton(
                    onPressed: contactController.isSubmitting.value
                        ? null
                        : () => contactController.submitContactForm(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryLight,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(AppDimensions.radiusM),
                      ),
                      elevation: 0,
                      disabledBackgroundColor:
                          AppColors.primaryLight.withOpacity(0.6),
                    ),
                    child: contactController.isSubmitting.value
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : const Text(
                            'Send Message',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  );
                }),
              ),
            ],
          ),
        ),
      );
    });
  }

  void _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}
