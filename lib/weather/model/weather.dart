import 'package:http/http.dart' as http;
import 'dart:convert';

final url =
    "https://api.openweathermap.org/data/2.5/forecast?lat=37&lon=127&appid=b879570823b7635744c07ca7594bc21e&units=metric";

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
        time: DateTime.parse(json['dt_txt']),
        temperature: json['main']['temp'].toDouble(),
        probability: (json['pop'] * 100).round(),
        status: parseWeatherStatus(json['weather'][0]['main']),
      );
}

Future<List<Weather>> getWeatherDataAPI() async {
  List<Weather> weathers = [];
  try {
    final response = await http.get(
      Uri.parse(url),
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
  } catch (e) {
    print(e);
  }
  return weathers;
}

WeatherType parseWeatherStatus(String weather) {
  switch (weather) {
    case 'Rain':
      return WeatherType.rainny;
    case 'Clouds':
      return WeatherType.cloudy;
    default:
      return WeatherType.sunny;
  }
}
