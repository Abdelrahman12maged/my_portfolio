import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/widgets/glassmorphic_container.dart';
import '../../../core/widgets/responsive_layout.dart';

/// Contact section
class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveLayout.getResponsivePadding(context),
        vertical: AppSpacing.sectionVertical,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            children: [
              // Section Title
              Text(
                'Get In Touch',
                style: AppTextStyles.displaySmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.md),

              ShaderMask(
                shaderCallback: (bounds) =>
                    AppColors.primaryGradient.createShader(
                      Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                    ),
                child: Container(height: 4, width: 100, color: Colors.white),
              ),
              const SizedBox(height: AppSpacing.lg),

              Text(
                'I\'m always open to discussing new projects, creative ideas, or opportunities to be part of your visions.',
                style: AppTextStyles.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xxl),

              // Contact Cards
              ResponsiveLayout(
                builder: (context, deviceType) {
                  if (deviceType == DeviceType.mobile) {
                    return Column(
                      children: const [
                        _ContactCard(
                          icon: FontAwesomeIcons.envelope,
                          title: 'Email',
                          value: 'abdomaged01206@gmail.com',
                          url: 'mailto:abdomaged01206@gmail.com',
                        ),
                        SizedBox(height: AppSpacing.md),
                        _ContactCard(
                          icon: FontAwesomeIcons.linkedinIn,
                          title: 'LinkedIn',
                          value: 'Abdelrahman Youssef',
                          url:
                              'https://www.linkedin.com/in/abdelrahman-youssef-9a44b027a/',
                        ),
                      ],
                    );
                  }

                  return Row(
                    children: const [
                      Expanded(
                        child: _ContactCard(
                          icon: FontAwesomeIcons.envelope,
                          title: 'Email',
                          value: 'abdomaged01206@gmail.com',
                          url: 'mailto:abdomaged01206@gmail.com',
                        ),
                      ),
                      SizedBox(width: AppSpacing.lg),
                      Expanded(
                        child: _ContactCard(
                          icon: FontAwesomeIcons.linkedinIn,
                          title: 'LinkedIn',
                          value: 'Abdelrahman Youssef',
                          url:
                              'https://www.linkedin.com/in/abdelrahman-youssef-9a44b027a/',
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: AppSpacing.xxl),

              // Footer
              Text(
                '© 2026 Abdelrahman Abdelmaged. Built with Flutter 💙',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textTertiary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContactCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String value;
  final String url;

  const _ContactCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.url,
  });

  @override
  State<_ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<_ContactCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () async {
          final uri = Uri.parse(widget.url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri);
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.identity()..scale(_isHovered ? 1.02 : 1.0),
          child: GlassmorphicContainer(
            padding: const EdgeInsets.all(AppSpacing.lg),
            border: Border.all(
              color: _isHovered ? AppColors.primary : AppColors.glassBorder,
              width: 1.5,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.2),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : null,
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: _isHovered ? AppColors.primaryGradient : null,
                    color: _isHovered ? null : AppColors.surfaceLight,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: FaIcon(
                      widget.icon,
                      color: AppColors.textPrimary,
                      size: 24,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: AppTextStyles.labelLarge.copyWith(
                          color: AppColors.textTertiary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.value,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: _isHovered
                              ? AppColors.primary
                              : AppColors.textPrimary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                FaIcon(
                  FontAwesomeIcons.arrowRight,
                  color: _isHovered
                      ? AppColors.primary
                      : AppColors.textTertiary,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
