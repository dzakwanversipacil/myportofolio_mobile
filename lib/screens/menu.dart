import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/app_routes.dart';
import 'package:myportofolio_mobile/screens/education_form.dart';
import 'package:myportofolio_mobile/screens/experience_form.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';
import 'package:myportofolio_mobile/theme/portfolio_theme.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:myportofolio_mobile/widgets/project_card.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  static const String npm = '2506612436';
  static const String nama = 'Dzakwan Farabi Al Muzhaffar';
  static const String program = 'S1 Sistem Informasi';
  static const String bio =
      'Undergraduate student at the Faculty of Computer Science. '
      'Actively engaged in coursework related to information systems '
      'architecture, programming, and data science.';

  static const List<ItemHomepage> items = [
    ItemHomepage(
      'Lihat Proyek',
      Icons.folder_outlined,
      PortfolioTheme.accentDark,
    ),
    ItemHomepage(
      'Tambah Proyek',
      Icons.add_circle,
      PortfolioTheme.accent,
      routeName: AppRoutes.projectForm,
      destination: ProjectFormPage(),
    ),
    ItemHomepage(
      'Tambah Pengalaman',
      Icons.work_history_outlined,
      PortfolioTheme.accent,
      routeName: AppRoutes.experienceForm,
      destination: ExperienceFormPage(),
    ),
    ItemHomepage(
      'Tambah Pendidikan',
      Icons.school_outlined,
      PortfolioTheme.accent,
      routeName: AppRoutes.educationForm,
      destination: EducationFormPage(),
    ),
    ItemHomepage('Logout', Icons.logout, PortfolioTheme.danger),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(nama, maxLines: 1, overflow: TextOverflow.ellipsis),
      ),
      drawer: const LeftDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 900),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final isCompact = constraints.maxWidth < 600;
                  final infoCardWidth = isCompact
                      ? constraints.maxWidth
                      : (constraints.maxWidth - 12) / 2;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'INFORMATION SYSTEMS · UNIVERSITAS INDONESIA',
                        style: TextStyle(
                          color: PortfolioTheme.accentDark,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.1,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        nama,
                        style: Theme.of(context).textTheme.displaySmall
                            ?.copyWith(
                              color: PortfolioTheme.ink,
                              fontWeight: FontWeight.w700,
                              height: 1.05,
                            ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        bio,
                        style: TextStyle(
                          color: PortfolioTheme.textMuted,
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: [
                          InfoCard(
                            title: 'NPM',
                            content: npm,
                            width: infoCardWidth,
                          ),
                          InfoCard(
                            title: 'PROGRAM',
                            content: program,
                            width: infoCardWidth,
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 32),
                        child: Divider(),
                      ),
                      Text(
                        'Portfolio Actions',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Selamat datang di MyPortfolio Mobile!',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: PortfolioTheme.textMuted),
                      ),
                      GridView.count(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        crossAxisCount: isCompact ? 2 : 3,
                        childAspectRatio: isCompact ? 1.35 : 1.7,
                        shrinkWrap: true,
                        children: items.map((item) => ItemCard(item)).toList(),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key,
    required this.title,
    required this.content,
    required this.width,
  });

  final String title;
  final String content;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: SizedBox(
        width: width,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: PortfolioTheme.textMuted,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.8,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                content,
                style: const TextStyle(
                  color: PortfolioTheme.ink,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
