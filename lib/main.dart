import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zjl24_mobile_final/hourly.dart';
import 'welcome.dart';
import 'hourly.dart';
//import 'daily.dart';

void main() {
  runApp(const MiamiWeather());
}

class MiamiWeather extends StatelessWidget {
  const MiamiWeather({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Miami Weather',
      theme: ThemeData(
        // Use a blue-based theme with orange accents for Miami vibes
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E90FF), // Royal blue
          primary: const Color(0xFF1E90FF),   // Royal blue
          secondary: const Color(0xFFFF8C00), // Dark orange
          surface: Colors.white,
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const MyMiamiWeather(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyMiamiWeather extends StatefulWidget {
  const MyMiamiWeather({super.key});

  @override
  State<MyMiamiWeather> createState() => _MyMiamiWeatherState();
}

class _MyMiamiWeatherState extends State<MyMiamiWeather> {
  int currentPage = 0;
  Map<String, dynamic>? weatherData;
  bool isLoading = true;
  String error = '';

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
  }

  Future<void> fetchWeatherData() async {
    try {
      const baseUrl = 'https://api.weather.gov';
      const userAgent = 'MiamiWeatherApp/1.0';
      
      // Get grid coordinates for Miami
      final response = await http.get(
        Uri.parse('$baseUrl/points/25.7617,-80.1918'),
        headers: {'User-Agent': userAgent},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final hourlyForecastUrl = data['properties']['forecastHourly'];
        
        final hourlyResponse = await http.get(
          Uri.parse(hourlyForecastUrl),
          headers: {'User-Agent': userAgent},
        );

        if (hourlyResponse.statusCode == 200) {
          setState(() {
            weatherData = json.decode(hourlyResponse.body);
            isLoading = false;
          });
        } else {
          setState(() {
            error = 'Failed to load hourly forecast';
            isLoading = false;
          });
        }
      } else {
        setState(() {
          error = 'Failed to load weather data';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        error = 'Error: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Miami Weather",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF1E90FF), // Royal blue
        elevation: 0,
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : error.isNotEmpty
              ? Center(child: Text(error))
              : <Widget>[
                  WelcomeScreen(weatherData: weatherData),
                  HourlyScreen(weatherData: weatherData),
                  const Placeholder(),
                  const Placeholder(),
                ][currentPage],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPage = index;
          });
        },
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.location_city),
            label: "Welcome",
          ),
          NavigationDestination(
            icon: Icon(Icons.schedule),
            label: "24 Hour",
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_month),
            label: "10 Day",
          ),
          NavigationDestination(
            icon: Icon(Icons.water_drop),
            label: "Other Info",
          ),
        ],
        selectedIndex: currentPage,
        backgroundColor: Colors.white,
        elevation: 2.0,
        indicatorColor: Color.fromRGBO(255, 140, 0, 0.2), // Light orange
        indicatorShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        height: 70,
      ),
    );
  }
}