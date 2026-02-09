import 'package:flutter/material.dart';
import '../constants/app_spacing.dart';

enum DeviceType { mobile, tablet, desktop }

/// Responsive layout builder widget
class ResponsiveLayout extends StatelessWidget {
  final Widget Function(BuildContext context, DeviceType deviceType) builder;

  const ResponsiveLayout({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final deviceType = _getDeviceType(constraints.maxWidth);
        return builder(context, deviceType);
      },
    );
  }

  static DeviceType _getDeviceType(double width) {
    if (width < AppSpacing.mobileBreakpoint) {
      return DeviceType.mobile;
    } else if (width < AppSpacing.tabletBreakpoint) {
      return DeviceType.tablet;
    } else {
      return DeviceType.desktop;
    }
  }

  static DeviceType getDeviceType(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return _getDeviceType(width);
  }

  static bool isMobile(BuildContext context) {
    return getDeviceType(context) == DeviceType.mobile;
  }

  static bool isTablet(BuildContext context) {
    return getDeviceType(context) == DeviceType.tablet;
  }

  static bool isDesktop(BuildContext context) {
    return getDeviceType(context) == DeviceType.desktop;
  }

  static double getResponsivePadding(BuildContext context) {
    final deviceType = getDeviceType(context);
    switch (deviceType) {
      case DeviceType.mobile:
        return AppSpacing.md;
      case DeviceType.tablet:
        return AppSpacing.lg;
      case DeviceType.desktop:
        return AppSpacing.xxl;
    }
  }
}
