class WeatherModel {
  final String cityName;
  final int cityId;
  final String countryCode;
  final double latitude;
  final double longitude;
  final int timezoneOffset; 

  final int weatherConditionId;
  final String weatherMain;      
  final String weatherDescription;
  final String weatherIcon;   

  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;

  final int pressure;     
  final int? seaLevel;    
  final int? groundLevel;  
  final int humidity;      
  final int visibility;    

  final double windSpeed;  
  final int windDeg;       
  final double? windGust; 


  final int cloudiness;   
  final double? rain1h;    
  final double? snow1h;    

  final DateTime sunrise;
  final DateTime sunset;
  final DateTime calculatedAt; 

  final List<ForecastItem> hourlyForecast;

  WeatherModel({
    required this.cityName,
    required this.cityId,
    required this.countryCode,
    required this.latitude,
    required this.longitude,
    required this.timezoneOffset,
    required this.weatherConditionId,
    required this.weatherMain,
    required this.weatherDescription,
    required this.weatherIcon,
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    this.seaLevel,
    this.groundLevel,
    required this.humidity,
    required this.visibility,
    required this.windSpeed,
    required this.windDeg,
    this.windGust,
    required this.cloudiness,
    this.rain1h,
    this.snow1h,
    required this.sunrise,
    required this.sunset,
    required this.calculatedAt,
    required this.hourlyForecast,
  });

  factory WeatherModel.fromApi({
    required Map<String, dynamic> currentJson,
    required Map<String, dynamic> forecastJson,
  }) {
    final main = currentJson['main'] as Map<String, dynamic>;
    final weather = currentJson['weather'][0] as Map<String, dynamic>;
    final wind = currentJson['wind'] as Map<String, dynamic>;
    final sys = currentJson['sys'] as Map<String, dynamic>;
    final coord = currentJson['coord'] as Map<String, dynamic>;

    return WeatherModel(
      cityName: currentJson['name'] ?? 'Desconhecido',
      cityId: currentJson['id'] ?? 0,
      countryCode: sys['country'] ?? '',
      latitude: (coord['lat'] as num).toDouble(),
      longitude: (coord['lon'] as num).toDouble(),
      timezoneOffset: currentJson['timezone'] ?? 0,

      weatherConditionId: weather['id'] ?? 0,
      weatherMain: weather['main'] ?? '',
      weatherDescription: weather['description'] ?? '',
      weatherIcon: weather['icon'] ?? '',

      temp: (main['temp'] as num).toDouble(),
      feelsLike: (main['feels_like'] as num).toDouble(),
      tempMin: (main['temp_min'] as num).toDouble(),
      tempMax: (main['temp_max'] as num).toDouble(),

      pressure: (main['pressure'] as num).toInt(),
      seaLevel: main['sea_level'] != null
          ? (main['sea_level'] as num).toInt()
          : null,
      groundLevel: main['grnd_level'] != null
          ? (main['grnd_level'] as num).toInt()
          : null,
      humidity: (main['humidity'] as num).toInt(),
      visibility: (currentJson['visibility'] as num? ?? 0).toInt(),

      windSpeed: (wind['speed'] as num).toDouble(),
      windDeg: (wind['deg'] as num? ?? 0).toInt(),
      windGust: wind['gust'] != null
          ? (wind['gust'] as num).toDouble()
          : null,

      cloudiness: (currentJson['clouds']['all'] as num).toInt(),
      rain1h: currentJson['rain'] != null
          ? (currentJson['rain']['1h'] as num?)?.toDouble()
          : null,
      snow1h: currentJson['snow'] != null
          ? (currentJson['snow']['1h'] as num?)?.toDouble()
          : null,

      sunrise: DateTime.fromMillisecondsSinceEpoch(
          (sys['sunrise'] as num).toInt() * 1000),
      sunset: DateTime.fromMillisecondsSinceEpoch(
          (sys['sunset'] as num).toInt() * 1000),
      calculatedAt: DateTime.fromMillisecondsSinceEpoch(
          (currentJson['dt'] as num).toInt() * 1000),

      hourlyForecast: (forecastJson['list'] as List)
          .map((item) => ForecastItem.fromJson(item))
          .toList(),
    );
  }
}


class ForecastItem {
  final DateTime dateTime;
  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int humidity;
  final int weatherConditionId;
  final String weatherMain;
  final String weatherDescription;
  final String weatherIcon;
  final double windSpeed;
  final int windDeg;
  final double? windGust;
  final int cloudiness;    
  final double? rain3h;  
  final double? snow3h;  
  final int? visibility; 
  final double pop;     

  ForecastItem({
    required this.dateTime,
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
    required this.weatherConditionId,
    required this.weatherMain,
    required this.weatherDescription,
    required this.weatherIcon,
    required this.windSpeed,
    required this.windDeg,
    this.windGust,
    required this.cloudiness,
    this.rain3h,
    this.snow3h,
    this.visibility,
    required this.pop,
  });

  String get iconUrl =>
      'https://openweathermap.org/img/wn/$weatherIcon@2x.png';

  factory ForecastItem.fromJson(Map<String, dynamic> json) {
    final main = json['main'] as Map<String, dynamic>;
    final weather = json['weather'][0] as Map<String, dynamic>;
    final wind = json['wind'] as Map<String, dynamic>;

    return ForecastItem(
      dateTime: DateTime.fromMillisecondsSinceEpoch(
          (json['dt'] as num).toInt() * 1000),
      temp: (main['temp'] as num).toDouble(),
      feelsLike: (main['feels_like'] as num).toDouble(),
      tempMin: (main['temp_min'] as num).toDouble(),
      tempMax: (main['temp_max'] as num).toDouble(),
      pressure: (main['pressure'] as num).toInt(),
      humidity: (main['humidity'] as num).toInt(),
      weatherConditionId: weather['id'] ?? 0,
      weatherMain: weather['main'] ?? '',
      weatherDescription: weather['description'] ?? '',
      weatherIcon: weather['icon'] ?? '',
      windSpeed: (wind['speed'] as num).toDouble(),
      windDeg: (wind['deg'] as num? ?? 0).toInt(),
      windGust: wind['gust'] != null
          ? (wind['gust'] as num).toDouble()
          : null,
      cloudiness: (json['clouds']['all'] as num).toInt(),
      rain3h: json['rain'] != null
          ? (json['rain']['3h'] as num?)?.toDouble()
          : null,
      snow3h: json['snow'] != null
          ? (json['snow']['3h'] as num?)?.toDouble()
          : null,
      visibility: json['visibility'] != null
          ? (json['visibility'] as num).toInt()
          : null,
      pop: (json['pop'] as num? ?? 0).toDouble(),
    );
  }
}