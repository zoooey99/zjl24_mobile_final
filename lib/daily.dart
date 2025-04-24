import 'package:flutter/material.dart';

class DailyForecastCard extends StatelessWidget {
  final String day;
  final int highTemp;
  final int lowTemp;
  final String shortForecast;
  final int precipitationChance;

  const DailyForecastCard({
    super.key,
    required this.day,
    required this.highTemp,
    required this.lowTemp,
    required this.shortForecast,
    required this.precipitationChance,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(204),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(26),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Day and Temperature
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                day,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E90FF),
                ),
              ),
              Row(
                children: [
                  Text(
                    '$highTemp°',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFF8C00),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '$lowTemp°',
                    style: const TextStyle(
                      fontSize: 20,
                      color: Color(0xFF1E90FF),
                    ),
                  ),
                ],
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // Weather Icon and Description
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    _getWeatherIcon(shortForecast),
                    size: 40,
                    color: Colors.orangeAccent,
                  ),
                  const SizedBox(width: 12),
                  SizedBox(
                    width: 150,
                    child: Text(
                      shortForecast,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF555555),
                      ),
                    ),
                  ),
                ],
              ),
              
              // Precipitation Chance
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E90FF).withAlpha(26),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.water_drop,
                      size: 16,
                      color: Color(0xFF1E90FF),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '$precipitationChance%',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF1E90FF),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
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

class DailyScreen extends StatelessWidget {
  final Map<String, dynamic>? weatherData;

  const DailyScreen({super.key, this.weatherData});

  @override
  Widget build(BuildContext context) {
    if (weatherData == null) {
      return const Center(child: Text('No weather data available'));
    }

    final periods = weatherData!['properties']['periods'] as List;
    // Calculate how many full days we have (each day has 2 periods - day and night)
    final numberOfDays = (periods.length / 2).floor();
    
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
        itemCount: numberOfDays, // Use actual number of available days
        itemBuilder: (context, index) {
          // Get both day and night periods for each day
          final dayPeriod = periods[index * 2];
          final nightPeriod = periods[index * 2 + 1];
          
          return DailyForecastCard(
            day: _formatDay(dayPeriod['startTime']),
            highTemp: dayPeriod['temperature'],
            lowTemp: nightPeriod['temperature'],
            shortForecast: dayPeriod['shortForecast'],
            precipitationChance: dayPeriod['probabilityOfPrecipitation']['value'] ?? 0,
          );
        },
      ),
    );
  }

  String _formatDay(String isoTime) {
    final dateTime = DateTime.parse(isoTime);
    final today = DateTime.now();
    final tomorrow = today.add(const Duration(days: 1));
    
    // Check if it's today
    if (dateTime.year == today.year && 
        dateTime.month == today.month && 
        dateTime.day == today.day) {
      return 'Today';
    }
    
    // Check if it's tomorrow
    if (dateTime.year == tomorrow.year && 
        dateTime.month == tomorrow.month && 
        dateTime.day == tomorrow.day) {
      return 'Tomorrow';
    }
    
    // For all other days, return the weekday
    return _getWeekday(dateTime.weekday);
  }

  String _getWeekday(int weekday) {
    switch (weekday) {
      case 1: return 'Monday';
      case 2: return 'Tuesday';
      case 3: return 'Wednesday';
      case 4: return 'Thursday';
      case 5: return 'Friday';
      case 6: return 'Saturday';
      case 7: return 'Sunday';
      default: return '';
    }
  }
}
