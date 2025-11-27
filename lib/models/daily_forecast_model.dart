class DailyForecastModel {
  final String date;
  final double temperatureMax;
  final double temperatureMin;
  final int weatherCode;
  final double precipitation;

  DailyForecastModel({
    required this.date,
    required this.temperatureMax,
    required this.temperatureMin,
    required this.weatherCode,
    required this.precipitation,
  });

  factory DailyForecastModel.fromJson(Map<String, dynamic> json, int index) {
    return DailyForecastModel(
      date: json['time'][index] ?? '',
      temperatureMax: json['temperature_2m_max'][index]?.toDouble() ?? 0.0,
      temperatureMin: json['temperature_2m_min'][index]?.toDouble() ?? 0.0,
      weatherCode: json['weather_code'][index] ?? 0,
      precipitation: json['precipitation_sum'][index]?.toDouble() ?? 0.0,
    );
  }

  String getDayName() {
    try {
      final dateTime = DateTime.parse(date);
      final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
      return days[dateTime.weekday - 1];
    } catch (e) {
      return 'N/A';
    }
  }

  String getWeatherDescription() {
    switch (weatherCode) {
      case 0:
        return 'Clear';
      case 1:
      case 2:
      case 3:
        return 'Cloudy';
      case 45:
      case 48:
        return 'Fog';
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
        return 'Showers';
      case 95:
      case 96:
      case 99:
        return 'Storm';
      default:
        return 'Unknown';
    }
  }

  static List<DailyForecastModel> listFromJson(Map<String, dynamic> json) {
    final List<DailyForecastModel> forecasts = [];
    final daily = json['daily'];

    for (int i = 0; i < 7; i++) {
      forecasts.add(DailyForecastModel.fromJson(daily, i));
    }

    return forecasts;
  }
}
