import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/home/widgets/loading_screen.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Abdelrahman Abdelmaged - Flutter Developer',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const LoadingScreen(),
    );
  }
}
