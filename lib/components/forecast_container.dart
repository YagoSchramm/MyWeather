import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:myweather/entities/weather.dart';

class ForecastContainer extends StatelessWidget {
   ForecastContainer({super.key, required this.item});
  final ForecastItem item;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 120,
        height:120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color.fromARGB(62, 255, 255, 255),
       
        ),
        child: Center(
          child: Column(
            children: [
                    SizedBox(height: 8,),
                       Text("${item.dateTime.hour}:00 hr",
                       style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500
                       ),),
         
              SizedBox(height: 10,),
              SizedBox(
                width: 50,
                height: 50,
                child: Lottie.asset(
                  'assets/animations/Weather-sunny.json',
                ),
              ),
        SizedBox(height: 10,),
                Text('${item.temp.toStringAsFixed(1)}°C ',
                 style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500
                       ),),
            ],
          ),
        ),
      ),
    );
  }
}
