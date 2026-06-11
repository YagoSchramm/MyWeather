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

ThemeData get currentTheme {
  if (_data == null) {
    return ThemeData(
      primarySwatch: Colors.blue,
      scaffoldBackgroundColor: Colors.grey[100],
    );
  }

  final descricao = _data!.weatherDescription.toLowerCase();

  if (descricao == 'céu limpo' || descricao == 'sol') {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.orange,
        primary: Colors.orange,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: const Color(0xFFFFF8E1),
      textTheme: const TextTheme(
        displayLarge:  TextStyle(color: Color(0xFFE65100), fontWeight: FontWeight.bold), // temperatura
        titleLarge:    TextStyle(color: Color(0xFFBF360C), fontWeight: FontWeight.bold), // cidade
        labelSmall:    TextStyle(color: Color(0xFFEF6C00), letterSpacing: 1.5),          // descrição caps
        bodyMedium:    TextStyle(color: Color(0xFF5D4037)),                              // valores gerais
        bodySmall:     TextStyle(color: Color(0xFF8D6E63)),                              // labels secundários
      ),
    );
  }

  if (descricao == 'algumas nuvens' ||
      descricao == 'nuvens dispersas' ||
      descricao == 'parcialmente nublado') {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blueGrey,
        primary: Colors.blueGrey[400]!,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: const Color(0xFFECEFF1),
      textTheme: const TextTheme(
        displayLarge:  TextStyle(color: Color(0xFF37474F), fontWeight: FontWeight.bold),
        titleLarge:    TextStyle(color: Color(0xFF263238), fontWeight: FontWeight.bold),
        labelSmall:    TextStyle(color: Color(0xFF546E7A), letterSpacing: 1.5),
        bodyMedium:    TextStyle(color: Color(0xFF455A64)),
        bodySmall:     TextStyle(color: Color(0xFF78909C)),
      ),
    );
  }

  if (descricao == 'chuviscos' || descricao == 'chuva leve') {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blueGrey,
        primary: Colors.blueGrey[600]!,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: const Color(0xFFCFD8DC),
      textTheme: const TextTheme(
        displayLarge:  TextStyle(color: Color(0xFF1A237E), fontWeight: FontWeight.bold),
        titleLarge:    TextStyle(color: Color(0xFF0D1B4B), fontWeight: FontWeight.bold),
        labelSmall:    TextStyle(color: Color(0xFF3949AB), letterSpacing: 1.5),
        bodyMedium:    TextStyle(color: Color(0xFF283593)),
        bodySmall:     TextStyle(color: Color(0xFF5C6BC0)),
      ),
    );
  }

  if (descricao == 'chuva' ||
      descricao == 'chuva forte' ||
      descricao == 'trovoada' ||
      descricao == 'tempestade') {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blueGrey,
        primary: Colors.blueGrey[700]!,
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: const Color(0xFF263238),
      textTheme: const TextTheme(
        displayLarge:  TextStyle(color: Color(0xFFECEFF1), fontWeight: FontWeight.bold),
        titleLarge:    TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.bold),
        labelSmall:    TextStyle(color: Color(0xFF90A4AE), letterSpacing: 1.5),
        bodyMedium:    TextStyle(color: Color(0xFFB0BEC5)),
        bodySmall:     TextStyle(color: Color(0xFF78909C)),
      ),
    );
  }

  if (descricao == 'nublado' ||
      descricao == 'vento' ||
      descricao == 'ventania') {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.grey,
        primary: Colors.grey[600]!,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: const Color(0xFFECEFF1),
      textTheme: const TextTheme(
        displayLarge:  TextStyle(color: Color(0xFF212121), fontWeight: FontWeight.bold),
        titleLarge:    TextStyle(color: Color(0xFF212121), fontWeight: FontWeight.bold),
        labelSmall:    TextStyle(color: Color(0xFF757575), letterSpacing: 1.5),
        bodyMedium:    TextStyle(color: Color(0xFF424242)),
        bodySmall:     TextStyle(color: Color(0xFF9E9E9E)),
      ),
    );
  }

  if (descricao == 'nascer do sol') {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.deepOrange,
        primary: Colors.deepOrange[300]!,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: const Color(0xFFFFECB3),
      textTheme: const TextTheme(
        displayLarge:  TextStyle(color: Color(0xFFE64A19), fontWeight: FontWeight.bold),
        titleLarge:    TextStyle(color: Color(0xFFBF360C), fontWeight: FontWeight.bold),
        labelSmall:    TextStyle(color: Color(0xFFFF7043), letterSpacing: 1.5),
        bodyMedium:    TextStyle(color: Color(0xFF6D4C41)),
        bodySmall:     TextStyle(color: Color(0xFF8D6E63)),
      ),
    );
  }

  if (descricao == 'pôr do sol') {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.deepOrange,
        primary: Colors.deepOrange[700]!,
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: const Color(0xFF4E342E),
      textTheme: const TextTheme(
        displayLarge:  TextStyle(color: Color(0xFFFFCCBC), fontWeight: FontWeight.bold),
        titleLarge:    TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.bold),
        labelSmall:    TextStyle(color: Color(0xFFFFAB91), letterSpacing: 1.5),
        bodyMedium:    TextStyle(color: Color(0xFFFFCCBC)),
        bodySmall:     TextStyle(color: Color(0xFFBCAAA4)),
      ),
    );
  }

  return ThemeData(
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: Colors.grey[100],
  );
}

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