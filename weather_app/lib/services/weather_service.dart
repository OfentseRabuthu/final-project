import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather.dart';
import '../models/forecast.dart';
import 'package:logger/logger.dart';

class WeatherService {
  final String serverBaseUrl = 'http://localhost:3000';
  final Logger _logger = Logger();

  Future<Weather> getWeather(double lat, double lon) async {
    try {
      final response = await http.get(Uri.parse('$serverBaseUrl/weather?lat=$lat&lon=$lon'));

      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        return Weather.fromJson(decodedData['current']);
      } else {
        _logger.e('Failed to load weather data. Status code: ${response.statusCode}');
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      _logger.e('Error fetching weather data: $e');
      throw Exception('Error fetching weather data: $e');
    }
  }

  Future<List<Forecast>> getForecast(double lat, double lon) async {
    try {
      final response = await http.get(Uri.parse('$serverBaseUrl/weather?lat=$lat&lon=$lon'));

      _logger.d('API Response (Forecast): ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        return (data['daily'] as List?)
            ?.map((day) => Forecast.fromJson(day))
            .take(10)
            .toList() ?? [];
      } else {
        _logger.e('Failed to load forecast data. Status code: ${response.statusCode}');
        throw Exception('Failed to load forecast data');
      }
    } catch (e) {
      _logger.e('Error in getForecast: $e');
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> searchCity(String query) async {
    try {
      final response = await http.get(
        Uri.parse('$serverBaseUrl/searchCity?input=$query'),
      ).timeout(const Duration(seconds: 10));

      _logger.d('API Response (City Search): ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'OK') {
          return (data['predictions'] as List).map((prediction) {
            final description = prediction['description'] as String;
            final parts = description.split(', ');
            return {
              'name': parts.first,
              'country': parts.last,
              'place_id': prediction['place_id'],
            };
          }).toList();
        } else {
          throw Exception('Google Places API error: ${data['status']}');
        }
      } else {
        throw Exception('Failed to search cities. Status code: ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('No internet connection');
    } on TimeoutException {
      throw Exception('Connection timed out');
    } catch (e) {
      _logger.e('Error in searchCity: $e');
      throw Exception('Error searching for cities: $e');
    }
  }

      Future<Map<String, double>> getPlaceDetails(String placeId) async {
    final String apiUrl = '$serverBaseUrl/placeDetails?place_id=$placeId';

    try {
      final response = await http.get(Uri.parse(apiUrl)).timeout(const Duration(seconds: 10));

      _logger.d('API Response (Place Details): ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['result'] != null && data['result']['geometry'] != null) {
          final location = data['result']['geometry']['location'];

          final lat = location['lat']?.toDouble();
          final lon = location['lng']?.toDouble();

          if (lat != null && lon != null) {
            return {
              'lat': lat,
              'lon': lon,
            };
          } else {
            throw Exception('Invalid data: lat or lon is null');
          }
        } else {
          throw Exception('Invalid response structure');
        }
      } else {
        _logger.e('Failed to load place details. Status code: ${response.statusCode}');
        throw Exception('Failed to get place details');
      }
    } on SocketException {
      throw Exception('No internet connection');
    } on TimeoutException {
      throw Exception('Connection timed out');
    } catch (e) {
      _logger.e('Error in getPlaceDetails: $e');
      throw Exception('Error fetching place details: $e');
    }
  }
}