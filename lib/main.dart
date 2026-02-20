import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'models/app_settings.dart';
import 'screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const MahabharataWisdomApp());
}

class MahabharataWisdomApp extends StatelessWidget {
  const MahabharataWisdomApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppSettings(),
      child: Consumer<AppSettings>(
        builder: (context, settings, _) {
          final brightness = settings.theme == AppTheme.system
              ? MediaQuery.of(context).platformBrightness
              : (settings.theme == AppTheme.dark ? Brightness.dark : Brightness.light);

          return MaterialApp(
            title: 'Mahabharata Wisdom',
            debugShowCheckedModeBanner: false,
            theme: _buildTheme(Brightness.light),
            darkTheme: _buildTheme(Brightness.dark),
            themeMode: settings.theme == AppTheme.system
                ? ThemeMode.system
                : (settings.theme == AppTheme.dark ? ThemeMode.dark : ThemeMode.light),
            home: const HomeScreen(),
          );
        },
      ),
    );
  }

  ThemeData _buildTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.deepOrange,
        brightness: brightness,
        primary: Colors.deepOrange,
        secondary: Colors.amber,
      ),
      scaffoldBackgroundColor: isDark ? Colors.grey.shade900 : Colors.orange.shade50,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      cardTheme: CardThemeData(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: isDark ? Colors.grey.shade900 : Colors.white,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepOrange,
          foregroundColor: Colors.white,
          elevation: 4,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: Colors.deepOrange,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.deepOrange, width: 2),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
        thickness: 1,
      ),
      iconTheme: IconThemeData(
        color: isDark ? Colors.orange.shade300 : Colors.deepOrange.shade700,
      ),
    );
  }
}
