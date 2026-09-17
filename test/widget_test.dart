import 'package:flutter_test/flutter_test.dart';
import 'package:my_portfolio/features/home/sections/projects_section.dart';

void main() {
  test('Projects list includes Waslni project', () {
    final waslni = ProjectsSection.projects.firstWhere(
      (p) => p['title'] == 'Waslni',
    );
    expect(waslni['title'], 'Waslni');
    expect(waslni['coverImage'], 'assets/images/waslni/app-showcase-mockup.png');
    expect(waslni['githubUrl'], 'https://github.com/Abdelrahman12maged/waslni_dev');
  });
}
