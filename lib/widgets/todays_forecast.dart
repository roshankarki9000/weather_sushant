import 'package:flutter/material.dart';
import 'package:weather_app/widgets/hourly_weather.dart';

//! This widget is for today card below house.png which shows hourly forecast
class TodayForecastCard extends StatelessWidget {
  final String currentDate;
  final List<Map<String, dynamic>> hourlyData;

  const TodayForecastCard({
    super.key,
    required this.currentDate,
    required this.hourlyData,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, -35),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Today',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  currentDate,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.7),
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: hourlyData.map((data) {
                return HourlyWeather(
                  temperature: data['temperature'],
                  time: data['time'],
                  weatherCode: data['weatherCode'],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
