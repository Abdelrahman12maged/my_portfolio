import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_spacing.dart';
import 'video_player_widget.dart';

/// Enhanced project detail modal with professional image gallery
class ProjectDetailModal extends StatefulWidget {
  final String title;
  final String description;
  final List<String> technologies;
  final List<String> imageAssets;
  final String? videoAsset;

  const ProjectDetailModal({
    super.key,
    required this.title,
    required this.description,
    required this.technologies,
    required this.imageAssets,
    this.videoAsset,
  });

  @override
  State<ProjectDetailModal> createState() => _ProjectDetailModalState();
}

class _ProjectDetailModalState extends State<ProjectDetailModal> {
  int _currentImageIndex = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1000, maxHeight: 750),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.primary, width: 2),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.3),
              blurRadius: 40,
              spreadRadius: 10,
            ),
          ],
        ),
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(22),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.title,
                      style: AppTextStyles.headlineMedium.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const FaIcon(
                      FontAwesomeIcons.xmark,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ],
              ),
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.xl),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Description
                    Text(widget.description, style: AppTextStyles.bodyLarge),
                    const SizedBox(height: AppSpacing.lg),

                    // Technologies
                    Wrap(
                      spacing: AppSpacing.sm,
                      runSpacing: AppSpacing.sm,
                      children: widget.technologies.map((tech) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            gradient: AppColors.primaryGradient,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Text(
                            tech,
                            style: AppTextStyles.labelMedium.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: AppSpacing.xl),

                    // Video Player (if available)
                    if (widget.videoAsset != null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  gradient: AppColors.primaryGradient,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const FaIcon(
                                  FontAwesomeIcons.video,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: AppSpacing.sm),
                              Text(
                                'Demo Video',
                                style: AppTextStyles.titleLarge,
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.md),
                          VideoPlayerWidget(videoAsset: widget.videoAsset!),
                          const SizedBox(height: AppSpacing.xl),
                        ],
                      ),

                    // Image Gallery with Carousel
                    if (widget.imageAssets.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  gradient: AppColors.primaryGradient,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const FaIcon(
                                  FontAwesomeIcons.images,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: AppSpacing.sm),
                              Text(
                                'Screenshots Gallery',
                                style: AppTextStyles.titleLarge,
                              ),
                              const Spacer(),
                              Text(
                                '${_currentImageIndex + 1} / ${widget.imageAssets.length}',
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.md),

                          // Main Carousel
                          Container(
                            height: 450,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: AppColors.primary,
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primary.withOpacity(0.2),
                                  blurRadius: 20,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                // Image PageView
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(14),
                                  child: PageView.builder(
                                    controller: _pageController,
                                    onPageChanged: (index) {
                                      setState(() {
                                        _currentImageIndex = index;
                                      });
                                    },
                                    itemCount: widget.imageAssets.length,
                                    itemBuilder: (context, index) {
                                      return Image.asset(
                                        widget.imageAssets[index],
                                        fit: BoxFit.contain,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                              return Container(
                                                color: AppColors.surface,
                                                child: const Center(
                                                  child: FaIcon(
                                                    FontAwesomeIcons.image,
                                                    size: 64,
                                                    color:
                                                        AppColors.textTertiary,
                                                  ),
                                                ),
                                              );
                                            },
                                      );
                                    },
                                  ),
                                ),

                                // Navigation Arrows
                                if (widget.imageAssets.length > 1) ...[
                                  // Previous Button
                                  Positioned(
                                    left: 16,
                                    top: 0,
                                    bottom: 0,
                                    child: Center(
                                      child: _NavigationButton(
                                        icon: FontAwesomeIcons.chevronLeft,
                                        onPressed: _currentImageIndex > 0
                                            ? () {
                                                _pageController.previousPage(
                                                  duration: const Duration(
                                                    milliseconds: 300,
                                                  ),
                                                  curve: Curves.easeInOut,
                                                );
                                              }
                                            : null,
                                      ),
                                    ),
                                  ),
                                  // Next Button
                                  Positioned(
                                    right: 16,
                                    top: 0,
                                    bottom: 0,
                                    child: Center(
                                      child: _NavigationButton(
                                        icon: FontAwesomeIcons.chevronRight,
                                        onPressed:
                                            _currentImageIndex <
                                                widget.imageAssets.length - 1
                                            ? () {
                                                _pageController.nextPage(
                                                  duration: const Duration(
                                                    milliseconds: 300,
                                                  ),
                                                  curve: Curves.easeInOut,
                                                );
                                              }
                                            : null,
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                          const SizedBox(height: AppSpacing.md),

                          // Thumbnail Indicators
                          if (widget.imageAssets.length > 1)
                            Center(
                              child: Wrap(
                                spacing: AppSpacing.sm,
                                children: List.generate(
                                  widget.imageAssets.length,
                                  (index) {
                                    final isSelected =
                                        index == _currentImageIndex;
                                    return GestureDetector(
                                      onTap: () {
                                        _pageController.animateToPage(
                                          index,
                                          duration: const Duration(
                                            milliseconds: 300,
                                          ),
                                          curve: Curves.easeInOut,
                                        );
                                      },
                                      child: AnimatedContainer(
                                        duration: const Duration(
                                          milliseconds: 200,
                                        ),
                                        width: isSelected ? 40 : 8,
                                        height: 8,
                                        decoration: BoxDecoration(
                                          gradient: isSelected
                                              ? AppColors.primaryGradient
                                              : null,
                                          color: isSelected
                                              ? null
                                              : AppColors.glassBorder,
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavigationButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback? onPressed;

  const _NavigationButton({required this.icon, this.onPressed});

  @override
  State<_NavigationButton> createState() => _NavigationButtonState();
}

class _NavigationButtonState extends State<_NavigationButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isEnabled = widget.onPressed != null;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            gradient: _isHovered && isEnabled
                ? AppColors.primaryGradient
                : null,
            color: !_isHovered || !isEnabled
                ? AppColors.surface.withOpacity(0.9)
                : null,
            shape: BoxShape.circle,
            border: Border.all(
              color: isEnabled ? AppColors.primary : AppColors.glassBorder,
              width: 2,
            ),
            boxShadow: _isHovered && isEnabled
                ? [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.4),
                      blurRadius: 12,
                      spreadRadius: 2,
                    ),
                  ]
                : null,
          ),
          child: FaIcon(
            widget.icon,
            color: _isHovered && isEnabled
                ? Colors.white
                : AppColors.textPrimary,
            size: 20,
          ),
        ),
      ),
    );
  }
}
