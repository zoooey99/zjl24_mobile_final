import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  final Map<String, dynamic>? weatherData;

  const WelcomeScreen({super.key, this.weatherData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF87CEEB), Color(0xFF1E90FF)], // Sky blue to royal blue gradient
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 20),
                      // Header
                      const Text(
                        'Miami Weather',
                        style: TextStyle(
                          fontSize: 32,
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
                      
                      const SizedBox(height: 20),
                      // Weather Card
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(204), // 0.8 opacity = 204 alpha
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(77), // 0.3 opacity = 77 alpha
                              spreadRadius: 1,
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            if (weatherData != null) ...[
                              Text(
                                'Current Temperature: ${weatherData!['properties']['periods'][0]['temperature']}°F',
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFFF8C00), // Dark orange
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                weatherData!['properties']['periods'][0]['shortForecast'],
                                style: const TextStyle(
                                  fontSize: 24,
                                  color: Color(0xFF555555),
                                ),
                              ),
                            ],
                            Icon(
                              Icons.wb_sunny,
                              size: 100,
                              color: Colors.orangeAccent,
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 20),
                      // Location
                      const Text(
                        'Miami, FL',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'Thursday, April 24',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      
                      const SizedBox(height: 20),
                      // Summary
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(153), // 0.6 opacity = 153 alpha
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Text(
                          'It\'s a beautiful day in Miami! Perfect weather for the beach.',
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFF333333),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  
                  // Footer
                  const Padding(
                    padding: EdgeInsets.only(bottom: 20, top: 20),
                    child: Text(
                      'Swipe to view hourly and daily forecasts',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}