import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/app_routes.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/theme/portfolio_theme.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:provider/provider.dart';

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
    final isLoggedIn = context.watch<AuthState>().isLoggedIn;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: PortfolioTheme.paper,
              border: Border(bottom: BorderSide(color: PortfolioTheme.line)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Dzakwan Farabi\nAl Muzhaffar',
                  style: TextStyle(
                    fontSize: 22,
                    height: 1.1,
                    fontWeight: FontWeight.bold,
                    color: PortfolioTheme.ink,
                  ),
                ),
                SizedBox(height: 8),
                Expanded(
                  child: Text(
                    'Information Systems · Universitas Indonesia',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      color: PortfolioTheme.textMuted,
                    ),
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
            onTap: () async {
              final loggedIn = await ensureLoggedIn(context);
              if (!loggedIn || !context.mounted) return;
              _openRoute(context, AppRoutes.projectForm);
            },
          ),
          ListTile(
            leading: const Icon(Icons.work_history_outlined),
            title: const Text('Add Experience'),
            selected: currentRoute == AppRoutes.experienceForm,
            onTap: () => _openRoute(context, AppRoutes.experienceForm),
          ),
          ListTile(
            leading: const Icon(Icons.school_outlined),
            title: const Text('Add Education'),
            selected: currentRoute == AppRoutes.educationForm,
            onTap: () => _openRoute(context, AppRoutes.educationForm),
          ),
          if (!isLoggedIn)
            ListTile(
              leading: const Icon(Icons.login),
              title: const Text('Login'),
              onTap: () async {
                final loggedIn = await ensureLoggedIn(context);
                if (!loggedIn || !context.mounted) return;
                Navigator.pop(context);
              },
            )
          else
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () async {
                await context.read<AuthState>().logout();
                if (!context.mounted) return;
                Navigator.pop(context);
              },
            ),
        ],
      ),
    );
  }
}
