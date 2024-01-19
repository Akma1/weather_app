import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String apiKey = 'YOUR_API_KEY';
  String city = 'YOUR_CITY';
  String endpoint = 'https://api.openweathermap.org/data/2.5/weather?q=';
  late Map<String, dynamic> weatherData;

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
  }

  Future<void> fetchWeatherData() async {
    final response = await http.get(Uri.parse('$endpoint$city&appid=$apiKey'));
    if (response.statusCode == 200) {
      setState(() {
        weatherData = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (weatherData != null)
              Text(
                '${weatherData['name']} Weather',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            if (weatherData != null)
              Text(
                '${weatherData['weather'][0]['description']}',
                style: TextStyle(fontSize: 18),
              ),
            if (weatherData != null)
              Text(
                'Temperature: ${weatherData['main']['temp']}°C',
                style: TextStyle(fontSize: 18),
              ),
            if (weatherData != null)
              Text(
                'Humidity: ${weatherData['main']['humidity']}%',
                style: TextStyle(fontSize: 18),
              ),
            if (weatherData != null)
              Text(
                'Wind Speed: ${weatherData['wind']['speed']} m/s',
                style: TextStyle(fontSize: 18),
              ),
          ],
        ),
      ),
    );
  }
}
