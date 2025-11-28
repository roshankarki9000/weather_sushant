class WeatherUtils {
  static String getWeatherEmoji(int weatherCode) {
    //! Weather Codes from API (last in docs)
    if (weatherCode == 0) return '☀️';
    if (weatherCode >= 1 && weatherCode <= 3) return '⛅';
    if (weatherCode >= 45 && weatherCode <= 48) return '🌫️';
    if (weatherCode >= 51 && weatherCode <= 55) return '🌦️';
    if (weatherCode >= 61 && weatherCode <= 65) return '🌧️';
    if (weatherCode >= 71 && weatherCode <= 75) return '🌨️';
    if (weatherCode >= 80 && weatherCode <= 82) return '🌧️';
    if (weatherCode >= 95 && weatherCode <= 99) return '⛈️';
    return '☁️';
  }

  static String getCurrentDate() {
    final now = DateTime.now();
    final months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return '${months[now.month - 1]}, ${now.day}';
  }
}
