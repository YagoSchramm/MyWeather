import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:myweather/entities/weather.dart';

class WeatherWebservice {
  final String _baseUrl='https://api.openweathermap.org/data/2.5';

  Future<Position> _getPosition() async{
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled=await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('O serviço de localização está desativado.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('A permissão de localização foi negada.');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('As permissões de localização estão negadas permanentemente.');
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<WeatherModel> getWeather() async{
    try {
      final key=dotenv.env["API_KEY"];
      if (key == null || key.isEmpty) throw Exception("API Key não encontrada.");

      Position position=await _getPosition();
      final double lat = position.latitude;
      final double lon = position.longitude;
      final currentUrl = Uri.parse('$_baseUrl/weather?lat=$lat&lon=$lon&appid=$key&units=metric&lang=pt_br');
      final forecastUrl = Uri.parse('$_baseUrl/forecast?lat=$lat&lon=$lon&appid=$key&units=metric&lang=pt_br');

      final responses= await Future.wait([
        http.get(currentUrl),
        http.get(forecastUrl)
      ]);

      if(responses[0].statusCode==200 && responses[1].statusCode==200){
        final currentData = jsonDecode(responses[0].body);
        final forecastData = jsonDecode(responses[1].body);
        return WeatherModel.fromApi(
          currentJson: currentData, 
          forecastJson: forecastData);
      } else{
        throw Exception('Falha ao carregar dados da API');
      }
    } catch (e) {
      throw Exception('Erro no WebService: $e');
    }
  }
}