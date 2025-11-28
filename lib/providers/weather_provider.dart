import 'package:flutter/material.dart';
import 'package:weather_app/models/current_weather_model.dart';
import 'package:weather_app/models/daily_forecast_model.dart';
import 'package:weather_app/models/hourly_forecast_model.dart';
import 'package:weather_app/services/weather_service.dart';


class WeatherProvider extends ChangeNotifier {
  final WeatherService _weatherService = WeatherService();

  CurrentWeatherModel? _currentWeather;
  List<DailyForecastModel>? _dailyForecast;
  List<HourlyForecastModel>? _hourlyForecast;

  bool _isLoading = false;
  String? _errorMessage;

  //! Getter for weather data and to know stste

  CurrentWeatherModel? get currentWeather => _currentWeather;
  List<DailyForecastModel>? get dailyForecast => _dailyForecast;
  List<HourlyForecastModel>? get hourlyForecast => _hourlyForecast;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

//! This fetch weather if not got data send error message
  Future<void> fetchWeatherData() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final weatherData = await _weatherService.getCompleteWeatherData();

      _currentWeather = weatherData['current'] as CurrentWeatherModel;
      _dailyForecast = weatherData['daily'] as List<DailyForecastModel>;
      _hourlyForecast = weatherData['hourly'] as List<HourlyForecastModel>;

      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();

      _currentWeather = null;
      _dailyForecast = null;
      _hourlyForecast = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
