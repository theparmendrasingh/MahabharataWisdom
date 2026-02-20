import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';


enum AppLanguage { english, hindi }
enum FontSize { small, medium, large }
enum AppTheme { light, dark, system }

class AppSettings extends ChangeNotifier {

  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  set themeMode(ThemeMode mode) {
    if (_themeMode != mode) {
      _themeMode = mode;
      notifyListeners();
    }
  }

  AppLanguage _language = AppLanguage.english;
  FontSize _fontSize = FontSize.medium;
  AppTheme _theme = AppTheme.system;
  
  AppLanguage get language => _language;
  FontSize get fontSize => _fontSize;
  AppTheme get theme => _theme;

  String get languageCode => _language == AppLanguage.english ? 'en' : 'hi';

  double get fontSizeMultiplier {
    switch (_fontSize) {
      case FontSize.small:
        return 0.85;
      case FontSize.medium:
        return 1.0;
      case FontSize.large:
        return 1.2;
    }
  }

  AppSettings() {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _language = AppLanguage.values[prefs.getInt('language') ?? 0];
    _fontSize = FontSize.values[prefs.getInt('fontSize') ?? 1];
    _theme = AppTheme.values[prefs.getInt('theme') ?? 2]; // Default to system
    notifyListeners();
  }

  Future<void> setLanguage(AppLanguage language) async {
    _language = language;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('language', language.index);
    notifyListeners();
  }

  Future<void> setFontSize(FontSize fontSize) async {
    _fontSize = fontSize;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('fontSize', fontSize.index);
    notifyListeners();
  }

  Future<void> setTheme(AppTheme theme) async {
    _theme = theme;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('theme', theme.index);
    notifyListeners();
  }
}
