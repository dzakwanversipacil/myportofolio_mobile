import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/app_routes.dart';
import 'package:myportofolio_mobile/screens/education_form.dart';
import 'package:myportofolio_mobile/screens/experience_form.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/theme/portfolio_theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp(apiClient: ApiClient()));
}

class MyApp extends StatelessWidget {
  const MyApp({required this.apiClient, super.key});

  final ApiClient apiClient;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // MultiProvider wraps the app and injects a collection of Provider objects.
    // We usually use Provider object to pass one or more frequently reused objects such as API client or authentication state to the widgets in the tree.
    return MultiProvider(
      providers: [
        Provider.value(value: apiClient),
        ChangeNotifierProvider(create: (_) => AuthState(apiClient)),
      ],
      child: MaterialApp(
        title: 'Dzakwan Farabi Al Muzhaffar - Portofolio',
        theme: PortfolioTheme.lightTheme,
        initialRoute: AppRoutes.home,
        routes: {
          AppRoutes.home: (_) => const MyHomePage(),
          AppRoutes.projectForm: (_) => const ProjectFormPage(),
          AppRoutes.experienceForm: (_) => const ExperienceFormPage(),
          AppRoutes.educationForm: (_) => const EducationFormPage(),
        },
      ),
    );
  }
}
