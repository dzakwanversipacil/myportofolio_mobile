import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/theme/portfolio_theme.dart';

class ItemHomepage {
  const ItemHomepage(
    this.name,
    this.icon,
    this.color, {
    this.routeName,
    this.destination,
  });

  final String name;
  final IconData icon;
  final Color color;
  final String? routeName;
  final Widget? destination;
}

class ItemCard extends StatelessWidget {
  final ItemHomepage item;

  const ItemCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: PortfolioTheme.cardBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(PortfolioTheme.radius)),
        side: BorderSide(color: PortfolioTheme.line),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(PortfolioTheme.radius),
        // Area responsif terhadap sentuhan
        onTap: () {
          if (item.destination != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                settings: RouteSettings(name: item.routeName),
                builder: (_) => item.destination!,
              ),
            );
            return;
          }

          // Memunculkan SnackBar ketika diklik
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text("Kamu telah menekan tombol ${item.name}!"),
              ),
            );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: item.color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(PortfolioTheme.radius),
                ),
                child: Icon(item.icon, color: item.color, size: 26),
              ),
              const SizedBox(height: 10),
              Text(
                item.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: PortfolioTheme.ink,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
