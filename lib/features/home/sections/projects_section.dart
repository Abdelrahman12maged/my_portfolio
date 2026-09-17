import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/widgets/responsive_layout.dart';
import '../widgets/project_card.dart';

/// Comprehensive Projects showcase section with Flagship Spotlight
class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  // Project data for secondary grid
  static const List<Map<String, dynamic>> projects = [
    {
      'title': 'Waslni',
      'description':
          'Smart ride-hailing and carpooling platform featuring dynamic fare bidding, 3D turn-by-turn navigation, sub-second GPS live tracking via Firestore, real-time in-app chat, and geofencing. Built with Clean Architecture & BLoC.',
      'technologies': [
        'Flutter',
        'Clean Architecture',
        'Bloc/Cubit',
        'Google Maps',
        'Firebase',
      ],
      'coverImage': 'assets/images/waslni/app-showcase-mockup.png',
      'githubUrl': 'https://github.com/Abdelrahman12maged/waslni_dev',
      'category': 'Flagship Transportation',
    },
    {
      'title': 'Khadmaty',
      'description':
          'Full-stack marketplace connecting customers with verified local service providers. Clean Architecture with 3-layer separation, Repository Pattern, Dependency Injection using GetIt, and dual service types with Arabic/English localization.',
      'technologies': [
        'Flutter',
        'Firebase',
        'Bloc/Cubit',
        'GetIt',
        'Clean Architecture',
      ],
      'coverImage': 'assets/images/Khadamaty_images/1.png',
      'githubUrl': 'https://github.com/Abdelrahman12maged/khadamaty_app',
      'category': 'Marketplace & Services',
    },
    {
      'title': 'Hcc_Detector',
      'description':
          'AI-Powered HCC medical diagnosis application assisting physicians in detecting Hepatocellular Carcinoma. Trained on real CT scan images from Al-Rajhi Liver Hospital with a PyTorch deep learning backend.',
      'technologies': ['Flutter', 'PyTorch', 'AI/ML', 'Desktop'],
      'coverImage': 'assets/images/hcc_demo/1.png',
      'githubUrl': 'https://github.com/Abdelrahman12maged/hcc_detector',
      'category': 'Healthcare AI',
    },
    {
      'title': 'Rozewell Learning Center',
      'description':
          'Real-time student-teacher educational communication app serving 1,000+ active users. Features Firebase Cloud Messaging, multimedia support, and 10+ REST API integrations. 4.2+ star rating on Google Play.',
      'technologies': ['Flutter', 'Firebase', 'REST APIs', 'Bloc'],
      'coverImage': 'assets/images/Rozewailimages/unnamed.webp',
      'githubUrl':
          'https://play.google.com/store/apps/details?id=at.rozewail.rozewailapp',
      'category': 'EdTech (1000+ Users)',
    },
    {
      'title': 'Fix Notify OnePlus',
      'description':
          'Maintenance tracking application with custom Platform Channels for native SMS functionality. Built with Clean Architecture, BLoC, Firebase Auth & Firestore, and responsive Material 3 design.',
      'technologies': [
        'Flutter',
        'Platform Channels',
        'Firebase',
        'Clean Architecture',
      ],
      'coverImage': 'assets/images/fix_notify_images/1.png',
      'githubUrl':
          'https://github.com/Abdelrahman12maged/Fix_Notify_OnePlus_App',
      'category': 'Hardware & Native SMS',
    },
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
              _buildSectionHeader(),

              const SizedBox(height: 50),

              // 1. Waslni Spotlight Card (Flagship Highlight)
              const _WaslniSpotlightCard(),

              const SizedBox(height: 60),

              // Subheader for more projects
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'More Notable Projects',
                  style: AppTextStyles.headlineSmall.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // 2. Secondary Projects Grid (Remaining 4 projects)
              ResponsiveLayout(
                builder: (context, deviceType) {
                  final isMobile = deviceType == DeviceType.mobile;
                  final crossAxisCount = isMobile ? 1 : 2;
                  final aspectRatio = isMobile ? 1.05 : 1.35;

                  // We showcase the other 4 projects in the grid
                  final otherProjects = projects.sublist(1);

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      mainAxisSpacing: AppSpacing.xl,
                      crossAxisSpacing: AppSpacing.xl,
                      childAspectRatio: aspectRatio,
                    ),
                    itemCount: otherProjects.length,
                    itemBuilder: (context, index) {
                      final project = otherProjects[index];
                      return ProjectCard(
                        title: project['title'] as String,
                        description: project['description'] as String,
                        technologies: List<String>.from(
                          project['technologies'] as List,
                        ),
                        coverImage: project['coverImage'] as String,
                        githubUrl: project['githubUrl'] as String?,
                        category: project['category'] as String?,
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

  Widget _buildSectionHeader() {
    return Column(
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
            'PORTFOLIO SHOWCASE',
            style: AppTextStyles.labelSmall.copyWith(
              color: AppColors.primary,
              letterSpacing: 1.5,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Featured Works & Projects',
          style: AppTextStyles.displaySmall,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 620),
          child: Text(
            'Production applications crafted with clean code, robust state management, and real-time backend integrations.',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

/// Dedicated Flagship Spotlight Card for Waslni
class _WaslniSpotlightCard extends StatefulWidget {
  const _WaslniSpotlightCard();

  @override
  State<_WaslniSpotlightCard> createState() => _WaslniSpotlightCardState();
}

class _WaslniSpotlightCardState extends State<_WaslniSpotlightCard> {
  bool _isHovered = false;

  Future<void> _openGithub() async {
    final uri = Uri.parse('https://github.com/Abdelrahman12maged/waslni_dev');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      builder: (context, deviceType) {
        final isDesktop = deviceType == DeviceType.desktop;

        return MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            transform: Matrix4.translationValues(
              0.0,
              _isHovered ? -4.0 : 0.0,
              0.0,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF0F172A).withValues(alpha: 0.95),
                  const Color(0xFF162033).withValues(alpha: 0.95),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(28),
              border: Border.all(
                color: _isHovered
                    ? AppColors.primary.withValues(alpha: 0.65)
                    : Colors.white.withValues(alpha: 0.12),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: _isHovered
                      ? AppColors.primary.withValues(alpha: 0.25)
                      : Colors.black.withValues(alpha: 0.5),
                  blurRadius: _isHovered ? 40 : 25,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            padding: EdgeInsets.all(isDesktop ? 36 : 24),
            child: isDesktop
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Text Info Column
                      Expanded(
                        flex: 6,
                        child: _buildDetailsColumn(context),
                      ),
                      const SizedBox(width: 40),
                      // Image Showcase Column
                      Expanded(
                        flex: 5,
                        child: _buildImagePreview(),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      _buildImagePreview(),
                      const SizedBox(height: 28),
                      _buildDetailsColumn(context),
                    ],
                  ),
          ),
        );
      },
    );
  }

  Widget _buildDetailsColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Flagship Pill Badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.35),
                blurRadius: 12,
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.stars_rounded, size: 16, color: Color(0xFF070B14)),
              SizedBox(width: 6),
              Text(
                'FEATURED FLAGSHIP PLATFORM',
                style: TextStyle(
                  color: Color(0xFF070B14),
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.8,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Title
        Text(
          'Waslni — Smart Ride-Hailing & Carpooling',
          style: AppTextStyles.headlineMedium.copyWith(
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),

        const SizedBox(height: 12),

        // Overview
        Text(
          'An enterprise-grade, high-performance Flutter mobile application connecting passengers and drivers through on-demand taxi bidding and shared carpooling seats with sub-second GPS live telemetry.',
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
            height: 1.6,
          ),
        ),

        const SizedBox(height: 20),

        // 4 Key Highlight Bullets
        _buildHighlightItem(
          FontAwesomeIcons.gavel,
          'Dynamic Fare Bidding',
          'Passengers receive competing real-time price offers from nearby drivers.',
        ),
        const SizedBox(height: 10),
        _buildHighlightItem(
          FontAwesomeIcons.mapLocationDot,
          '3D Turn-by-Turn GPS Navigation',
          'Heading bearing camera with 0ms polyline trimming & dual OSRM fallback.',
        ),
        const SizedBox(height: 10),
        _buildHighlightItem(
          FontAwesomeIcons.bolt,
          'Sub-Second Telemetry & Chat',
          'Low-latency Cloud Firestore vehicle broadcasting and real-time in-app chat.',
        ),
        const SizedBox(height: 10),
        _buildHighlightItem(
          FontAwesomeIcons.layerGroup,
          'Clean Architecture & BLoC',
          'Domain/Data/Presentation separation with 100% testability and GetIt DI.',
        ),

        const SizedBox(height: 24),

        // Tech chips
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            'Flutter 3.x',
            'Dart',
            'Clean Architecture',
            'BLoC / Cubit',
            'Google Maps',
            'Firebase Firestore',
            'FCM Alerts',
            'OSRM Fallback',
          ].map((tech) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.12),
                ),
              ),
              child: Text(
                tech,
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.primaryLight,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }).toList(),
        ),

        const SizedBox(height: 28),

        // GitHub CTA Button
        ElevatedButton.icon(
          onPressed: _openGithub,
          icon: const FaIcon(FontAwesomeIcons.github, size: 18),
          label: const Text('View Full Repository & Architecture'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: const Color(0xFF070B14),
            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            elevation: 0,
            textStyle: AppTextStyles.button.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHighlightItem(IconData icon, String title, String subtitle) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 2),
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(8),
          ),
          child: FaIcon(icon, size: 13, color: AppColors.primary),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: RichText(
            text: TextSpan(
              text: '$title — ',
              style: AppTextStyles.bodySmall.copyWith(
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
              children: [
                TextSpan(
                  text: subtitle,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImagePreview() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.15),
            blurRadius: 30,
            spreadRadius: 2,
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Image.asset(
        'assets/images/waslni/app-showcase-mockup.png',
        fit: BoxFit.contain,
      ),
    );
  }
}
