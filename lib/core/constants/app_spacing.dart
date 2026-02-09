/// Responsive spacing constants
class AppSpacing {
  // Base spacing unit
  static const double base = 8.0;

  // Spacing scale
  static const double xs = base * 0.5; // 4
  static const double sm = base; // 8
  static const double md = base * 2; // 16
  static const double lg = base * 3; // 24
  static const double xl = base * 4; // 32
  static const double xxl = base * 6; // 48
  static const double xxxl = base * 8; // 64

  // Section spacing
  static const double sectionVertical = xxxl * 2; // 128
  static const double sectionHorizontal = xxl; // 48

  // Layout breakpoints
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 900;
  static const double desktopBreakpoint = 1200;

  // Container constraints
  static const double maxContentWidth = 1200;
  static const double sidebarWidth = 280;
}
