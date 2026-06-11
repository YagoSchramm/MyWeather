import 'package:flutter/material.dart';
import 'package:myweather/entities/weather.dart';

class UmidityContainer extends StatelessWidget {
  const UmidityContainer({super.key, required this.weather});
  final WeatherModel weather;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.5),
        ),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 8),
              Text(
                "Umidade:",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
                   SizedBox(height: 12),
              Stack(
                alignment: AlignmentGeometry.center,
                children: [
                  SizedBox(
                    width: 150,
                    height: 150,
                    child: CircularProgressIndicator(
                      value: (weather.humidity/100).toDouble(),
                      strokeWidth: 15,
                      backgroundColor: Colors.white.withOpacity(0.2),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Colors.blue,
                      ),
                    ),
                  ),
                  Text(
                    '${(weather.humidity).toInt()}%',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
