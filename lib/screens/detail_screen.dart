import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/app_colors.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/widgets/air_quality_card.dart';
import 'package:weather_app/widgets/forecast_card.dart';
import 'package:weather_app/widgets/info_card.dart';

class ForecastDetailScreen extends StatefulWidget {
  const ForecastDetailScreen({super.key});

  @override
  State<ForecastDetailScreen> createState() => _ForecastDetailScreenState();
}

class _ForecastDetailScreenState extends State<ForecastDetailScreen> {

  //! This is function for ScrollController in detail screen
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollLeft() {
    _scrollController.animateTo(
      _scrollController.offset - 150,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _scrollRight() {
    _scrollController.animateTo(
      _scrollController.offset + 150,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
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
            if (provider.currentWeather == null) {
              return Center(
                child: CircularProgressIndicator(color: AppColors.accentYellow),
              );
            }

            final current = provider.currentWeather!;
            final daily = provider.dailyForecast ?? [];

            return SafeArea(
              child: Column(
                children: [
                  _buildHeader(current),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 40),
                          Text(
                            '7-Days Forecasts',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 20),
                          _buildForecastList(daily),
                          SizedBox(height: 40),
                          AirQualityCard(),
                          SizedBox(height: 24),
                          _buildInfoCards(current),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
                  _buildBottomNavigation(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

//! Location and max min temperature shown here
  Widget _buildHeader(dynamic current) {
    return Padding(
      padding: EdgeInsets.all(24),
      child: Column(
        children: [
          SizedBox(height: 100),
          Text(
            'Jhapa, Nepal',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Max: ${current.temperatureMax.round()}°  Min: ${current.temperatureMin.round()}°',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 24,
            ),
          ),
        ],
      ),
    );
  }

//! 7 days forecast list with scroll controller
  Widget _buildForecastList(List daily) {
    return Row(
      children: [
        GestureDetector(
          onTap: _scrollLeft,
          child: Icon(Icons.chevron_left, color: Colors.white, size: 20),
        ),
        SizedBox(width: 12),
        Expanded(
          child: SizedBox(
            height: 120,
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: daily.length > 7 ? 7 : daily.length,
              itemBuilder: (context, index) {
                final day = daily[index];
                return ForecastCard(day: day);
              },
            ),
          ),
        ),
        SizedBox(width: 12),
        GestureDetector(
          onTap: _scrollRight,
          child: Icon(Icons.chevron_right, color: Colors.white, size: 20),
        ),
      ],
    );
  }

//! Sunrise and UV index info card
  Widget _buildInfoCards(dynamic current) {
    return Row(
      children: [
        Expanded(
          child: InfoCard(
            icon: Icons.wb_sunny_outlined,
            title: 'SUNRISE',
            mainText: current.getFormattedSunrise(),
            subText: 'Sunset: ${current.getFormattedSunset()}',
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: InfoCard(
            icon: Icons.wb_sunny,
            title: 'UV INDEX',
            mainText: '4',
            subText: 'Moderate',
          ),
        ),
      ],
    );
  }

//! Bottom navigation bar
  Widget _buildBottomNavigation() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Center(
        child: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(
              Icons.menu,
              color: Colors.white.withValues(alpha: 0.8),
              size: 26,
            ),
          ),
        ),
      ),
    );
  }
}
