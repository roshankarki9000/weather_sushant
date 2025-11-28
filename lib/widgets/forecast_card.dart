import 'package:flutter/material.dart';
import 'package:weather_app/utils/weather_utils.dart';


class ForecastCardItem extends StatelessWidget {
  final dynamic day;

  const ForecastCardItem({super.key, required this.day});

  @override
  Widget build(BuildContext context) {
    String dayName = day.getDayName();
    String shortDay = dayName.length >= 3 ? dayName.substring(0, 3) : dayName;

    return Container(
      width: 60,
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF7C6FDC), Color(0xFFB17EE8)],
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${day.temperatureMax.round()}°C',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8),
          Text(
            WeatherUtils.getWeatherEmoji(day.weatherCode),
            style: TextStyle(fontSize: 28),
          ),
          SizedBox(height: 8),
          Text(
            shortDay,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
