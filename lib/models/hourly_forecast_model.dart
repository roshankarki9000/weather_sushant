class HourlyForecastModel {
  final String time;
  final double temperature;
  final int weatherCode;
  final double precipitation;

  HourlyForecastModel({
    required this.time,
    required this.temperature,
    required this.weatherCode,
    required this.precipitation,
  });

  factory HourlyForecastModel.fromJson(Map<String, dynamic> json, int index) {
    return HourlyForecastModel(
      time: json['time'][index] ?? '',
      temperature: json['temperature_2m'][index]?.toDouble() ?? 0.0,
      weatherCode: json['weather_code'][index] ?? 0,
      precipitation: json['precipitation'][index]?.toDouble() ?? 0.0,
    );
  }

  String getHour24() {
    try {
      final dateTime = DateTime.parse(time);
      return '${dateTime.hour.toString().padLeft(2, '0')}.${dateTime.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return time;
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

  static List<HourlyForecastModel> listFromJson(Map<String, dynamic> json) {
    final List<HourlyForecastModel> hourlyList = [];
    final hourly = json['hourly'];

    final now = DateTime.now();
    final currentHour = now.hour;

    for (int i = currentHour; i < currentHour + 8 && i < 24; i++) {
      hourlyList.add(HourlyForecastModel.fromJson(hourly, i));
    }

    return hourlyList;
  }
}
