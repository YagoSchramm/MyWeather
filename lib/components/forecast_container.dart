import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:myweather/entities/weather.dart';

class ForecastContainer extends StatelessWidget {
  const ForecastContainer({super.key, required this.item});
  final ForecastItem item;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height:120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.blue,
      ),
      child: Center(
        child: Column(
          children: [
            Text('${item.temp.toStringAsFixed(1)}°C - ${item.description}'),
            SizedBox(height: 10,),
            Container(
              width: 50,
              height: 50,
              child: Lottie.asset(
                'assets/animations/Weather-sunny.json',
              ),
            ),
      SizedBox(height: 10,),
            Text('Horário: ${item.dateTime}'),
          ],
        ),
      ),
    );
  }
}
