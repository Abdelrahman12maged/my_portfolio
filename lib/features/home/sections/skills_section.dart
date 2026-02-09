import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/widgets/responsive_layout.dart';

/// Enhanced skills section with beautiful, modern design
class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  static const Map<String, List<Map<String, dynamic>>> skillCategories = {
    'Mobile Development': [
      {'name': 'Flutter', 'icon': FontAwesomeIcons.mobile},
      {'name': 'Dart', 'icon': FontAwesomeIcons.code},
      {'name': 'Platform Channels', 'icon': FontAwesomeIcons.cubes},
      {'name': 'Responsive Design', 'icon': FontAwesomeIcons.mobileScreen},
    ],
    'Architecture & Patterns': [
      {'name': 'Clean Architecture', 'icon': FontAwesomeIcons.layerGroup},
      {'name': 'SOLID Principles', 'icon': FontAwesomeIcons.shapes},
      {'name': 'Bloc/Cubit', 'icon': FontAwesomeIcons.sitemap},
      {'name': 'Repository Pattern', 'icon': FontAwesomeIcons.database},
    ],
    'Backend & APIs': [
      {'name': 'Firebase', 'icon': FontAwesomeIcons.fire},
      {'name': 'REST APIs', 'icon': FontAwesomeIcons.cloudArrowDown},
      {'name': 'Real-time Communication', 'icon': FontAwesomeIcons.comments},
    ],
    'Tools & Technologies': [
      {'name': 'Git', 'icon': FontAwesomeIcons.github},
      {'name': 'UI/UX Optimization', 'icon': FontAwesomeIcons.paintbrush},
      {'name': 'Material Design', 'icon': FontAwesomeIcons.palette},
      {'name': 'PyTorch', 'icon': FontAwesomeIcons.brain},
    ],
  };

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

              // Skill Categories Grid
              ResponsiveLayout(
                builder: (context, deviceType) {
                  final crossAxisCount = deviceType == DeviceType.mobile
                      ? 1
                      : 2;

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      mainAxisSpacing: AppSpacing.lg,
                      crossAxisSpacing: AppSpacing.lg,
                      childAspectRatio: deviceType == DeviceType.mobile
                          ? 1.2
                          : 1.1,
                    ),
                    itemCount: skillCategories.length,
                    itemBuilder: (context, index) {
                      final entry = skillCategories.entries.elementAt(index);
                      return _SkillCategoryCard(
                        category: entry.key,
                        skills: entry.value,
                        index: index,
                      );
                    },
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

  const _SkillCategoryCard({
    required this.category,
    required this.skills,
    required this.index,
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
    return ScaleTransition(
      scale: _animation,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          transform: Matrix4.identity()
            ..translate(0.0, _isHovered ? -8.0 : 0.0),
          decoration: BoxDecoration(
            gradient: _isHovered
                ? AppColors.primaryGradient
                : LinearGradient(
                    colors: [AppColors.surface, AppColors.surfaceLight],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: _isHovered ? Colors.transparent : AppColors.glassBorder,
              width: 2,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.4),
                      blurRadius: 30,
                      spreadRadius: 5,
                      offset: const Offset(0, 10),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
          ),
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Category Header
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _isHovered
                          ? Colors.white.withOpacity(0.2)
                          : AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: FaIcon(
                      FontAwesomeIcons.layerGroup,
                      color: _isHovered ? Colors.white : AppColors.primary,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Text(
                      widget.category,
                      style: AppTextStyles.titleLarge.copyWith(
                        color: _isHovered
                            ? Colors.white
                            : AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),

              // Skills List
              Expanded(
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.skills.length,
                  itemBuilder: (context, index) {
                    final skill = widget.skills[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                      child: Row(
                        children: [
                          FaIcon(
                            skill['icon'] as IconData,
                            size: 16,
                            color: _isHovered
                                ? Colors.white
                                : AppColors.primary,
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: Text(
                              skill['name'] as String,
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: _isHovered
                                    ? Colors.white
                                    : AppColors.textPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
