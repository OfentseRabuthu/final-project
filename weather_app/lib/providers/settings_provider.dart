import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/settings.dart';

class SettingsProvider with ChangeNotifier {
  Settings _settings = Settings();

  Settings get settings => _settings;

  SettingsProvider() {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _settings = Settings(
      useCelsius: prefs.getBool('useCelsius') ?? true,
      enableNotifications: prefs.getBool('enableNotifications') ?? true,
      useDarkMode: prefs.getBool('useDarkMode') ?? false,
      locale: prefs.getString('locale') ?? 'en',
    );
    notifyListeners();
  }

  Future<void> updateSettings(Settings newSettings) async {
    _settings = newSettings;
    notifyListeners();
    await _saveSettings();
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('useCelsius', _settings.useCelsius);
    await prefs.setBool('enableNotifications', _settings.enableNotifications);
    await prefs.setBool('useDarkMode', _settings.useDarkMode);
    await prefs.setString('locale', _settings.locale);
  }

  void changeLocale(String newLocale) {
    _settings = _settings.copyWith(locale: newLocale);
    notifyListeners();
    _saveSettings();
  }

  double convertTemperature(double celsius) {
    return _settings.useCelsius ? celsius : (celsius * 9 / 5) + 32;
  }

  String getTemperatureUnit() {
    return _settings.useCelsius ? '°C' : '°F';
  }
}