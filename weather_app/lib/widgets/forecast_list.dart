import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../models/forecast.dart';
import 'package:intl/intl.dart';

class ForecastList extends StatelessWidget {
  final List<Forecast> forecast;

  const ForecastList({super.key, required this.forecast});

  String getLocalIcon(String openWeatherIcon) {
    Map<String, String> iconMapping = {
      '01d': 'wi-day-sunny.svg',
      '01n': 'wi-night-clear.svg',
      '02d': 'wi-day-cloudy.svg',
      '02n': 'wi-night-cloudy.svg',
      '03d': 'wi-cloud.svg',
      '03n': 'wi-cloud.svg',
      '04d': 'wi-cloudy.svg',
      '04n': 'wi-cloudy.svg',
      '09d': 'wi-showers.svg',
      '09n': 'wi-showers.svg',
      '10d': 'wi-day-rain.svg',
      '10n': 'wi-night-rain.svg',
      '11d': 'wi-day-thunderstorm.svg',
      '11n': 'wi-night-thunderstorm.svg',
      '13d': 'wi-day-snow.svg',
      '13n': 'wi-night-snow.svg',
      '50d': 'wi-fog.svg',
      '50n': 'wi-fog.svg',
    };

    return 'assets/weather_icons/${iconMapping[openWeatherIcon]}';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              '8-Day Forecast',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          SizedBox(
            height: 150,
             child: LayoutBuilder(
              builder: (context, constraints) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: forecast.length,
                  itemBuilder: (context, index) {
                    final day = forecast[index];

                
                    String iconPath = getLocalIcon(day.icon);

                    return SizedBox(
                      width: constraints.maxWidth / 2, 
                      child: Card(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Container(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                iconPath, 
                                width: 50,
                                height: 50,
                                placeholderBuilder: (context) => const Icon(
                                  Icons.error,
                                  size: 50,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                DateFormat('EEEE').format(
                                    day.date),
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${day.temperature.toStringAsFixed(1)}°C',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}