import 'package:flutter/material.dart';
import 'package:myweather/entities/weather.dart';
import 'package:myweather/services/weather_webservice.dart';

class WeatherProvider extends ChangeNotifier{
  final WeatherWebservice _webservice=WeatherWebservice();
  
  WeatherModel? _data;
  bool _isLoading = false;
  String? _errorMessage;

  WeatherModel? get data=>_data;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchWeather() async{
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      _data = await _webservice.getWeather();
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

   List<ForecastItem> get hourlyForecast => _data!.hourlyForecast;
   
  }