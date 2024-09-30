import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
import '../services/weather_service.dart';

class CitySearchScreen extends StatefulWidget {
  const CitySearchScreen({super.key});

  @override
  CitySearchScreenState createState() => CitySearchScreenState();
}

class CitySearchScreenState extends State<CitySearchScreen> {
  final WeatherService _weatherService = WeatherService();
  List<Map<String, dynamic>> _searchResults = [];
  bool _isLoading = false;

  void _searchCity(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final results = await _weatherService.searchCity(query);
      if (!mounted) return;
      setState(() {
        _searchResults = results;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error searching city: ${e.toString()}'),
          duration: const Duration(seconds: 5),
        ),
      );
    }
  }

  Future<void> _handleCitySelection(Map<String, dynamic> city) async {
    final weatherProvider =
        Provider.of<WeatherProvider>(context, listen: false);

    setState(() {
      _isLoading = true;
    });

    try {
      final placeDetails =
          await _weatherService.getPlaceDetails(city['place_id']);

      final latitude = placeDetails['lat']?.toDouble();
      final longitude = placeDetails['lng']?.toDouble();

      if (latitude != null && longitude != null) {
        weatherProvider.setLocation(
          latitude: latitude,
          longitude: longitude,
        );

        await weatherProvider.fetchWeatherData();

        if (mounted) {
          Navigator.of(context).pop();
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Invalid data: lat or lon is null')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error fetching weather data: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search City'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Enter city name',
                prefixIcon: Icon(Icons.search),
                filled: true, 
                fillColor: Colors.white, 
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  borderSide: BorderSide.none,
                ),
              ),
              style: const TextStyle(
                color: Colors.black, 
                fontSize: 16.0, 
              ),
              onChanged: _searchCity,
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: _searchResults.length,
                    itemBuilder: (context, index) {
                      final city = _searchResults[index];
                      return ListTile(
                        title: Text(city['name'] as String),
                        subtitle: Text(city['country'] as String),
                        onTap: () => _handleCitySelection(city),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
