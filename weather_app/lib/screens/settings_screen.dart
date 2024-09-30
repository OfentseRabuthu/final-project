import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../providers/settings_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.settingsTitle),
      ),
      body: Consumer<SettingsProvider>(
        builder: (context, settingsProvider, child) {
          return ListView(
            children: [
              SwitchListTile(
                title: Text(localizations.useCelsius),
                value: settingsProvider.settings.useCelsius,
                onChanged: (value) {
                  settingsProvider.updateSettings(
                    settingsProvider.settings.copyWith(useCelsius: value),
                  );
                },
              ),
              SwitchListTile(
                title: Text(localizations.enableNotifications),
                value: settingsProvider.settings.enableNotifications,
                onChanged: (value) {
                  settingsProvider.updateSettings(
                    settingsProvider.settings.copyWith(enableNotifications: value),
                  );
                },
              ),
              SwitchListTile(
                title: Text(localizations.darkMode),
                value: settingsProvider.settings.useDarkMode,
                onChanged: (value) {
                  settingsProvider.updateSettings(
                    settingsProvider.settings.copyWith(useDarkMode: value),
                  );
                },
              ),
              ListTile(
                title: Text(localizations.selectLanguage),
                trailing: DropdownButton<String>(
                  value: settingsProvider.settings.locale,
                  items: const [
                    DropdownMenuItem(value: 'en', child: Text('English')),
                    DropdownMenuItem(value: 'af', child: Text('Afrikaans')),
                    DropdownMenuItem(value: 'zu', child: Text('isiZulu')),
                  ],
                  onChanged: (String? newLocale) {
                    if (newLocale != null) {
                      settingsProvider.changeLocale(newLocale);
                    }
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}