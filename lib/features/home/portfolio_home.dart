import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/widgets/responsive_layout.dart';
import 'sections/hero_section.dart';
import 'sections/skills_section.dart';
import 'sections/projects_section.dart';
import 'sections/education_section.dart';
import 'sections/contact_section.dart';
import 'widgets/navigation_bar.dart';

/// Main portfolio home page with atmospheric background lighting & scroll management
class PortfolioHome extends StatefulWidget {
  const PortfolioHome({super.key});

  @override
  State<PortfolioHome> createState() => _PortfolioHomeState();
}

class _PortfolioHomeState extends State<PortfolioHome> {
  final ScrollController _scrollController = ScrollController();
  int _currentSection = 0;
  bool _showBackToTop = false;

  final List<GlobalKey> _sectionKeys = List.generate(5, (index) => GlobalKey());

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final offset = _scrollController.offset;
    if (offset > 400 && !_showBackToTop) {
      setState(() => _showBackToTop = true);
    } else if (offset <= 400 && _showBackToTop) {
      setState(() => _showBackToTop = false);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSection(int index) {
    if (index < _sectionKeys.length &&
        _sectionKeys[index].currentContext != null) {
      final context = _sectionKeys[index].currentContext!;
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 750),
        curve: Curves.easeInOutCubic,
      );
      setState(() {
        _currentSection = index;
      });
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 750),
      curve: Curves.easeInOutCubic,
    );
    setState(() => _currentSection = 0);
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: isMobile
          ? MobileDrawer(
              onNavigate: _scrollToSection,
              currentIndex: _currentSection,
            )
          : null,
      floatingActionButton: _showBackToTop
          ? FloatingActionButton.small(
              onPressed: _scrollToTop,
              backgroundColor: AppColors.primary,
              foregroundColor: const Color(0xFF070B14),
              elevation: 4,
              tooltip: 'Back to top',
              child: const Icon(Icons.arrow_upward_rounded, size: 18),
            )
          : null,
      body: Stack(
        children: [
          // Background Atmospheric Mesh Lighting
          Positioned(
            top: -150,
            left: -150,
            child: Container(
              width: 500,
              height: 500,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.primary.withValues(alpha: 0.12),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 400,
            right: -200,
            child: Container(
              width: 600,
              height: 600,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.accentIndigo.withValues(alpha: 0.1),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 200,
            left: -100,
            child: Container(
              width: 500,
              height: 500,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.accentViolet.withValues(alpha: 0.08),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // Main scrollable content
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              // Mobile Top Navigation Bar
              if (isMobile)
                SliverToBoxAdapter(
                  child: PortfolioNavigationBar(
                    onNavigate: _scrollToSection,
                    currentIndex: _currentSection,
                  ),
                ),

              // Hero Section
              SliverToBoxAdapter(
                child: Container(
                  key: _sectionKeys[0],
                  child: HeroSection(
                    onProjectsPressed: () => _scrollToSection(2),
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

          // Floating Desktop Island Navigation Bar
          if (!isMobile)
            Positioned(
              top: 0,
              left: 0,
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
