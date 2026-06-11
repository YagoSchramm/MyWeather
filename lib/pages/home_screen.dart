import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:myweather/components/forecast_container.dart';
import 'package:myweather/components/umidity_container.dart';
import 'package:myweather/services/weather_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

String getWeatherAnimation(String description) {
  switch (description.toLowerCase()) {
    case 'céu limpo':
    case 'sol':
      return 'assets/animations/Weather-sunny.json';

    case 'algumas nuvens':
    case 'nuvens dispersas':
    case 'parcialmente nublado':
      return 'assets/animations/Weather-partly cloudy.json';
    case 'chuviscos':
    case 'chuva leve':
      return 'assets/animations/Weather-partly shower.json';

    case 'chuva':
    case 'chuva forte':
    case 'trovoada':
    case 'tempestade':
      return 'assets/animations/Weather-storm.json';

    case 'nublado':
    case 'vento':
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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Builder(
          builder: (innerContext) {
            return IconButton(
              onPressed: () {
                Scaffold.of(innerContext).openDrawer();
              },
              icon: const Icon(CupertinoIcons.bars),
              color: Theme.of(context).textTheme.bodySmall!.color,
            );
          },
        ),
        title: Text(
          "MyWeather",
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      drawer: Drawer(
        backgroundColor: const Color.fromARGB(177, 236, 238, 240),
        child: const Column(children: [Spacer(), Text("MyWeather"), Spacer()]),
      ),
      body: Consumer<WeatherProvider>(
        builder: (context, weatherProvider, child) {
          if (weatherProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (weatherProvider.errorMessage == null &&
              weatherProvider.data != null) {
            final String animacao = getWeatherAnimation(
              weatherProvider.data!.weatherDescription,
            );
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
                            Row(
                              children: [
                                Text(
                                  weather.cityName,
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                const SizedBox(width: 8),
                                Icon(
                                  Icons.location_pin,
                                  color: Theme.of(
                                    context,
                                  ).textTheme.titleLarge!.color,
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${weather.temp.toStringAsFixed(1)}°C',
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              weather.weatherDescription.toUpperCase(),
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          ],
                        ),
                        SizedBox(width: 8),
                        SizedBox(
                          height: 150,
                          width: 150,
                          child: Lottie.asset(animacao),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  Text(
                    'Próximas Horas:',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),
                  SizedBox(
                    height: 150,
                    child: ListView.builder(
                      padding: EdgeInsets.only(right: 10),
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
                  SizedBox(height: 8),
                  UmidityContainer(weather: weather),
                  SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 125,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.2),
                                width: 1.5,
                              ),
                            ),
                            child: Center(
                              child: Column(
                                children: [
                                  SizedBox(height: 8),
                                  Text(
                                    "Nascer do Sol:",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodySmall,
                                  ),
                                  SizedBox(height: 8),
                                  SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: Lottie.asset(
                                      "assets/animations/sunrise.json",
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    "${weather.sunrise.hour - 3}:${weather.sunrise.minute.toString().padLeft(2,"0")} hr",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            height: 125,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.2),
                                width: 1.5,
                              ),
                            ),
                            child: Center(
                              child: Column(
                                children: [
                                  SizedBox(height: 8),
                                  Text(
                                    "Pôr do Sol:",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodySmall,
                                  ),
                                  SizedBox(height: 8),
                                  SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: Lottie.asset(
                                      "assets/animations/sunset.json",
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    "${weather.sunset.hour - 3}:${weather.sunset.minute} hr",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
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
