import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';

class WeatherMapScreen extends StatefulWidget {
  const WeatherMapScreen({super.key});

  @override
  WeatherMapScreenState createState() => WeatherMapScreenState();
}

class WeatherMapScreenState extends State<WeatherMapScreen> {
  GoogleMapController? _mapController;
  final Set<Marker> _markers = {};

  void _updateMarkers() {
    final weatherProvider = Provider.of<WeatherProvider>(context, listen: false);
    if (weatherProvider.weather != null) {
      setState(() {
        _markers.clear();
        _markers.add(
          Marker(
            markerId: const MarkerId('current_location'),
            position: LatLng(weatherProvider.latitude!, weatherProvider.longitude!),
            infoWindow: InfoWindow(
              title: 'Current Location',
              snippet: '${weatherProvider.weather!.temperature.toStringAsFixed(1)}°C, ${weatherProvider.weather!.description}',
            ),
          ),
        );

        _mapController?.animateCamera(
          CameraUpdate.newLatLng(
            LatLng(weatherProvider.latitude!, weatherProvider.longitude!),
          ),
        );
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateMarkers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Map'),
      ),
      body: Consumer<WeatherProvider>(
        builder: (context, weatherProvider, child) {
          if (weatherProvider.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(weatherProvider.error!, style: const TextStyle(color: Colors.red)),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => weatherProvider.fetchWeatherData(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(
                weatherProvider.latitude ?? -26.2041,
                weatherProvider.longitude ?? 28.0473,
              ),
              zoom: 12,
            ),
            onMapCreated: (GoogleMapController controller) {
              _mapController = controller;
              _updateMarkers();
            },
            markers: _markers,
          );
        },
      ),
    );
  }
}