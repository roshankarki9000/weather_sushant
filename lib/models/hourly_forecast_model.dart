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

  // Get hour in 24-hour format (15:00)
  String getHour24() {
    try {
      final dateTime = DateTime.parse(time);
      return '${dateTime.hour.toString().padLeft(2, '0')}.${dateTime.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return time;
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
