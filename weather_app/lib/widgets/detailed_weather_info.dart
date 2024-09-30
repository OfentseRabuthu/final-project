import 'package:flutter/material.dart';
import '../models/weather.dart';

class DetailedWeatherInfo extends StatelessWidget {
  final Weather weather;

  const DetailedWeatherInfo({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Detailed Weather Information',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            _buildInfoRow('UV Index', weather.uvIndex.toStringAsFixed(1)),
            _buildInfoRow('Current Precipitation', '${weather.precipitation1h.toStringAsFixed(1)} mm'),
            _buildInfoRow('Precipitation Chance', '${(weather.precipitationProbability * 100).toStringAsFixed(0)}%'),            
            _buildInfoRow('Pressure', '${weather.pressure.toStringAsFixed(0)} hPa'),
            _buildInfoRow('Humidity', '${weather.humidity.toStringAsFixed(0)}%'),
            _buildInfoRow('Wind Speed', '${weather.windSpeed.toStringAsFixed(1)} m/s'),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }
}