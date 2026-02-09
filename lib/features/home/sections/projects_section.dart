import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/widgets/responsive_layout.dart';
import '../widgets/project_card.dart';

/// Projects showcase section
class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  // Project data with all images
  static const List<Map<String, dynamic>> projects = [
    {
      'title': 'Khadmaty',
      'description':
          'Full-stack marketplace application using Clean Architecture and Repository Pattern with advanced state management.',
      'technologies': ['Flutter', 'Clean Architecture', 'Bloc', 'Firebase'],
      'images': [
        'assets/images/Khadamaty_images/1.jpeg',
        'assets/images/Khadamaty_images/2.jpeg',
        'assets/images/Khadamaty_images/3.jpeg',
        'assets/images/Khadamaty_images/4.jpeg',
        'assets/images/Khadamaty_images/5.jpeg',
        'assets/images/Khadamaty_images/6.jpeg',
        'assets/images/Khadamaty_images/7.jpeg',
        'assets/images/Khadamaty_images/8.jpeg',
        'assets/images/Khadamaty_images/9.jpeg',
        'assets/images/Khadamaty_images/10.jpeg',
      ],
    },
    {
      'title': 'Hcc_Detector',
      'description':
          'AI-Powered diagnosis tool for hepatocellular carcinoma detection. Built for Desktop and Web using Flutter and PyTorch.',
      'technologies': ['Flutter', 'PyTorch', 'AI/ML', 'Desktop'],
      'images': [],
      'video': 'assets/images/hcc_demo/hcc.mp4',
    },
    {
      'title': 'Rozewell Learning Center',
      'description':
          'Real-time communication and learning management app with 1000+ active users. Features live chat and course management.',
      'technologies': ['Flutter', 'Firebase', 'Real-time', 'Bloc'],
      'images': [
        'assets/images/Rozewailimages/WhatsApp Image 2024-07-14 at 2.34.28 PM.jpg',
        'assets/images/Rozewailimages/WhatsApp Image 2024-07-14 at 2.34.28 PM (1).jpeg',
        'assets/images/Rozewailimages/WhatsApp Image 2024-07-14 at 2.34.28 PM (2).jpeg',
        'assets/images/Rozewailimages/WhatsApp Image 2024-07-14 at 2.34.28 PM (2).jpg',
        'assets/images/Rozewailimages/WhatsApp Image 2024-07-14 at 2.34.27 PM (1).jpg',
        'assets/images/Rozewailimages/unnamed.webp',
      ],
    },
    {
      'title': 'Fix Notify OnePlus',
      'description':
          'Maintenance tracking application with custom Platform Channels for native Android integration and notifications.',
      'technologies': [
        'Flutter',
        'Platform Channels',
        'Android',
        'Notifications',
      ],
      'images': [
        'assets/images/fix_notify_images/0.png',
        'assets/images/fix_notify_images/1.png',
        'assets/images/fix_notify_images/2.png',
        'assets/images/fix_notify_images/3.png',
        'assets/images/fix_notify_images/4.png',
        'assets/images/fix_notify_images/5.png',
        'assets/images/fix_notify_images/6.png',
        'assets/images/fix_notify_images/7.png',
        'assets/images/fix_notify_images/8.png',
      ],
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
                  switch (deviceType) {
                    case DeviceType.mobile:
                      crossAxisCount = 1;
                      break;
                    case DeviceType.tablet:
                      crossAxisCount = 2;
                      break;
                    case DeviceType.desktop:
                      crossAxisCount = 2;
                      break;
                  }

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      mainAxisSpacing: AppSpacing.lg,
                      crossAxisSpacing: AppSpacing.lg,
                      childAspectRatio: 0.85,
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
                        imageAssets: List<String>.from(
                          project['images'] as List,
                        ),
                        videoAsset: project['video'] as String?,
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
