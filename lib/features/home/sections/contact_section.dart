import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/widgets/responsive_layout.dart';

/// Ultra-modern Contact & Connect section with quick actions
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
          constraints: const BoxConstraints(maxWidth: 960),
          child: Column(
            children: [
              // Header
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Text(
                      'GET IN TOUCH',
                      style: AppTextStyles.labelSmall.copyWith(
                        color: AppColors.primary,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Let's Build Something Exceptional",
                    style: AppTextStyles.displaySmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 580),
                    child: Text(
                      'Open for full-time engineering roles, mobile contract projects, and ambitious technical collaborations.',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 50),

              // Contact Action Cards Grid
              ResponsiveLayout(
                builder: (context, deviceType) {
                  final isMobile = deviceType == DeviceType.mobile;

                  final items = [
                    _ContactItemData(
                      icon: FontAwesomeIcons.envelope,
                      title: 'Direct Email',
                      value: 'abdomaged01206@gmail.com',
                      url: 'mailto:abdomaged01206@gmail.com',
                      copyValue: 'abdomaged01206@gmail.com',
                      accentColor: AppColors.primary,
                    ),
                    _ContactItemData(
                      icon: FontAwesomeIcons.whatsapp,
                      title: 'Direct WhatsApp',
                      value: '+20 010 121 700 87',
                      url: 'https://wa.me/201012170087',
                      copyValue: '+201012170087',
                      accentColor: AppColors.accentEmerald,
                    ),
                    _ContactItemData(
                      icon: FontAwesomeIcons.linkedinIn,
                      title: 'LinkedIn Network',
                      value: 'Abdelrahman Abdelmaged',
                      url:
                          'https://www.linkedin.com/in/abdelrahman-abdelmaged-b09356249/',
                      accentColor: AppColors.accentIndigo,
                    ),
                    _ContactItemData(
                      icon: FontAwesomeIcons.github,
                      title: 'GitHub Repositories',
                      value: 'Abdelrahman12maged',
                      url: 'https://github.com/Abdelrahman12maged',
                      accentColor: Colors.white70,
                    ),
                  ];

                  if (isMobile) {
                    return Column(
                      children: items
                          .map((item) => Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: _ModernContactCard(data: item),
                              ))
                          .toList(),
                    );
                  }

                  return Column(
                    children: [
                      Row(
                        children: [
                          Expanded(child: _ModernContactCard(data: items[0])),
                          const SizedBox(width: AppSpacing.lg),
                          Expanded(child: _ModernContactCard(data: items[1])),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      Row(
                        children: [
                          Expanded(child: _ModernContactCard(data: items[2])),
                          const SizedBox(width: AppSpacing.lg),
                          Expanded(child: _ModernContactCard(data: items[3])),
                        ],
                      ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 70),

              // Modern Footer
              Container(
                padding: const EdgeInsets.symmetric(vertical: 24),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.white.withValues(alpha: 0.08),
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '© 2026 Abdelrahman Abdelmaged. All rights reserved.',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textTertiary,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Engineered with Flutter',
                          style: AppTextStyles.labelSmall.copyWith(
                            color: AppColors.primaryLight,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContactItemData {
  final IconData icon;
  final String title;
  final String value;
  final String url;
  final String? copyValue;
  final Color accentColor;

  const _ContactItemData({
    required this.icon,
    required this.title,
    required this.value,
    required this.url,
    this.copyValue,
    required this.accentColor,
  });
}

class _ModernContactCard extends StatefulWidget {
  final _ContactItemData data;

  const _ModernContactCard({required this.data});

  @override
  State<_ModernContactCard> createState() => _ModernContactCardState();
}

class _ModernContactCardState extends State<_ModernContactCard> {
  bool _isHovered = false;

  Future<void> _open() async {
    final uri = Uri.parse(widget.data.url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void _copy(BuildContext context) {
    if (widget.data.copyValue != null) {
      Clipboard.setData(ClipboardData(text: widget.data.copyValue!));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Copied ${widget.data.copyValue} to clipboard!'),
          backgroundColor: AppColors.surfaceLight,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final accent = widget.data.accentColor;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: _open,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          transform: Matrix4.translationValues(
            0.0,
            _isHovered ? -4.0 : 0.0,
            0.0,
          ),
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: const Color(0xFF0F172A).withValues(alpha: 0.75),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: _isHovered
                  ? accent.withValues(alpha: 0.6)
                  : Colors.white.withValues(alpha: 0.08),
              width: _isHovered ? 1.5 : 1.0,
            ),
            boxShadow: [
              BoxShadow(
                color: _isHovered
                    ? accent.withValues(alpha: 0.2)
                    : Colors.black.withValues(alpha: 0.3),
                blurRadius: _isHovered ? 24 : 14,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            children: [
              // Icon Container
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  gradient: _isHovered
                      ? LinearGradient(
                          colors: [accent, accent.withValues(alpha: 0.7)],
                        )
                      : null,
                  color: _isHovered ? null : accent.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: FaIcon(
                    widget.data.icon,
                    color: _isHovered ? const Color(0xFF070B14) : accent,
                    size: 22,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),

              // Title and Value
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.data.title,
                      style: AppTextStyles.labelSmall.copyWith(
                        color: AppColors.textTertiary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.data.value,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: _isHovered ? Colors.white : AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              // Copy button if applicable
              if (widget.data.copyValue != null)
                IconButton(
                  icon: const Icon(Icons.copy_rounded, size: 18),
                  color: _isHovered ? accent : AppColors.textTertiary,
                  tooltip: 'Copy',
                  onPressed: () => _copy(context),
                ),

              // Arrow indicator
              FaIcon(
                FontAwesomeIcons.arrowUpRightFromSquare,
                color: _isHovered ? accent : AppColors.textTertiary,
                size: 14,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
