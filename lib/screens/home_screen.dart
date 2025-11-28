import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/app_colors.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/screens/detail_screen.dart';
import 'package:weather_app/widgets/nav_icon.dart';
import 'package:weather_app/utils/weather_utils.dart';
import 'package:weather_app/widgets/todays_forecast.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        context.read<WeatherProvider>().fetchWeatherData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.primaryPurple, AppColors.primarylightPurple],
          ),
        ),
        child: Consumer<WeatherProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return Center(
                child: CircularProgressIndicator(color: AppColors.accentYellow),
              );
            }

            if (provider.errorMessage != null) {
              return _buildErrorState(provider);
            }

            if (provider.currentWeather != null) {
              return _buildWeatherContent(provider);
            }

            return _buildNoDataState();
          },
        ),
      ),
    );
  }

//! Method for error if any eror come while fetching data
  Widget _buildErrorState(WeatherProvider provider) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 60, color: Colors.white),
          SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              provider.errorMessage!,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => provider.fetchWeatherData(),
            child: Text('Retry'),
          ),
        ],
      ),
    );
  }

//! If no error occur then data is shown here
  Widget _buildWeatherContent(WeatherProvider provider) {
    final current = provider.currentWeather!;
    final hourly = provider.hourlyForecast ?? [];

    final hourlyData = hourly.take(4).map((h) {
      return {
        'temperature': h.temperature.round().toString(),
        'time': h.getHour24(),
        'weatherCode': h.weatherCode,
      };
    }).toList();

    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        SizedBox(height: 60),
                        Image.asset(
                          'assets/cloud.png',
                          width: 160,
                          height: 160,
                        ),
                        SizedBox(height: 10),
                        Text(
                          '${current.temperature.round()}°',
                          style: TextStyle(
                            fontSize: 80,
                            fontWeight: FontWeight.w200,
                            color: Colors.white,
                            height: 1,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Precipitations',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white.withValues(alpha: 0.9),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Max: ${current.temperatureMax.round()}°  Min: ${current.temperatureMin.round()}°',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white.withValues(alpha: 0.7),
                          ),
                        ),
                        SizedBox(height: 40),
                        Image.asset(
                          'assets/house.png',
                          width: 300,
                          height: 250,
                        ),
                      ],
                    ),
                  ),
                  TodayForecastCard(
                    currentDate: WeatherUtils.getCurrentDate(),
                    hourlyData: hourlyData,
                  ),
                ],
              ),
            ),
          ),
          _buildBottomNavigation(),
        ],
      ),
    );
  }

//! Bottom navigation bar 
  Widget _buildBottomNavigation() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          NavIcon(icon: Icons.location_on_outlined),
          NavIcon(
            icon: Icons.add_circle_outline,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ForecastDetailScreen(),
                ),
              );
            },
          ),
          NavIcon(icon: Icons.menu),
        ],
      ),
    );
  }

  Widget _buildNoDataState() {
    return Center(
      child: Text('No data available', style: TextStyle(color: Colors.white)),
    );
  }
}
