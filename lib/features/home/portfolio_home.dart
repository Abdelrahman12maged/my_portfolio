import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/widgets/responsive_layout.dart';
import 'sections/hero_section.dart';
import 'sections/skills_section.dart';
import 'sections/projects_section.dart';
import 'sections/education_section.dart';
import 'sections/contact_section.dart';
import 'widgets/navigation_bar.dart';

/// Main portfolio home page
class PortfolioHome extends StatefulWidget {
  const PortfolioHome({super.key});

  @override
  State<PortfolioHome> createState() => _PortfolioHomeState();
}

class _PortfolioHomeState extends State<PortfolioHome> {
  final ScrollController _scrollController = ScrollController();
  int _currentSection = 0;

  final List<GlobalKey> _sectionKeys = List.generate(6, (index) => GlobalKey());

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSection(int index) {
    if (index < _sectionKeys.length &&
        _sectionKeys[index].currentContext != null) {
      final context = _sectionKeys[index].currentContext!;
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
      setState(() {
        _currentSection = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: ResponsiveLayout.isMobile(context)
          ? MobileDrawer(
              onNavigate: _scrollToSection,
              currentIndex: _currentSection,
            )
          : null,
      body: Stack(
        children: [
          // Background gradient overlay
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: const Alignment(0.0, -0.5),
                radius: 1.5,
                colors: [
                  AppColors.primary.withOpacity(0.05),
                  AppColors.background,
                ],
              ),
            ),
          ),

          // Main content
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              // Hero Section
              SliverToBoxAdapter(
                child: Container(
                  key: _sectionKeys[0],
                  child: HeroSection(
                    onProjectsPressed: () => _scrollToSection(3),
                  ),
                ),
              ),

              // Skills Section
              SliverToBoxAdapter(
                child: Container(
                  key: _sectionKeys[1],
                  child: const SkillsSection(),
                ),
              ),

              // Projects Section
              SliverToBoxAdapter(
                child: Container(
                  key: _sectionKeys[2],
                  child: const ProjectsSection(),
                ),
              ),

              // Education Section
              SliverToBoxAdapter(
                child: Container(
                  key: _sectionKeys[3],
                  child: const EducationSection(),
                ),
              ),

              // Contact Section
              SliverToBoxAdapter(
                child: Container(
                  key: _sectionKeys[4],
                  child: const ContactSection(),
                ),
              ),
            ],
          ),

          // Floating Navigation Bar (Overlay at top)
          if (!ResponsiveLayout.isMobile(context))
            Positioned(
              top: 0,
            left:0,
              right: 0,
              child: PortfolioNavigationBar(
                onNavigate: _scrollToSection,
                currentIndex: _currentSection,
              ),
            ),
        ],
      ),
    );
  }
}
