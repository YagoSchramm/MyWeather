class WeatherModel {
  final String cityName;
  final double currentTemp;
  final String currentDescription;
  final List<ForecastItem> hourlyForecast;

  WeatherModel({
    required this.cityName,
    required this.currentTemp,
    required this.currentDescription,
    required this.hourlyForecast,
  });
  factory WeatherModel.fromApi({
    required Map<String, dynamic> currentJson,
    required Map<String, dynamic> forecastJson,
  }) {
    final forecastList = (forecastJson['list'] as List)
        .map((item) => ForecastItem.fromJson(item))
        .toList();

    return WeatherModel(
      cityName: currentJson['name'] ?? 'Desconhecido',
      currentTemp: (currentJson['main']['temp'] as num).toDouble(),
      currentDescription: currentJson['weather'][0]['description'] ?? '',
      hourlyForecast: forecastList,
    );
  }
}

class ForecastItem {
  final double temp;
  final String description;
  final String dateTime;

  ForecastItem({
    required this.temp,
    required this.description,
    required this.dateTime,
  });

  factory ForecastItem.fromJson(Map<String, dynamic> json) {
    return ForecastItem(
      temp: (json['main']['temp'] as num).toDouble(),
      description: json['weather'][0]['description'] ?? '',
      dateTime: json['dt_txt'] ?? '',
    );
  }
}