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

  String getWeatherDescription() {
    switch (weatherCode) {
      case 0:
        return 'Clear sky';
      case 1:
      case 2:
      case 3:
        return 'Partly cloudy';
      case 45:
      case 48:
        return 'Foggy';
      case 51:
      case 53:
      case 55:
        return 'Drizzle';
      case 61:
      case 63:
      case 65:
        return 'Rain';
      case 71:
      case 73:
      case 75:
        return 'Snow';
      case 80:
      case 81:
      case 82:
        return 'Rain showers';
      case 95:
      case 96:
      case 99:
        return 'Thunderstorm';
      default:
        return 'Unknown';
    }
  }
}
