// lib/models/weather.dart

class Weather {
  final double temperature;           // Current temperature in Celsius
  final double feelsLike;             // Perceived temperature in Celsius
  final int pressure;                 // Atmospheric pressure in hPa
  final int humidity;                 // Humidity percentage
  final double windSpeed;             // Wind speed in meter/sec
  final int windDeg;                  // Wind direction in degrees
  final String description;           // Weather condition description
  final String icon;                  // Weather icon code
  final double uvIndex;               // UV Index (0-11+)
  final double precipitation1h;       // Precipitation volume in last 1h in mm
  final double precipitationProbability;  // Probability of precipitation (0-1)


  Weather({
    required this.temperature,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.windSpeed,
    required this.windDeg,
    required this.description,
    required this.icon,
    required this.uvIndex,
    required this.precipitation1h,
    required this.precipitationProbability,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    final weatherData = json['weather'][0];
    return Weather(
      temperature: json['temp']?.toDouble() ?? 0.0,
      feelsLike: json['feels_like']?.toDouble() ?? 0.0,
      pressure: json['pressure']?.toInt() ?? 0,
      humidity: json['humidity']?.toInt() ?? 0,
      windSpeed: json['wind_speed']?.toDouble() ?? 0.0,
      windDeg: json['wind_deg']?.toInt() ?? 0,
      description: weatherData['description'] ?? '',
      icon: weatherData['icon'] ?? '',
      uvIndex: json['uvi']?.toDouble() ?? 0.0,
      precipitation1h: json['rain']?['1h']?.toDouble() ?? 0.0,
      precipitationProbability: json['pop']?.toDouble() ?? 0.0,
    );
  }
}