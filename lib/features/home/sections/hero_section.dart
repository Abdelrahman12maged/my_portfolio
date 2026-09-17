import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/widgets/responsive_layout.dart';

/// Ultra-modern Hero section with floating tech badges and impact stats
class HeroSection extends StatefulWidget {
  final VoidCallback onProjectsPressed;

  const HeroSection({super.key, required this.onProjectsPressed});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late AnimationController _entranceController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  late AnimationController _pulseController;
  late AnimationController _rotateController;

  @override
  void initState() {
    super.initState();

    _entranceController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _entranceController,
      curve: Curves.easeOutCubic,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.12),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _entranceController, curve: Curves.easeOutCubic),
    );

    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _rotateController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();

    _entranceController.forward();
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _pulseController.dispose();
    _rotateController.dispose();
    super.dispose();
  }

  Future<void> _openUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      builder: (context, deviceType) {
        final isDesktop = deviceType == DeviceType.desktop;

        return Container(
          constraints: const BoxConstraints(minHeight: 780),
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveLayout.getResponsivePadding(context),
            vertical: isDesktop ? 120 : 80,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: AppSpacing.maxContentWidth,
              ),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Column(
                    children: [
                      // Main Hero Content Row / Column
                      if (isDesktop)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(child: _buildTextContent(context, isDesktop: true)),
                            const SizedBox(width: AppSpacing.xxxl),
                            _buildVisualAvatar(size: 330),
                          ],
                        )
                      else
                        Column(
                          children: [
                            _buildVisualAvatar(size: 210),
                            const SizedBox(height: AppSpacing.xxl),
                            _buildTextContent(context, isDesktop: false),
                          ],
                        ),

                      const SizedBox(height: 70),

                      // Impact Stats Ribbon
                      _buildImpactStatsRibbon(context, isDesktop: isDesktop),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextContent(BuildContext context, {required bool isDesktop}) {
    return Column(
      crossAxisAlignment:
          isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Availability Status Pill
        _buildAvailabilityBadge(isDesktop: isDesktop),

        const SizedBox(height: AppSpacing.lg),

        // Greeting
        Text(
          'Hello, I am',
          style: AppTextStyles.titleMedium.copyWith(
            color: AppColors.primaryLight,
            letterSpacing: 1.5,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),

        // Name with modern typography
        ShaderMask(
          shaderCallback: (bounds) => AppColors.heroTextGradient.createShader(
            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
          ),
          child: Text(
            'Abdelrahman Abdelmaged',
            style: isDesktop
                ? AppTextStyles.displayMedium
                : AppTextStyles.displaySmall,
            textAlign: isDesktop ? TextAlign.start : TextAlign.center,
          ),
        ),

        const SizedBox(height: AppSpacing.sm),

        // Dynamic Role Rotator
        _RoleRotator(isDesktop: isDesktop),

        const SizedBox(height: AppSpacing.lg),

        // Concise impactful bio
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 580),
          child: Text(
            'Specialized in architecting scalable, high-performance cross-platform mobile apps with Clean Architecture & BLoC. Delivering production-ready apps with zero-lag map navigation, real-time telemetry, and polished UI.',
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.textSecondary,
              height: 1.7,
            ),
            textAlign: isDesktop ? TextAlign.start : TextAlign.center,
          ),
        ),

        const SizedBox(height: AppSpacing.xxl),

        // Action CTA Buttons
        Wrap(
          alignment: isDesktop ? WrapAlignment.start : WrapAlignment.center,
          spacing: AppSpacing.md,
          runSpacing: AppSpacing.md,
          children: [
            // Primary Explore Projects Button
            _GlowingCtaButton(
              label: 'Explore Projects',
              icon: FontAwesomeIcons.arrowDownLong,
              onPressed: widget.onProjectsPressed,
            ),

            // Secondary Resume Button
            _OutlineCtaButton(
              label: 'Download Resume',
              icon: FontAwesomeIcons.fileArrowDown,
              onPressed: () => _openUrl('assets/cv/resume.pdf'),
            ),
          ],
        ),

        const SizedBox(height: AppSpacing.xl),

        // Quick Social Links Row
        Row(
          mainAxisAlignment:
              isDesktop ? MainAxisAlignment.start : MainAxisAlignment.center,
          children: [
            _HeroSocialIcon(
              icon: FontAwesomeIcons.github,
              tooltip: 'GitHub',
              url: 'https://github.com/Abdelrahman12maged',
            ),
            const SizedBox(width: AppSpacing.md),
            _HeroSocialIcon(
              icon: FontAwesomeIcons.linkedinIn,
              tooltip: 'LinkedIn',
              url: 'https://www.linkedin.com/in/abdelrahman-abdelmaged-b09356249/',
            ),
            const SizedBox(width: AppSpacing.md),
            _HeroSocialIcon(
              icon: FontAwesomeIcons.whatsapp,
              tooltip: 'WhatsApp',
              url: 'https://wa.me/201012170087',
            ),
            const SizedBox(width: AppSpacing.md),
            _HeroSocialIcon(
              icon: FontAwesomeIcons.envelope,
              tooltip: 'Email',
              url: 'mailto:abdomaged01206@gmail.com',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAvailabilityBadge({required bool isDesktop}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: AppColors.accentEmerald.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: AppColors.accentEmerald.withValues(alpha: 0.35),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Glowing Pulse Dot
          AnimatedBuilder(
            animation: _pulseController,
            builder: (context, child) {
              return Container(
                width: 9,
                height: 9,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.accentEmerald,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.accentEmerald.withValues(
                        alpha: 0.4 + (_pulseController.value * 0.5),
                      ),
                      blurRadius: 10 + (_pulseController.value * 6),
                      spreadRadius: 2,
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(width: 10),
          Text(
            'Available for Full-time & Freelance Roles',
            style: AppTextStyles.labelMedium.copyWith(
              color: AppColors.accentEmerald,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVisualAvatar({required double size}) {
    final orbitRadius = (size / 2) + 40.0;
    final totalContainerSize = (orbitRadius + 48.0) * 2;

    final chips = [
      {
        'icon': FontAwesomeIcons.flutter,
        'label': 'Flutter',
        'color': AppColors.primary,
      },
      {
        'icon': FontAwesomeIcons.code,
        'label': 'Dart',
        'color': AppColors.accentIndigo,
      },
      {
        'icon': FontAwesomeIcons.fire,
        'label': 'Firebase',
        'color': AppColors.accentAmber,
      },
      {
        'icon': FontAwesomeIcons.layerGroup,
        'label': 'Clean Arch',
        'color': AppColors.accentEmerald,
      },
    ];

    return FittedBox(
      fit: BoxFit.scaleDown,
      child: SizedBox(
        width: totalContainerSize,
        height: totalContainerSize,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Faint Orbit Path Circle
            Container(
              width: orbitRadius * 2,
              height: orbitRadius * 2,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.08),
                  width: 1.2,
                ),
              ),
            ),

            // Rotating ambient gradient ring
            RotationTransition(
              turns: _rotateController,
              child: Container(
                width: size + 16,
                height: size + 16,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: SweepGradient(
                    colors: [
                      AppColors.primary.withValues(alpha: 0.8),
                      AppColors.accentIndigo.withValues(alpha: 0.6),
                      AppColors.accentViolet.withValues(alpha: 0.8),
                      AppColors.primary.withValues(alpha: 0.8),
                    ],
                  ),
                ),
              ),
            ),

            // Inner Dark Frame
            Container(
              width: size + 6,
              height: size + 6,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.background,
              ),
            ),

            // Main Profile Image Container
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.surface,
                image: const DecorationImage(
                  image: AssetImage('assets/imageprofile.png'),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.25),
                    blurRadius: 36,
                    spreadRadius: 2,
                  ),
                ],
              ),
            ),

            // 4 Orbiting Tech Chips (revolving around the avatar in a circle)
            ...List.generate(chips.length, (index) {
              final chip = chips[index];
              return AnimatedBuilder(
                animation: _rotateController,
                builder: (context, child) {
                  final angle = (_rotateController.value * 2 * math.pi) +
                      (index * (math.pi / 2));
                  final dx = orbitRadius * math.cos(angle);
                  final dy = orbitRadius * math.sin(angle);

                  return Transform.translate(
                    offset: Offset(dx, dy),
                    child: _FloatingChip(
                      icon: chip['icon'] as IconData,
                      label: chip['label'] as String,
                      accentColor: chip['color'] as Color,
                    ),
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildImpactStatsRibbon(BuildContext context, {required bool isDesktop}) {
    final stats = [
      {'value': '5+', 'label': 'Production Projects', 'icon': FontAwesomeIcons.folderTree},
      {'value': 'Clean Arch', 'label': 'BLoC & Testable Design', 'icon': FontAwesomeIcons.cubes},
      {'value': '1,000+', 'label': 'Active Users Impacted', 'icon': FontAwesomeIcons.users},
      {'value': 'Assiut Univ', 'label': 'CS & Info Bachelor', 'icon': FontAwesomeIcons.graduationCap},
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.65),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.08),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: isDesktop
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(stats.length, (index) {
                final item = stats[index];
                return Row(
                  children: [
                    _buildStatItem(item),
                    if (index < stats.length - 1)
                      Container(
                        margin: const EdgeInsets.only(left: 36),
                        height: 40,
                        width: 1,
                        color: Colors.white.withValues(alpha: 0.08),
                      ),
                  ],
                );
              }),
            )
          : Wrap(
              alignment: WrapAlignment.spaceAround,
              runSpacing: AppSpacing.lg,
              spacing: AppSpacing.lg,
              children: stats.map((item) => _buildStatItem(item)).toList(),
            ),
    );
  }

  Widget _buildStatItem(Map<String, dynamic> item) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.25),
            ),
          ),
          child: FaIcon(
            item['icon'] as IconData,
            color: AppColors.primary,
            size: 20,
          ),
        ),
        const SizedBox(width: 14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              item['value'] as String,
              style: AppTextStyles.headlineSmall.copyWith(
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
            Text(
              item['label'] as String,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _RoleRotator extends StatefulWidget {
  final bool isDesktop;
  const _RoleRotator({required this.isDesktop});

  @override
  State<_RoleRotator> createState() => _RoleRotatorState();
}

class _RoleRotatorState extends State<_RoleRotator> {
  static const List<String> _roles = [
    'Flutter Developer',
    'Clean Architecture Specialist',
    'Mobile Solutions Architect',
    'Google Maps & GPS Telemetry Pro',
    
  ];

  int _currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (mounted) {
        setState(() {
          _currentIndex = (_currentIndex + 1) % _roles.length;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 450),
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.3),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      },
      child: Text(
        _roles[_currentIndex],
        key: ValueKey<int>(_currentIndex),
        style: widget.isDesktop
            ? AppTextStyles.headlineMedium.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
              )
            : AppTextStyles.headlineSmall.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
              ),
        textAlign: widget.isDesktop ? TextAlign.start : TextAlign.center,
      ),
    );
  }
}

class _FloatingChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color accentColor;

  const _FloatingChip({
    required this.icon,
    required this.label,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A).withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: accentColor.withValues(alpha: 0.5),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: accentColor.withValues(alpha: 0.25),
            blurRadius: 16,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FaIcon(icon, color: accentColor, size: 13),
          const SizedBox(width: 6),
          Text(
            label,
            style: AppTextStyles.labelSmall.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _GlowingCtaButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  const _GlowingCtaButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  State<_GlowingCtaButton> createState() => _GlowingCtaButtonState();
}

class _GlowingCtaButtonState extends State<_GlowingCtaButton> {
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
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          transform: Matrix4.translationValues(
            0.0,
            _isHovered ? -3.0 : 0.0,
            0.0,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: _isHovered ? 0.55 : 0.3),
                blurRadius: _isHovered ? 24 : 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: AppTextStyles.button.copyWith(
                  color: const Color(0xFF070B14),
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(width: 10),
              FaIcon(
                widget.icon,
                size: 14,
                color: const Color(0xFF070B14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OutlineCtaButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  const _OutlineCtaButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  State<_OutlineCtaButton> createState() => _OutlineCtaButtonState();
}

class _OutlineCtaButtonState extends State<_OutlineCtaButton> {
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
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          transform: Matrix4.translationValues(
            0.0,
            _isHovered ? -3.0 : 0.0,
            0.0,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
            color: _isHovered
                ? Colors.white.withValues(alpha: 0.08)
                : Colors.white.withValues(alpha: 0.03),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _isHovered
                  ? AppColors.primary
                  : Colors.white.withValues(alpha: 0.15),
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(
                widget.icon,
                size: 15,
                color: _isHovered ? AppColors.primary : Colors.white,
              ),
              const SizedBox(width: 10),
              Text(
                widget.label,
                style: AppTextStyles.button.copyWith(
                  color: _isHovered ? AppColors.primary : Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeroSocialIcon extends StatefulWidget {
  final IconData icon;
  final String tooltip;
  final String url;

  const _HeroSocialIcon({
    required this.icon,
    required this.tooltip,
    required this.url,
  });

  @override
  State<_HeroSocialIcon> createState() => _HeroSocialIconState();
}

class _HeroSocialIconState extends State<_HeroSocialIcon> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () async {
          final uri = Uri.parse(widget.url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          }
        },
        child: Tooltip(
          message: widget.tooltip,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            transform: Matrix4.translationValues(
              0.0,
              _isHovered ? -3.0 : 0.0,
              0.0,
            ),
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: _isHovered
                  ? AppColors.primary.withValues(alpha: 0.18)
                  : AppColors.surface,
              shape: BoxShape.circle,
              border: Border.all(
                color: _isHovered
                    ? AppColors.primary
                    : Colors.white.withValues(alpha: 0.1),
                width: 1.2,
              ),
              boxShadow: _isHovered
                  ? [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.3),
                        blurRadius: 14,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : [],
            ),
            child: Center(
              child: FaIcon(
                widget.icon,
                size: 18,
                color: _isHovered ? AppColors.primary : AppColors.textSecondary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
