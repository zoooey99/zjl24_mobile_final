import 'package:flutter/material.dart';

class HourlyForecastCard extends StatelessWidget {
  final String time;
  final int temperature;
  final String shortForecast;
  final String windSpeed;
  final String windDirection;
  final int relativeHumidity;

  const HourlyForecastCard({
    super.key,
    required this.time,
    required this.temperature,
    required this.shortForecast,
    required this.windSpeed,
    required this.windDirection,
    required this.relativeHumidity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(204),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(26),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Time and Temperature
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                time,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E90FF),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '$temperature°F',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFF8C00),
                ),
              ),
            ],
          ),
          
          // Weather Icon and Description
          Column(
            children: [
              Icon(
                _getWeatherIcon(shortForecast),
                size: 32,
                color: Colors.orangeAccent,
              ),
              const SizedBox(height: 4),
              SizedBox(
                width: 100,
                child: Text(
                  shortForecast,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF555555),
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          
          // Additional Details
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.air,
                    size: 16,
                    color: Color(0xFF1E90FF),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '$windSpeed $windDirection',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF555555),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(
                    Icons.water_drop,
                    size: 16,
                    color: Color(0xFF1E90FF),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '$relativeHumidity%',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF555555),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  IconData _getWeatherIcon(String forecast) {
    if (forecast.toLowerCase().contains('sunny') || 
        forecast.toLowerCase().contains('clear')) {
      return Icons.wb_sunny;
    } else if (forecast.toLowerCase().contains('cloud')) {
      return Icons.cloud;
    } else if (forecast.toLowerCase().contains('rain')) {
      return Icons.water_drop;
    } else if (forecast.toLowerCase().contains('thunder')) {
      return Icons.flash_on;
    } else {
      return Icons.wb_sunny;
    }
  }
}

class HourlyScreen extends StatelessWidget {
  final Map<String, dynamic>? weatherData;

  const HourlyScreen({super.key, this.weatherData});

  @override
  Widget build(BuildContext context) {
    if (weatherData == null) {
      return const Center(child: Text('No weather data available'));
    }

    final periods = weatherData!['properties']['periods'] as List;
    
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF87CEEB), Color(0xFF1E90FF)],
        ),
      ),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 16),
        itemCount: 24, // Show next 24 hours
        itemBuilder: (context, index) {
          final period = periods[index];
          return HourlyForecastCard(
            time: _formatTime(period['startTime']),
            temperature: period['temperature'],
            shortForecast: period['shortForecast'],
            windSpeed: period['windSpeed'],
            windDirection: period['windDirection'],
            relativeHumidity: period['relativeHumidity']['value'],
          );
        },
      ),
    );
  }

  String _formatTime(String isoTime) {
    final dateTime = DateTime.parse(isoTime);
    return '${dateTime.hour}:00 ${dateTime.hour < 12 ? 'AM' : 'PM'}';
  }
}
