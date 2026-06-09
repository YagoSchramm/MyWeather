import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  WeatherProvider().fetchWeather();
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: Icon(CupertinoIcons.bars),
        ),
        title: Text("MyWeather"),
      ),
      drawer: Drawer(
        backgroundColor: const Color.fromARGB(177, 236, 238, 240),
        child: Column(children: [Spacer(), Text("MyWeather"), Spacer()]),
      ),
      body: Consumer<WeatherProvider>(
        builder: (context, weatherProvider, child) {
          if (weatherProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (weatherProvider.errorMessage == null) {
            final weather = weatherProvider.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Informações do Clima Atual
                  Card(
                    elevation: 4,
                    child: Padding(
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
                            ],
                          ),
                          Text(
                            '${weather.currentTemp.toStringAsFixed(1)}°C',
                            style: const TextStyle(
                              fontSize: 38,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    'Próximas Horas (Previsão):',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Lista com a previsão futura utilizando a nossa entidade tipada
                  Expanded(
                    child: ListView.builder(
                      itemCount: weather.hourlyForecast.length > 5
                          ? 5
                          : weather.hourlyForecast.length,
                      itemBuilder: (context, index) {
                        final item = weather.hourlyForecast[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          child: ListTile(
                            leading: const Icon(Icons.access_time),
                            title: Text(
                              '${item.temp.toStringAsFixed(1)}°C - ${item.description}',
                            ),
                            subtitle: Text('Horário: ${item.dateTime}'),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }

          return Center(
            child: Container(
              color: Colors.white,
              child: Text("Erro:${weatherProvider.errorMessage}"),
            ),
          );
        },
      ),
    );
  }
}
