import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import '../models/weather.dart';
import '../models/forecast.dart';
import '../services/weather_service.dart';
import '../services/location_service.dart';
import '../services/notification_service.dart';

class WeatherProvider with ChangeNotifier {
  final WeatherService _weatherService;
  final LocationService _locationService;
  final NotificationService _notificationService;
  final Logger _logger = Logger();

  Weather? _weather;
  List<Forecast>? _forecast;
  String? _error;

  Weather? get weather => _weather;
  List<Forecast>? get forecast => _forecast;
  String? get error => _error;

  double? latitude;
  double? longitude;

  WeatherProvider({
    required WeatherService weatherService,
    required LocationService locationService,
    required NotificationService notificationService,
  })  : _weatherService = weatherService,
        _locationService = locationService,
        _notificationService = notificationService;

  void setLocation({required double latitude, required double longitude}) {
    this.latitude = latitude;
    this.longitude = longitude;
    notifyListeners();
  }

  Future<void> fetchWeatherData() async {
    try {
      if (latitude == null || longitude == null) {
        final position = await _locationService.getCurrentLocation();
        latitude = position.latitude;
        longitude = position.longitude;
      }

      if (latitude != null && longitude != null) {
        print('Fetching weather data for latitude: $latitude, longitude: $longitude');

        _weather = await _weatherService.getWeather(latitude!, longitude!);
        _forecast = await _weatherService.getForecast(latitude!, longitude!);

        _checkAndNotifySevereConditions();
        
        _error = null;
      } else {
        _error = 'Invalid location: Latitude or Longitude is null';
        print(_error);
      }
    } catch (e) {
      _error = 'Error fetching weather data: $e';
      _logger.e(_error);
    } finally {
      notifyListeners();
    }
  }

  void _checkAndNotifySevereConditions() {
    if (_weather != null && _weather!.temperature > 35) {
      _notificationService.showNotification(
        1,
        'Extreme Heat Warning',
        'Temperature is above 35°C. Stay hydrated and avoid direct sun exposure.',
      );
    }

    if (_forecast != null) {
      for (var forecast in _forecast!) {
        if (forecast.alerts != null && forecast.alerts!.isNotEmpty) {
          for (var alert in forecast.alerts!) {
            _notificationService.showNotification(
              2,
              alert.event,
              alert.description,
            );
          }
        }
      }
    }
  }
}
