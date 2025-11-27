import 'package:dio/dio.dart';
import 'package:weather_app/models/current_weather_model.dart';
import 'package:weather_app/models/daily_forecast_model.dart';
import 'package:weather_app/models/hourly_forecast_model.dart';

class WeatherService {
  final Dio _dio = Dio();

  static const String _apiUrl =
      'https://api.open-meteo.com/v1/forecast?latitude=26.5455&longitude=87.8942&daily=weather_code,temperature_2m_max,temperature_2m_min,precipitation_sum,sunrise,sunset&hourly=temperature_2m,weather_code,precipitation&current=temperature_2m,weather_code,precipitation,relative_humidity_2m,wind_speed_10m';

  WeatherService() {
    _dio.options = BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Content-Type': 'application/json'},
    );
  }

  Future<Map<String, dynamic>> getCompleteWeatherData() async {
    try {
      final response = await _dio.get(_apiUrl);

      if (response.statusCode == 200) {
        final data = response.data;

        final currentWeather = CurrentWeatherModel.fromJson(data);
        final dailyForecast = DailyForecastModel.listFromJson(data);
        final hourlyForecast = HourlyForecastModel.listFromJson(data);

        return {
          'current': currentWeather,
          'daily': dailyForecast,
          'hourly': hourlyForecast,
        };
      } else {
        throw Exception('Failed to load weather data: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  String _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Connection timeout. Please check your internet connection.';

      case DioExceptionType.badResponse:
        return 'Server error: ${error.response?.statusCode}';

      case DioExceptionType.connectionError:
        return 'No internet connection. Please check your network.';

      default:
        return 'Something went wrong. Please try again.';
    }
  }
}
