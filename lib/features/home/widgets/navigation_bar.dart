import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/widgets/glassmorphic_container.dart';
import '../../../core/widgets/responsive_layout.dart';

/// Glassmorphic navigation bar
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
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
       // color: AppColors.surface.withOpacity(0.95),
        border: Border(
          bottom: BorderSide(color: AppColors.glassBorder, width: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: GlassmorphicContainer(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            borderRadius: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(_navItems.length, (index) {
                return _NavItem(
                  label: _navItems[index],
                  isActive: currentIndex == index,
                  onTap: () => onNavigate(index),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileNav(BuildContext context) {
    return AppBar(
     // backgroundColor: AppColors.surface.withOpacity(0.95),
      elevation: 0,
      leading: Builder(
        builder: (context) {
          return IconButton(
            icon: const FaIcon(FontAwesomeIcons.bars),
            color: AppColors.primary,
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        },
      ),
      title: Text(
        'Abdelrahman A.',
        style: AppTextStyles.titleMedium.copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            gradient: widget.isActive || _isHovered
                ? AppColors.primaryGradient
                : null,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            widget.label,
            style: AppTextStyles.labelLarge.copyWith(
              color: widget.isActive || _isHovered
                  ? AppColors.textPrimary
                  : AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}

// Mobile drawer navigation
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
    FontAwesomeIcons.user,
    FontAwesomeIcons.code,
    FontAwesomeIcons.briefcase,
    FontAwesomeIcons.graduationCap,
    FontAwesomeIcons.envelope,
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
   //   backgroundColor: AppColors.surface,
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: AppSpacing.lg),

            // Header
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.primary, width: 3),
                      image: const DecorationImage(
                        image: AssetImage('assets/imageprofile.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'Abdelrahman Abdelmaged',
                    style: AppTextStyles.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Flutter Developer',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),

            const Divider(color: AppColors.surfaceLight),

            // Navigation items
            Expanded(
              child: ListView.builder(
                itemCount: _navItems.length,
                itemBuilder: (context, index) {
                  final isActive = currentIndex == index;
                  return ListTile(
                    leading: FaIcon(
                      _navIcons[index],
                      color: isActive
                          ? AppColors.primary
                          : AppColors.textSecondary,
                      size: 20,
                    ),
                    title: Text(
                      _navItems[index],
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: isActive
                            ? AppColors.primary
                            : AppColors.textSecondary,
                        fontWeight: isActive
                            ? FontWeight.w600
                            : FontWeight.w400,
                      ),
                    ),
                    selected: isActive,
                    selectedTileColor: AppColors.primary.withOpacity(0.1),
                    onTap: () {
                      onNavigate(index);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
