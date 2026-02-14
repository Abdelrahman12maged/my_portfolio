import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/widgets/responsive_layout.dart';
import '../widgets/project_card.dart';

/// Projects showcase section
class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  // Project data
  static const List<Map<String, dynamic>> projects = [
    {
      'title': 'Khadmaty',
      'description':
          'Full-stack marketplace connecting customers with local service providers. Clean Architecture with 3-layer separation, Repository Pattern, Dependency Injection using GetIt, and dual service types with Arabic/English localization.',
      'technologies': [
        'Flutter',
        'Firebase',
        'Bloc/Cubit',
        'GetIt',
        'Clean Architecture'
      ],
      'coverImage': 'assets/images/Khadamaty_images/1.png',
      'githubUrl': 'https://github.com/Abdelrahman12maged/khadamaty_app',
    },
    {
      'title': 'Hcc_Detector',
      'description':
          'AI-Powered HCC diagnosis application assisting doctors in detecting Hepatocellular Carcinoma. Trained on real CT images from Al-Rajhi Liver Hospital with a PyTorch deep learning backend.',
      'technologies': ['Flutter', 'PyTorch', 'AI/ML', 'Desktop'],
      'coverImage': 'assets/images/hcc_demo/1.png',
      'githubUrl': 'https://github.com/Abdelrahman12maged/hcc_detector',
    },
    {
      'title': 'Rozewell Learning Center',
      'description':
          'Real-time student-teacher communication app serving 1000+ active users. Features Firebase Cloud Messaging, multimedia support, and 10+ REST API integrations. 4.2+ star rating on Google Play.',
      'technologies': ['Flutter', 'Firebase', 'REST APIs', 'Bloc'],
      'coverImage': 'assets/images/Rozewailimages/unnamed.webp',
      'githubUrl':
          'https://play.google.com/store/apps/details?id=at.rozewail.rozewailapp',
    },
    {
      'title': 'Fix Notify OnePlus',
      'description':
          'Maintenance tracking app with custom Platform Channels for native SMS functionality. Built with Clean Architecture, BLoC, Firebase Auth & Firestore, and responsive Material 3 design.',
      'technologies': [
        'Flutter',
        'Platform Channels',
        'Firebase',
        'Clean Architecture',
      ],
      'coverImage': 'assets/images/fix_notify_images/1.png',
      'githubUrl':
          'https://github.com/Abdelrahman12maged/Fix_Notify_OnePlus_App',
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
              // Section Title
              Text(
                'Featured Projects',
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

              // Projects Grid
              ResponsiveLayout(
                builder: (context, deviceType) {
                  int crossAxisCount;
                  double aspectRatio;
                  switch (deviceType) {
                    case DeviceType.mobile:
                      crossAxisCount = 1;
                      aspectRatio = 1.4;
                      break;
                    case DeviceType.tablet:
                      crossAxisCount = 2;
                      aspectRatio = 1.1;
                      break;
                    case DeviceType.desktop:
                      crossAxisCount = 2;
                      aspectRatio = 1.5;
                      break;
                  }

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      mainAxisSpacing: AppSpacing.lg,
                      crossAxisSpacing: AppSpacing.lg,
                      childAspectRatio: aspectRatio,
                    ),
                    itemCount: projects.length,
                    itemBuilder: (context, index) {
                      final project = projects[index];
                      return ProjectCard(
                        title: project['title'] as String,
                        description: project['description'] as String,
                        technologies: List<String>.from(
                          project['technologies'] as List,
                        ),
                        coverImage: project['coverImage'] as String,
                        githubUrl: project['githubUrl'] as String?,
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
