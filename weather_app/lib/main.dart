import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/weather_provider.dart';
import 'providers/settings_provider.dart';
import 'services/weather_service.dart';
import 'services/location_service.dart';
import 'services/notification_service.dart';
import 'screens/home_screen.dart';
import 'theme/app_theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => WeatherProvider(
            weatherService: WeatherService(),
            locationService: LocationService(),
            notificationService: NotificationService(),
          ),
        ),
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final settingsProvider = Provider.of<SettingsProvider>(context, listen: false);
      final locale = View.of(context).platformDispatcher.locales.first;      
      _handleLocaleChange(settingsProvider, locale);
    });
  }

  void _handleLocaleChange(SettingsProvider settingsProvider, Locale? locale) {
    final deviceLocale = Locale(locale?.languageCode ?? 'en');
    for (var supportedLocale in AppLocalizations.supportedLocales) {
      if (supportedLocale.languageCode == deviceLocale.languageCode) {
        settingsProvider.changeLocale(supportedLocale.languageCode);
        return;
      }
    }
    settingsProvider.changeLocale(AppLocalizations.supportedLocales.first.languageCode);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, settingsProvider, child) {
        return MaterialApp(
          title: 'WeatherState',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: settingsProvider.settings.useDarkMode
              ? ThemeMode.dark
              : ThemeMode.light,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          locale: Locale(settingsProvider.settings.locale),
          home: const HomeScreen(),
        );
      },
    );
  }
}