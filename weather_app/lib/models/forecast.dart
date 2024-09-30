// lib/models/forecast.dart
import 'weather_alert.dart';

class Forecast {
  final DateTime date;
  final double temperature;
  final String description;
  final String icon;
  final List<WeatherAlert>? alerts;

  Forecast({
    required this.date,
    required this.temperature,
    required this.description,
    required this.icon,
    this.alerts,
  });

  factory Forecast.fromJson(Map<String, dynamic> json) {
    final alertList = (json['alerts'] as List?)?.map((alert) => WeatherAlert.fromJson(alert)).toList();

    return Forecast(
      date: DateTime.fromMillisecondsSinceEpoch((json['dt'] as int? ?? 0) * 1000),
      temperature: (json['temp'] as Map<String, dynamic>?)?['day']?.toDouble() ?? 0.0,
      description: (json['weather'] as List<dynamic>?)?[0]['description'] as String? ?? 'Unknown',
      icon: (json['weather'] as List<dynamic>?)?[0]['icon'] as String? ?? '01d',
      alerts: alertList,
    );
  }
}
