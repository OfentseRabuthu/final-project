
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
import '../widgets/current_weather.dart';
import '../widgets/forecast_list.dart';
import 'weather_map_screen.dart';
import 'city_search_screen.dart';
import 'settings_screen.dart';
import '../widgets/detailed_weather_info.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<WeatherProvider>(context, listen: false).fetchWeatherData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)?.appTitle ?? 'Weather Forecast',
          style: const TextStyle(color: Colors.white),  
        ),
        actions: const [
          _SearchButton(),
          _MapButton(),
          _SettingsButton(),
        ],
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

          if (weatherProvider.weather == null || weatherProvider.forecast == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return RefreshIndicator(
            onRefresh: () => weatherProvider.fetchWeatherData(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  CurrentWeather(weather: weatherProvider.weather!),
                  DetailedWeatherInfo(weather: weatherProvider.weather!),
                  ForecastList(forecast: weatherProvider.forecast!),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SearchButton extends StatelessWidget {
  const _SearchButton();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.search),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CitySearchScreen()),
        );
      },
    );
  }
}

class _MapButton extends StatelessWidget {
  const _MapButton();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.map),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const WeatherMapScreen()),
        );
      },
    );
  }
}

class _SettingsButton extends StatelessWidget {
  const _SettingsButton();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.settings),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SettingsScreen()),
        );
      },
    );
  }
}
