import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:myweather/entities/weather.dart';

class ForecastContainer extends StatelessWidget {
  ForecastContainer({super.key, required this.item});
  final ForecastItem item;
  String getWeatherAnimation(String description) {
    switch (description.toLowerCase()) {
      case 'céu limpo':
      case 'sol':
        return 'assets/animations/Weather-sunny.json';

      case 'algumas nuvens':
      case 'nuvens dispersas':
      case 'parcialmente nublado':
        return 'assets/animations/Weather-partly cloudy.json';
      case 'tempo nublado':
      case 'chuviscos':
      case 'chuva leve':
        return 'assets/animations/Weather-partly shower.json';

      case 'chuva':
      case 'chuva forte':
      case 'trovoada':
      case 'tempestade':
        return 'assets/animations/Weather-storm.json';

      case 'vento':
      case 'nublado':
      case 'ventania':
        return 'assets/animations/Weather-windy.json';

      case 'nascer do sol':
        return 'assets/animations/sunrise.json';
      case 'pôr do sol':
        return 'assets/animations/sunset.json';

      default:
        return 'assets/animations/Weather-sunny.json';
    }
  }

  @override
  Widget build(BuildContext context) {
    final String animacao = getWeatherAnimation(item.weatherDescription);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color.fromARGB(62, 255, 255, 255),
        ),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 8),
              Text(
                "${item.dateTime.hour}:00 hr",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),

              SizedBox(height: 10),
              SizedBox(width: 50, height: 50, child: Lottie.asset(animacao)),
              SizedBox(height: 10),
              Text(
                '${item.temp.toStringAsFixed(1)}°C ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
