import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/widgets/responsive_layout.dart';

/// Enhanced skills section with premium, modern design
class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  static const Map<String, List<Map<String, dynamic>>> skillCategories = {
    'Mobile Development': [
      {'name': 'Flutter', 'icon': FontAwesomeIcons.mobile},
      {'name': 'Dart', 'icon': FontAwesomeIcons.code},
      {
        'name': 'Responsive & Adaptive UI',
        'icon': FontAwesomeIcons.mobileScreen
      },
      {'name': 'Localization (AR & EN)', 'icon': FontAwesomeIcons.language},
      {'name': 'Performance Optimization', 'icon': FontAwesomeIcons.gaugeHigh},
    ],
    'Architecture & Patterns': [
      {'name': 'Clean Architecture', 'icon': FontAwesomeIcons.layerGroup},
      {'name': 'SOLID Principles', 'icon': FontAwesomeIcons.shapes},
      {'name': 'MVC / MVVM', 'icon': FontAwesomeIcons.cubes},
      {'name': 'Design Patterns', 'icon': FontAwesomeIcons.sitemap},
      {'name': 'Dependency Injection', 'icon': FontAwesomeIcons.plug},
    ],
    'State Management': [
      {'name': 'Bloc / Cubit', 'icon': FontAwesomeIcons.sitemap},
      {'name': 'Provider', 'icon': FontAwesomeIcons.database},
      {'name': 'GetX', 'icon': FontAwesomeIcons.bolt},
    ],
    'Backend & APIs': [
      {
        'name': 'Firebase (Auth, Firestore, FCM)',
        'icon': FontAwesomeIcons.fire
      },
      {'name': 'REST APIs', 'icon': FontAwesomeIcons.cloudArrowDown},
      {
        'name': 'Google Maps Integration',
        'icon': FontAwesomeIcons.mapLocationDot
      },
      {'name': 'Payment Integration', 'icon': FontAwesomeIcons.creditCard},
    ],
    'Tools & Technologies': [
      {'name': 'Git & GitHub', 'icon': FontAwesomeIcons.github},
      {'name': 'Android Studio / VS Code', 'icon': FontAwesomeIcons.laptop},
      {'name': 'Postman', 'icon': FontAwesomeIcons.paperPlane},
      {'name': 'Figma', 'icon': FontAwesomeIcons.paintbrush},
      {'name': 'Google Play Console', 'icon': FontAwesomeIcons.googlePlay},
    ],
  };

  // Category accent colors for visual distinction
  static const List<Color> _categoryColors = [
    Color(0xFF00C8FF), // Cyan
    Color(0xFF7B61FF), // Purple
    Color(0xFFFF6B6B), // Coral
    Color(0xFF00D68F), // Green
    Color(0xFFFFAA00), // Amber
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
              // Section Title
              Text(
                'Technical Skills',
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
              const SizedBox(height: AppSpacing.xxl),

              // Skill Categories - Wrap layout for better flexibility
              ResponsiveLayout(
                builder: (context, deviceType) {
                  final entries = skillCategories.entries.toList();
                  return Wrap(
                    spacing: AppSpacing.lg,
                    runSpacing: AppSpacing.lg,
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

class _SkillCategoryCardState extends State<_SkillCategoryCard>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    );

    // Staggered animation
    Future.delayed(Duration(milliseconds: widget.index * 150), () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final accent = widget.accentColor;

    return ScaleTransition(
      scale: _animation,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          transform: Matrix4.identity()
            ..translate(0.0, _isHovered ? -6.0 : 0.0),
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: _isHovered
                  ? accent.withValues(alpha: 0.6)
                  : AppColors.glassBorder,
              width: 1.5,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: accent.withValues(alpha: 0.25),
                      blurRadius: 24,
                      spreadRadius: 2,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
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
                  // Accent icon container
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      gradient: _isHovered
                          ? LinearGradient(
                              colors: [accent, accent.withValues(alpha: 0.7)],
                            )
                          : null,
                      color: _isHovered ? null : accent.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: FaIcon(
                      _getCategoryIcon(widget.category),
                      color: _isHovered ? Colors.white : accent,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Text(
                      widget.category,
                      style: AppTextStyles.titleMedium.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              // Accent divider line
              Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      height: 2,
                      width: _isHovered ? constraints.maxWidth : 60,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [accent, accent.withValues(alpha: 0.0)],
                        ),
                        borderRadius: BorderRadius.circular(1),
                      ),
                    );
                  },
                ),
              ),

              // Skills chips
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
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
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Mobile Development':
        return FontAwesomeIcons.mobile;
      case 'Architecture & Patterns':
        return FontAwesomeIcons.layerGroup;
      case 'State Management':
        return FontAwesomeIcons.arrowsRotate;
      case 'Backend & APIs':
        return FontAwesomeIcons.server;
      case 'Tools & Technologies':
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
      duration: const Duration(milliseconds: 250),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: isHovered
            ? accentColor.withValues(alpha: 0.12)
            : AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isHovered
              ? accentColor.withValues(alpha: 0.35)
              : Colors.transparent,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FaIcon(
            icon,
            size: 14,
            color: isHovered ? accentColor : AppColors.textTertiary,
          ),
          const SizedBox(width: 8),
          Text(
            name,
            style: AppTextStyles.bodySmall.copyWith(
              color:
                  isHovered ? AppColors.textPrimary : AppColors.textSecondary,
              fontWeight: isHovered ? FontWeight.w500 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
