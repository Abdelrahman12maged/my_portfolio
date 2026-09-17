import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/widgets/responsive_layout.dart';

/// Ultra-modern floating island navigation bar with glassmorphism
class PortfolioNavigationBar extends StatelessWidget {
  final Function(int) onNavigate;
  final int currentIndex;

  const PortfolioNavigationBar({
    super.key,
    required this.onNavigate,
    this.currentIndex = 0,
  });

  static const List<String> _navItems = [
    'Home',
    'Skills',
    'Projects',
    'Education',
    'Contact',
  ];

  static const List<IconData> _navIcons = [
    FontAwesomeIcons.house,
    FontAwesomeIcons.code,
    FontAwesomeIcons.briefcase,
    FontAwesomeIcons.graduationCap,
    FontAwesomeIcons.paperPlane,
  ];

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      builder: (context, deviceType) {
        if (deviceType == DeviceType.mobile) {
          return _buildMobileNav(context);
        } else {
          return _buildDesktopNav(context);
        }
      },
    );
  }

  Widget _buildDesktopNav(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xl,
          vertical: AppSpacing.md,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1100),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F172A).withValues(alpha: 0.75),
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.1),
                      width: 1.2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.35),
                        blurRadius: 30,
                        offset: const Offset(0, 10),
                      ),
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.08),
                        blurRadius: 20,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // Brand / Logo
                      InkWell(
                        onTap: () => onNavigate(0),
                        borderRadius: BorderRadius.circular(12),
                        child: Row(
                          children: [
                            Container(
                              width: 38,
                              height: 38,
                              decoration: BoxDecoration(
                                gradient: AppColors.primaryGradient,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primary.withValues(alpha: 0.4),
                                    blurRadius: 12,
                                  ),
                                ],
                              ),
                              child: const Center(
                                child: Text(
                                  'A',
                                  style: TextStyle(
                                    color: Color(0xFF070B14),
                                    fontWeight: FontWeight.w900,
                                    fontSize: 20,
                                    fontFamily: 'monospace',
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: AppSpacing.sm),
                            RichText(
                              text: TextSpan(
                                text: 'Abdelrahman',
                                style: AppTextStyles.titleMedium.copyWith(
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: -0.5,
                                ),
                                children: [
                                  TextSpan(
                                    text: '.dev',
                                    style: TextStyle(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Spacer(),

                      // Navigation Links
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(_navItems.length, (index) {
                          return _DesktopNavItem(
                            label: _navItems[index],
                            icon: _navIcons[index],
                            isActive: currentIndex == index,
                            onTap: () => onNavigate(index),
                          );
                        }),
                      ),

                      const Spacer(),

                      // Resume Quick Button
                      _NavActionButton(
                        label: 'Resume',
                        icon: FontAwesomeIcons.fileArrowDown,
                        onPressed: () => _openResume(context),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Future<void> _openResume(BuildContext context) async {
    final uri = Uri.parse('assets/cv/resume.pdf');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Widget _buildMobileNav(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF070B14).withValues(alpha: 0.85),
        border: Border(
          bottom: BorderSide(
            color: Colors.white.withValues(alpha: 0.08),
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Builder(
              builder: (context) {
                return IconButton(
                  icon: const FaIcon(FontAwesomeIcons.barsStaggered, size: 20),
                  color: AppColors.primary,
                  onPressed: () => Scaffold.of(context).openDrawer(),
                );
              },
            ),
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      'A',
                      style: TextStyle(
                        color: Color(0xFF070B14),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  'Abdelrahman',
                  style: AppTextStyles.titleMedium.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            IconButton(
              icon: const FaIcon(FontAwesomeIcons.fileArrowDown, size: 18),
              color: AppColors.primary,
              tooltip: 'Resume',
              onPressed: () => _openResume(context),
            ),
          ],
        ),
      ),
    );
  }
}

class _DesktopNavItem extends StatefulWidget {
  final String label;
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;

  const _DesktopNavItem({
    required this.label,
    required this.icon,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_DesktopNavItem> createState() => _DesktopNavItemState();
}

class _DesktopNavItemState extends State<_DesktopNavItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final active = widget.isActive;
    final highlight = active || _isHovered;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: active
                ? AppColors.primary.withValues(alpha: 0.16)
                : (_isHovered
                    ? Colors.white.withValues(alpha: 0.05)
                    : Colors.transparent),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: active
                  ? AppColors.primary.withValues(alpha: 0.5)
                  : (_isHovered
                      ? Colors.white.withValues(alpha: 0.1)
                      : Colors.transparent),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (active) ...[
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: 6),
              ],
              Text(
                widget.label,
                style: AppTextStyles.labelLarge.copyWith(
                  color: highlight ? AppColors.textPrimary : AppColors.textSecondary,
                  fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavActionButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  const _NavActionButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  State<_NavActionButton> createState() => _NavActionButtonState();
}

class _NavActionButtonState extends State<_NavActionButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            gradient: _isHovered
                ? AppColors.primaryGradient
                : null,
            color: _isHovered ? null : AppColors.primary.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.primary.withValues(alpha: _isHovered ? 0.8 : 0.4),
              width: 1.2,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.35),
                      blurRadius: 14,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(
                widget.icon,
                size: 13,
                color: _isHovered ? const Color(0xFF070B14) : AppColors.primary,
              ),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: AppTextStyles.labelLarge.copyWith(
                  color: _isHovered ? const Color(0xFF070B14) : AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Mobile drawer navigation with blurred glass aesthetic
class MobileDrawer extends StatelessWidget {
  final Function(int) onNavigate;
  final int currentIndex;

  const MobileDrawer({
    super.key,
    required this.onNavigate,
    this.currentIndex = 0,
  });

  static const List<String> _navItems = [
    'Home',
    'Skills',
    'Projects',
    'Education',
    'Contact',
  ];

  static const List<IconData> _navIcons = [
    FontAwesomeIcons.house,
    FontAwesomeIcons.code,
    FontAwesomeIcons.briefcase,
    FontAwesomeIcons.graduationCap,
    FontAwesomeIcons.paperPlane,
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF0B1120),
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: AppSpacing.lg),

            // Profile Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Column(
                children: [
                  Container(
                    width: 88,
                    height: 88,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: AppColors.primaryGradient,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.3),
                          blurRadius: 20,
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(3),
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.surface,
                        image: DecorationImage(
                          image: AssetImage('assets/imageprofile.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'Abdelrahman Abdelmaged',
                    style: AppTextStyles.titleMedium.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Text(
                      'Flutter Developer',
                      style: AppTextStyles.labelSmall.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSpacing.xl),
            Divider(color: Colors.white.withValues(alpha: 0.08)),

            // Navigation items
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                itemCount: _navItems.length,
                itemBuilder: (context, index) {
                  final isActive = currentIndex == index;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      leading: FaIcon(
                        _navIcons[index],
                        color: isActive ? AppColors.primary : AppColors.textSecondary,
                        size: 18,
                      ),
                      title: Text(
                        _navItems[index],
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: isActive ? AppColors.primary : AppColors.textPrimary,
                          fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                        ),
                      ),
                      trailing: isActive
                          ? Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.primary,
                              ),
                            )
                          : null,
                      tileColor: isActive
                          ? AppColors.primary.withValues(alpha: 0.12)
                          : Colors.transparent,
                      onTap: () {
                        onNavigate(index);
                        Navigator.pop(context);
                      },
                    ),
                  );
                },
              ),
            ),

            // Social links footer
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _drawerSocialIcon(
                    FontAwesomeIcons.github,
                    'https://github.com/Abdelrahman12maged',
                  ),
                  const SizedBox(width: AppSpacing.md),
                  _drawerSocialIcon(
                    FontAwesomeIcons.linkedinIn,
                    'https://www.linkedin.com/in/abdelrahman-abdelmaged-b09356249/',
                  ),
                  const SizedBox(width: AppSpacing.md),
                  _drawerSocialIcon(
                    FontAwesomeIcons.envelope,
                    'mailto:abdomaged01206@gmail.com',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawerSocialIcon(IconData icon, String url) {
    return InkWell(
      onTap: () async {
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        ),
        child: FaIcon(icon, size: 16, color: AppColors.textSecondary),
      ),
    );
  }
}
