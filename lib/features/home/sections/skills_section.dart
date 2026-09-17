import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/widgets/responsive_layout.dart';

/// Enhanced skills matrix section with modern glass cards & categorized skills
class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  static const Map<String, List<Map<String, dynamic>>> skillCategories = {
    'Mobile Development': [
      {'name': 'Flutter 3.x', 'icon': FontAwesomeIcons.flutter},
      {'name': 'Dart', 'icon': FontAwesomeIcons.code},
      {'name': 'Responsive & Adaptive UI', 'icon': FontAwesomeIcons.mobileScreen},
      {'name': 'Localization (AR & EN)', 'icon': FontAwesomeIcons.language},
      {'name': 'Performance & Profiling', 'icon': FontAwesomeIcons.gaugeHigh},
    ],
    'Architecture & Patterns': [
      {'name': 'Clean Architecture', 'icon': FontAwesomeIcons.layerGroup},
      {'name': 'SOLID Principles', 'icon': FontAwesomeIcons.shapes},
      {'name': 'Repository Pattern', 'icon': FontAwesomeIcons.cubes},
      {'name': 'BLoC & Cubit State Mgmt', 'icon': FontAwesomeIcons.arrowsRotate},
      {'name': 'Dependency Injection (GetIt)', 'icon': FontAwesomeIcons.plug},
    ],
    'Backend & Cloud Services': [
      {'name': 'Firebase (Auth, Firestore)', 'icon': FontAwesomeIcons.fire},
      {'name': 'Cloud Messaging (FCM)', 'icon': FontAwesomeIcons.bell},
      {'name': 'REST APIs & Dio Client', 'icon': FontAwesomeIcons.cloudArrowDown},
      {'name': 'Offline Caching (Hive)', 'icon': FontAwesomeIcons.database},
      {'name': 'JSON Serialization', 'icon': FontAwesomeIcons.fileCode},
    ],
    'Mapping & Telemetry': [
      {'name': 'Google Maps SDK', 'icon': FontAwesomeIcons.mapLocationDot},
      {'name': 'OSRM Dual Routing Engine', 'icon': FontAwesomeIcons.route},
      {'name': 'GPS Live Coordinate Stream', 'icon': FontAwesomeIcons.locationArrow},
      {'name': 'Automated Geofencing', 'icon': FontAwesomeIcons.crosshairs},
      {'name': 'Platform Channels (Native SMS)', 'icon': FontAwesomeIcons.terminal},
    ],
    'Tools & Workflow': [
      {'name': 'Git & GitHub', 'icon': FontAwesomeIcons.github},
      {'name': 'Android Studio & VS Code', 'icon': FontAwesomeIcons.laptopCode},
      {'name': 'Postman API Testing', 'icon': FontAwesomeIcons.paperPlane},
      {'name': 'Figma UI Translation', 'icon': FontAwesomeIcons.paintbrush},
      {'name': 'Google Play Console', 'icon': FontAwesomeIcons.googlePlay},
    ],
  };

  // Modern accent colors
  static const List<Color> _categoryColors = [
    Color(0xFF00D2FF), // Electric Cyan
    Color(0xFF818CF8), // Modern Indigo
    Color(0xFF10B981), // Emerald
    Color(0xFFF59E0B), // Amber
    Color(0xFFA855F7), // Purple
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveLayout.getResponsivePadding(context),
        vertical: AppSpacing.sectionVertical,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppSpacing.maxContentWidth,
          ),
          child: Column(
            children: [
              // Section Header
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
                      'TECHNICAL EXPERTISE',
                      style: AppTextStyles.labelSmall.copyWith(
                        color: AppColors.primary,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Skills & Architecture Matrix',
                    style: AppTextStyles.displaySmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 620),
                    child: Text(
                      'Technologies, architectural paradigms, and development tools applied in building production applications.',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 50),

              // Skill Categories
              ResponsiveLayout(
                builder: (context, deviceType) {
                  final entries = skillCategories.entries.toList();
                  return Wrap(
                    spacing: AppSpacing.xl,
                    runSpacing: AppSpacing.xl,
                    alignment: WrapAlignment.center,
                    children: entries.asMap().entries.map((mapEntry) {
                      final index = mapEntry.key;
                      final entry = mapEntry.value;
                      final cardWidth = deviceType == DeviceType.mobile
                          ? double.infinity
                          : (deviceType == DeviceType.tablet ? 340.0 : 360.0);
                      return SizedBox(
                        width: cardWidth,
                        child: _SkillCategoryCard(
                          category: entry.key,
                          skills: entry.value,
                          index: index,
                          accentColor:
                              _categoryColors[index % _categoryColors.length],
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SkillCategoryCard extends StatefulWidget {
  final String category;
  final List<Map<String, dynamic>> skills;
  final int index;
  final Color accentColor;

  const _SkillCategoryCard({
    required this.category,
    required this.skills,
    required this.index,
    required this.accentColor,
  });

  @override
  State<_SkillCategoryCard> createState() => _SkillCategoryCardState();
}

class _SkillCategoryCardState extends State<_SkillCategoryCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final accent = widget.accentColor;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(
          0.0,
          _isHovered ? -5.0 : 0.0,
          0.0,
        ),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: const Color(0xFF0F172A).withValues(alpha: 0.75),
          borderRadius: BorderRadius.circular(22),
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
                  : Colors.black.withValues(alpha: 0.35),
              blurRadius: _isHovered ? 26 : 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Category Header
            Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: _isHovered
                        ? LinearGradient(
                            colors: [accent, accent.withValues(alpha: 0.7)],
                          )
                        : null,
                    color: _isHovered ? null : accent.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: FaIcon(
                    _getCategoryIcon(widget.category),
                    color: _isHovered ? const Color(0xFF070B14) : accent,
                    size: 20,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Text(
                    widget.category,
                    style: AppTextStyles.titleMedium.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),

            // Accent divider line
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final targetWidth = constraints.maxWidth.isFinite
                      ? constraints.maxWidth
                      : 260.0;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.easeOutCubic,
                    height: 2,
                    width: _isHovered ? targetWidth : 48.0,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [accent, accent.withValues(alpha: 0.0)],
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  );
                },
              ),
            ),

            // Skills chips
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: widget.skills.map((skill) {
                return _SkillChip(
                  name: skill['name'] as String,
                  icon: skill['icon'] as IconData,
                  accentColor: accent,
                  isHovered: _isHovered,
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Mobile Development':
        return FontAwesomeIcons.mobileScreen;
      case 'Architecture & Patterns':
        return FontAwesomeIcons.layerGroup;
      case 'Backend & Cloud Services':
        return FontAwesomeIcons.server;
      case 'Mapping & Telemetry':
        return FontAwesomeIcons.mapLocationDot;
      case 'Tools & Workflow':
        return FontAwesomeIcons.toolbox;
      default:
        return FontAwesomeIcons.code;
    }
  }
}

class _SkillChip extends StatelessWidget {
  final String name;
  final IconData icon;
  final Color accentColor;
  final bool isHovered;

  const _SkillChip({
    required this.name,
    required this.icon,
    required this.accentColor,
    required this.isHovered,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: isHovered
            ? accentColor.withValues(alpha: 0.12)
            : const Color(0xFF162033).withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isHovered
              ? accentColor.withValues(alpha: 0.4)
              : Colors.white.withValues(alpha: 0.06),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FaIcon(
            icon,
            size: 13,
            color: isHovered ? accentColor : AppColors.textTertiary,
          ),
          const SizedBox(width: 8),
          Text(
            name,
            style: AppTextStyles.bodySmall.copyWith(
              color: isHovered ? Colors.white : AppColors.textSecondary,
              fontWeight: isHovered ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
