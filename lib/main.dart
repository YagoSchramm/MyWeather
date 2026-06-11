import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:myweather/pages/home_screen.dart';
import 'package:myweather/services/weather_provider.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  runApp(
    ChangeNotifierProvider(
      create: (context) => WeatherProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(
      builder: (context, weatherProvider, child) {
        return MaterialApp(
          title: 'MyWeather',
          debugShowCheckedModeBanner: false,
          theme: weatherProvider.currentTheme, 
          home: const HomeScreen(),
        );
      },
    );
  }
}
