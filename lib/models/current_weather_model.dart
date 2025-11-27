class CurrentWeatherModel {
  final double temperature;
  final double temperatureMax;
  final double temperatureMin;
  final int weatherCode;
  final double windSpeed;
  final int humidity;
  final double precipitation;
  final String sunrise;
  final String sunset;

  CurrentWeatherModel({
    required this.temperature,
    required this.temperatureMax,
    required this.temperatureMin,
    required this.weatherCode,
    required this.windSpeed,
    required this.humidity,
    required this.precipitation,
    required this.sunrise,
    required this.sunset,
  });

  factory CurrentWeatherModel.fromJson(Map<String, dynamic> json) {
    final current = json['current'];
    final daily = json['daily'];

    return CurrentWeatherModel(
      temperature: current['temperature_2m']?.toDouble() ?? 0.0,
      temperatureMax: daily['temperature_2m_max'][0]?.toDouble() ?? 0.0,
      temperatureMin: daily['temperature_2m_min'][0]?.toDouble() ?? 0.0,
      weatherCode: current['weather_code'] ?? 0,
      windSpeed: current['wind_speed_10m']?.toDouble() ?? 0.0,
      humidity: current['relative_humidity_2m'] ?? 0,
      precipitation: current['precipitation']?.toDouble() ?? 0.0,
      sunrise: daily['sunrise'][0] ?? '',
      sunset: daily['sunset'][0] ?? '',
    );
  }
}
