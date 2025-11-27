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

  static List<DailyForecastModel> listFromJson(Map<String, dynamic> json) {
    final List<DailyForecastModel> forecasts = [];
    final daily = json['daily'];


    for (int i = 0; i < 7; i++) {
      forecasts.add(DailyForecastModel.fromJson(daily, i));
    }

    return forecasts;
  }
}
