import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:html' as html;
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/widgets/responsive_layout.dart';

/// Hero section with fade-in animation
class HeroSection extends StatefulWidget {
  final VoidCallback onProjectsPressed;

  const HeroSection({super.key, required this.onProjectsPressed});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      builder: (context, deviceType) {
        return Container(
          constraints: const BoxConstraints(minHeight: 800),
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveLayout.getResponsivePadding(context),
            vertical: AppSpacing.xxxl,
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
                  child: deviceType == DeviceType.mobile
                      ? _buildMobileLayout(context)
                      : _buildDesktopLayout(context),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _buildContent(context, isDesktop: true)),
        const SizedBox(width: AppSpacing.xxxl),
        _buildProfileImage(size: 400),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        _buildProfileImage(size: 250),
        const SizedBox(height: AppSpacing.xxl),
        _buildContent(context, isDesktop: false),
      ],
    );
  }

  Widget _buildProfileImage({required double size}) {
    return Hero(
        tag: 'profile_image',
        child: _FloatingWidget(
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: AppColors.primaryGradient,
              boxShadow: AppColors.primaryShadow,
            ),
            padding: const EdgeInsets.all(6),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.surface,
                image: const DecorationImage(
                  image: AssetImage('assets/imageprofile.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ));
  }

  Widget _buildContent(BuildContext context, {required bool isDesktop}) {
    return Column(
      crossAxisAlignment:
          isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Greeting
        const SizedBox(height: AppSpacing.xxl),
        Text(
          'Hello, I am',
          style: AppTextStyles.titleMedium.copyWith(
            color: AppColors.primary,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),

        // Animated Name (Typewriter + Gradient)
        _TypewriterText(
          text: 'Abdelrahman Abdelmaged',
          style: AppTextStyles.displayMedium.copyWith(
            fontWeight: FontWeight.bold,
            height: 1.2,
          ),
          isDesktop: isDesktop,
        ),

        const SizedBox(height: AppSpacing.md),

        // Title
        Text(
          'Flutter Developer',
          style: isDesktop
              ? AppTextStyles.headlineLarge
              : AppTextStyles.headlineMedium,
          textAlign: isDesktop ? TextAlign.left : TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.lg),

        // Location
        Row(
          mainAxisAlignment:
              isDesktop ? MainAxisAlignment.start : MainAxisAlignment.center,
          children: [
            const FaIcon(
              FontAwesomeIcons.locationDot,
              color: AppColors.primary,
              size: 18,
            ),
            const SizedBox(width: AppSpacing.sm),
            Text('Assiut, Egypt', style: AppTextStyles.bodyLarge),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),

        // Phone Number
        Row(
          mainAxisAlignment:
              isDesktop ? MainAxisAlignment.start : MainAxisAlignment.center,
          children: [
            const FaIcon(
              FontAwesomeIcons.phone,
              color: AppColors.primary,
              size: 18,
            ),
            const SizedBox(width: AppSpacing.sm),
            Text('+20 010 121 700 87', style: AppTextStyles.bodyLarge),
          ],
        ),
        const SizedBox(height: AppSpacing.xxl),

        // Summary
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Text(
            '''Flutter Developer with extensive experience in cross-platform mobile application development,responsive
layouts, and state management using Bloc and Cubit. Experienced in architecting scalable app
structures, integrating RESTful APIs, Firebase, and third-party libraries. Strong proficiency in Dart, delivering
high-performance, maintainable, and user-friendly applications for iOS and Android platforms.''',
            style: AppTextStyles.bodyLarge,
            textAlign: isDesktop ? TextAlign.left : TextAlign.center,
          ),
        ),
        const SizedBox(height: AppSpacing.xxl),

        // Action Buttons
        Wrap(
          alignment: isDesktop ? WrapAlignment.start : WrapAlignment.center,
          spacing: AppSpacing.md,
          runSpacing: AppSpacing.md,
          children: [
            _ActionButton(
              label: 'View Projects',
              icon: FontAwesomeIcons.briefcase,
              isPrimary: true,
              onPressed: widget.onProjectsPressed,
            ),
            _ActionButton(
              label: 'My Resume',
              icon: FontAwesomeIcons.fileArrowDown,
              isPrimary: false,
              onPressed: () {
                final anchor = html.AnchorElement(
                  href: 'assets/assets/cv/resume.pdf',
                )
                  ..setAttribute(
                      'download', 'Abdelrahman_Abdelmaged_Resume.pdf')
                  ..setAttribute('target', '_blank')
                  ..click();
              },
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xxl),

        // Social Links
        Row(
          mainAxisAlignment:
              isDesktop ? MainAxisAlignment.start : MainAxisAlignment.center,
          children: [
            _SocialButton(
              icon: FontAwesomeIcons.linkedinIn,
              url:
                  'https://www.linkedin.com/in/abdelrahman-abdelmaged-b09356249/',
            ),
            const SizedBox(width: AppSpacing.md),
            _SocialButton(
              icon: FontAwesomeIcons.github,
              url: 'https://github.com/Abdelrahman12maged',
            ),
            const SizedBox(width: AppSpacing.md),
            _SocialButton(
              icon: FontAwesomeIcons.envelope,
              url: 'mailto:abdomaged01206@gmail.com',
            ),
          ],
        ),
      ],
    );
  }
}

class _ActionButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final bool isPrimary;
  final VoidCallback onPressed;

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.isPrimary,
    required this.onPressed,
  });

  @override
  State<_ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<_ActionButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()..scale(_isHovered ? 1.05 : 1.0),
        child: ElevatedButton.icon(
          onPressed: widget.onPressed,
          icon: FaIcon(widget.icon, size: 18),
          label: Text(widget.label),
          style: widget.isPrimary
              ? ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                    vertical: AppSpacing.md,
                  ),
                )
              : ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: AppColors.primary,
                  side: const BorderSide(color: AppColors.primary, width: 2),
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                    vertical: AppSpacing.md,
                  ),
                ),
        ),
      ),
    );
  }
}

class _SocialButton extends StatefulWidget {
  final IconData icon;
  final String url;

  const _SocialButton({required this.icon, required this.url});

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton> {
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
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            gradient: _isHovered ? AppColors.primaryGradient : null,
            color: _isHovered ? null : AppColors.surface,
            shape: BoxShape.circle,
            border: Border.all(
              color: _isHovered ? Colors.transparent : AppColors.glassBorder,
              width: 1.5,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: FaIcon(widget.icon, size: 20, color: AppColors.textPrimary),
          ),
        ),
      ),
    );
  }
}

class _FloatingWidget extends StatefulWidget {
  final Widget child;
  const _FloatingWidget({required this.child});

  @override
  State<_FloatingWidget> createState() => _FloatingWidgetState();
}

class _FloatingWidgetState extends State<_FloatingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 15).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _animation.value),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

class _TypewriterText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final bool isDesktop;

  const _TypewriterText({
    required this.text,
    required this.style,
    required this.isDesktop,
  });

  @override
  State<_TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<_TypewriterText> {
  String _displayedText = '';

  @override
  void initState() {
    super.initState();
    _startTyping();
  }

  void _startTyping() async {
    for (int i = 0; i < widget.text.length; i++) {
      if (!mounted) return;
      await Future.delayed(const Duration(milliseconds: 100));
      setState(() {
        _displayedText = widget.text.substring(0, i + 1);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => AppColors.primaryGradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        _displayedText,
        style: widget.style.copyWith(color: Colors.white),
        textAlign: widget.isDesktop ? TextAlign.start : TextAlign.center,
      ),
    );
  }
}
