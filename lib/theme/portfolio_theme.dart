import 'package:material_ui/material_ui.dart';

abstract final class PortfolioTheme {
  static const ink = Color(0xFF1C1917);
  static const paper = Color(0xFFB0C4DE);
  static const cardBackground = Color(0xFFFFFFFF);
  static const accent = Color(0xFF4682B4);
  static const accentDark = Color(0xFF1B2A4A);
  static const line = Color(0xFF8FA4C4);
  static const textMuted = Color(0xFF4A5568);
  static const danger = Color(0xFFB42318);
  static const radius = 4.0;

  static ThemeData get lightTheme {
    final colorScheme =
        ColorScheme.fromSeed(
          seedColor: accent,
          brightness: Brightness.light,
        ).copyWith(
          primary: accent,
          onPrimary: cardBackground,
          secondary: ink,
          onSecondary: cardBackground,
          surface: cardBackground,
          onSurface: ink,
          error: danger,
          outline: line,
        );

    const roundedRectangle = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: paper,
      dividerColor: line,
      appBarTheme: const AppBarTheme(
        backgroundColor: paper,
        foregroundColor: ink,
        elevation: 0,
        scrolledUnderElevation: 0,
        shape: Border(bottom: BorderSide(color: line)),
        titleTextStyle: TextStyle(
          color: ink,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
      cardTheme: const CardThemeData(
        color: cardBackground,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          side: BorderSide(color: line),
        ),
      ),
      drawerTheme: const DrawerThemeData(
        backgroundColor: paper,
        shape: RoundedRectangleBorder(),
      ),
      listTileTheme: const ListTileThemeData(
        iconColor: textMuted,
        textColor: ink,
        selectedColor: accentDark,
        selectedTileColor: cardBackground,
        shape: roundedRectangle,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: cardBackground,
        labelStyle: TextStyle(color: accentDark, fontWeight: FontWeight.w600),
        hintStyle: TextStyle(color: textMuted),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          borderSide: BorderSide(color: accent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          borderSide: BorderSide(color: accent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          borderSide: BorderSide(color: accent, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          borderSide: BorderSide(color: danger),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          borderSide: BorderSide(color: danger, width: 2),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: accent,
          foregroundColor: cardBackground,
          shape: roundedRectangle,
          textStyle: const TextStyle(fontWeight: FontWeight.w700),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accent,
          foregroundColor: cardBackground,
          elevation: 0,
          shape: roundedRectangle,
          textStyle: const TextStyle(fontWeight: FontWeight.w700),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: accentDark,
          shape: roundedRectangle,
          textStyle: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      dialogTheme: const DialogThemeData(
        backgroundColor: paper,
        shape: roundedRectangle,
        titleTextStyle: TextStyle(
          color: ink,
          fontSize: 22,
          fontWeight: FontWeight.w700,
        ),
      ),
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: cardBackground,
        contentTextStyle: TextStyle(color: ink),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          side: BorderSide(color: line),
        ),
      ),
    );
  }
}
