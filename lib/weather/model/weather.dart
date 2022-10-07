import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final url =
    "https://api.openweathermap.org/data/2.5/forecast?cnt=12&units=metric";

enum WeatherType {
  rainny,
  sunny,
  cloudy,
}

class Weather {
  final DateTime? time;
  final double? temperature;
  final WeatherType? status;
  final int? probability;

  Weather({
    this.time,
    this.temperature,
    this.status,
    this.probability,
  });

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        time: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
        temperature: json['main']['temp'].toDouble(),
        probability: (json['pop'] * 100).round(),
        status: parseWeatherStatus(json['weather'][0]['main']),
      );
}

Future<List<Weather>> getWeatherDataAPI(LatLng position) async {
  List<Weather> weathers = [];
  try {
    final response = await http.get(
      Uri.parse(
          "$url&lat=${position.latitude}&lon=${position.longitude}&appid=${dotenv.env['OPEN_WHEATHER_API_KEY']}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );
    if (response.statusCode == 200) {
      final dataset = json.decode(utf8.decode(response.bodyBytes));
      final weatherList = dataset['list'];
      for (Map<String, dynamic> data in weatherList) {
        weathers.add(Weather.fromJson(data));
      }
    }
  } catch (e) {}
  return weathers;
}

WeatherType parseWeatherStatus(String weather) {
  switch (weather) {
    case 'Rain':
      return WeatherType.rainny;
    case 'Clouds':
      return WeatherType.cloudy;
    case 'Sunny':
      return WeatherType.sunny;
    default:
      return WeatherType.sunny;
  }
}
