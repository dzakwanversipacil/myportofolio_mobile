import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/app_routes.dart';
import 'package:myportofolio_mobile/screens/experience_form.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:myportofolio_mobile/widgets/project_card.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  static const String npm = '2506123456';
  static const String nama = 'Moyai Taraki';
  static const String kelas = 'PBP F';

  static const List<ItemHomepage> items = [
    ItemHomepage('Lihat Proyek', Icons.folder, Colors.blue),
    ItemHomepage(
      'Tambah Proyek',
      Icons.add_circle,
      Colors.green,
      routeName: AppRoutes.projectForm,
      destination: ProjectFormPage(),
    ),
    ItemHomepage(
      'Tambah Pengalaman',
      Icons.work_history_outlined,
      Colors.deepPurple,
      routeName: AppRoutes.experienceForm,
      destination: ExperienceFormPage(),
    ),
    ItemHomepage('Logout', Icons.logout, Colors.red),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MyPortfolio',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      drawer: const LeftDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isCompact = constraints.maxWidth < 600;
              final infoCardWidth = isCompact
                  ? constraints.maxWidth
                  : (constraints.maxWidth - 24) / 3;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    alignment: WrapAlignment.center,
                    children: [
                      InfoCard(
                        title: 'NPM',
                        content: npm,
                        width: infoCardWidth,
                      ),
                      InfoCard(
                        title: 'Name',
                        content: nama,
                        width: infoCardWidth,
                      ),
                      InfoCard(
                        title: 'Class',
                        content: kelas,
                        width: infoCardWidth,
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'Selamat datang di MyPortfolio Mobile!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    crossAxisCount: isCompact ? 2 : 4,
                    childAspectRatio: isCompact ? 1.35 : 1.15,
                    shrinkWrap: true,
                    children: items.map((item) => ItemCard(item)).toList(),
                  ),
                ],
              );
            },
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
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(content),
            ],
          ),
        ),
      ),
    );
  }
}
