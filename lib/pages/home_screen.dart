import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myweather/components/forecast_container.dart';
import 'package:myweather/services/weather_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WeatherProvider>().fetchWeather();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (innerContext) {
            return IconButton(
              onPressed: () {
                Scaffold.of(innerContext).openDrawer();
              },
              icon: const Icon(CupertinoIcons.bars),
            );
          },
        ),
        title: const Text("MyWeather"),
      ),
      drawer: Drawer(
        backgroundColor: const Color.fromARGB(177, 236, 238, 240),
        child: const Column(
          children: [Spacer(), Text("MyWeather"), Spacer()],
        ),
      ),
      body: Consumer<WeatherProvider>(
        builder: (context, weatherProvider, child) {
          if (weatherProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (weatherProvider.errorMessage == null && weatherProvider.data != null) {
            final weather = weatherProvider.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                weather.cityName,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                weather.currentDescription.toUpperCase(),
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                ),
                              ),
                               const SizedBox(height: 8),
                                  Text(
                            '${weather.currentTemp.toStringAsFixed(1)}°C',
                            style: const TextStyle(
                              fontSize: 38,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                            ],
                          ),
                      
                        ],
                      ),
                    ),


                  const SizedBox(height: 24),

                  const Text(
                    'Próximas Horas:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),
               SizedBox(
                height: 150,
                 child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: weather.hourlyForecast.length > 5
                            ? 5
                            : weather.hourlyForecast.length,
                            
                        itemBuilder: (context, index) {
                          final item = weather.hourlyForecast[index];
                          return ForecastContainer(item: item);
                        },
                      ),
               ),

                ],
              ),
            );
          }
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Erro: ${weatherProvider.errorMessage ?? 'Nenhum dado disponível'}",
                style: const TextStyle(color: Colors.red, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          );
        },
      ),
    );
  }
}