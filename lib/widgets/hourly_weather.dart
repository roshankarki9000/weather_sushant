import 'package:flutter/material.dart';
import 'package:weather_app/utils/weather_utils.dart';

class HourlyWeatherItem extends StatelessWidget {
  final String temperature;
  final String time;
  final int weatherCode;

  const HourlyWeatherItem({
    super.key,
    required this.temperature,
    required this.time,
    required this.weatherCode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '$temperature°C',
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 10),
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Text(
              WeatherUtils.getWeatherEmoji(weatherCode),
              style: TextStyle(fontSize: 28),
            ),
          ),
        ),
        SizedBox(height: 10),
        Text(
          time,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.7),
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
