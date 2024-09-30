import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/weather.dart';
import '../providers/settings_provider.dart';

class CurrentWeather extends StatelessWidget {
  final Weather weather;

  const CurrentWeather({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              '${settingsProvider.convertTemperature(weather.temperature).toStringAsFixed(1)}${settingsProvider.getTemperatureUnit()}',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            Text(
              weather.description,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildWeatherInfo(
                  'Feels like',
                  '${settingsProvider.convertTemperature(weather.feelsLike).toStringAsFixed(1)}${settingsProvider.getTemperatureUnit()}',
                ),
                _buildWeatherInfo(
                  'Humidity',
                  '${weather.humidity.toStringAsFixed(0)}%',
                ),
                _buildWeatherInfo(
                  'Wind',
                  '${weather.windSpeed.toStringAsFixed(1)} m/s',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherInfo(String label, String value) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(value),
      ],
    );
  }
}
