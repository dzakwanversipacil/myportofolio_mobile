import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/app_routes.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  void _openRoute(BuildContext context, String routeName) {
    final currentRoute = ModalRoute.of(context)?.settings.name;
    final navigator = Navigator.of(context);
    navigator.pop();

    if (currentRoute == routeName) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (routeName == AppRoutes.home) {
        navigator.pushNamedAndRemoveUntil(routeName, (route) => false);
      } else {
        navigator.pushNamed(routeName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.indigo),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'My Portfolio',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Expanded(
                  child: Text(
                    'Explore personal projects and experiences!',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            selected: currentRoute == AppRoutes.home,
            onTap: () => _openRoute(context, AppRoutes.home),
          ),
          ListTile(
            leading: const Icon(Icons.add_circle_outline),
            title: const Text('Add Project'),
            selected: currentRoute == AppRoutes.projectForm,
            onTap: () => _openRoute(context, AppRoutes.projectForm),
          ),
          ListTile(
            leading: const Icon(Icons.work_history_outlined),
            title: const Text('Add Experience'),
            selected: currentRoute == AppRoutes.experienceForm,
            onTap: () => _openRoute(context, AppRoutes.experienceForm),
          ),
        ],
      ),
    );
  }
}
