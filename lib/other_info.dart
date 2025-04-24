import 'package:flutter/material.dart';

class OtherInfoScreen extends StatelessWidget {
  final Map<String, dynamic>? weatherData;

  const OtherInfoScreen({super.key, this.weatherData});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF87CEEB), Color(0xFF1E90FF)],
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              'Current Conditions',
              [
                _buildInfoCard(
                  'UV Index',
                  'High',
                  Icons.wb_sunny_outlined,
                ),
                _buildInfoCard(
                  'Visibility',
                  '10 miles',
                  Icons.visibility,
                ),
                _buildInfoCard(
                  'Pressure',
                  '1015 mb',
                  Icons.speed,
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            
            _buildSection(
              'Marine Conditions',
              [
                _buildInfoCard(
                  'Water Temp',
                  '75°F',
                  Icons.waves,
                ),
                _buildInfoCard(
                  'Wave Height',
                  '2-3 ft',
                  Icons.height,
                ),
                _buildInfoCard(
                  'Rip Current Risk',
                  'Low',
                  Icons.warning_outlined,
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            
            _buildSection(
              'Comfort Metrics',
              [
                _buildInfoCard(
                  'Feels Like',
                  '82°F',
                  Icons.thermostat,
                ),
                _buildInfoCard(
                  'Humidity',
                  '65%',
                  Icons.water_drop,
                ),
                _buildInfoCard(
                  'Dew Point',
                  '70°F',
                  Icons.opacity,
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            
            _buildSection(
              'Sun & Moon',
              [
                _buildInfoCard(
                  'Sunrise',
                  '6:45 AM',
                  Icons.wb_twilight,
                ),
                _buildInfoCard(
                  'Sunset',
                  '7:30 PM',
                  Icons.nights_stay,
                ),
                _buildInfoCard(
                  'UV Index Time',
                  '10 AM - 4 PM',
                  Icons.access_time,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> cards) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [
                Shadow(
                  blurRadius: 2.0,
                  color: Colors.black26,
                  offset: Offset(1.0, 1.0),
                ),
              ],
            ),
          ),
        ),
        Row(
          children: cards.map((card) => Expanded(child: card)).toList(),
        ),
      ],
    );
  }

  Widget _buildInfoCard(String title, String value, IconData icon) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
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
          Icon(
            icon,
            size: 32,
            color: const Color(0xFF1E90FF),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF555555),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFF8C00),
            ),
          ),
        ],
      ),
    );
  }
}
