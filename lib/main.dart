import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/app_routes.dart';
import 'package:myportofolio_mobile/screens/education_form.dart';
import 'package:myportofolio_mobile/screens/experience_form.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: Colors.indigo,
      secondary: Colors.amber[700],
    );

    return MaterialApp(
      title: 'MyPortofolio',
      theme: ThemeData(
        colorScheme: colorScheme,
        appBarTheme: AppBarTheme(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
        ),
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.home,
      routes: {
        AppRoutes.home: (_) => const MyHomePage(),
        AppRoutes.projectForm: (_) => const ProjectFormPage(),
        AppRoutes.experienceForm: (_) => const ExperienceFormPage(),
        AppRoutes.educationForm: (_) => const EducationFormPage(),
      },
    );
  }
}
