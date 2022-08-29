import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shuroop_client_app/auth/provider/token.dart';
import 'package:shuroop_client_app/url.dart';

class Profile {
  final int? userId;
  final bool? isRenting;
  final Duration? leftTime;

  Profile({
    this.userId,
    this.isRenting,
    this.leftTime,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        userId: json['user_id'],
        isRenting: json['is_renting'],
        leftTime: parseDuration(json['left_time']),
      );
}

Duration parseDuration(String s) {
  final List<String> parts = s.split(' ');

  if (parts.length == 1) {
    final List<String> part = parts[0].split(':');
    final int hours = int.parse(part[0]);
    final int minutes = int.parse(part[1]);
    final int seconds = int.parse(part[2]);
    return Duration(hours: hours, minutes: minutes, seconds: seconds);
  } else {
    final List<String> part = parts[1].split(':');
    final int days = int.parse(parts[0]);
    final int hours = int.parse(part[0]);
    final int minutes = int.parse(part[1]);
    final int seconds = int.parse(part[2].split('.')[0]); // For over limit time
    return Duration(
        days: days, hours: hours, minutes: minutes, seconds: seconds);
  }
}

// ignore: body_might_complete_normally_nullable
Future<Profile?> getProfileDataAPI() async {
  String? token;
  await getToken().then((value) {
    token = value;
  });
  print(token);

  try {
    final response = await http.post(
      Uri.parse(
        '${UrlPrefix.urls}users/check/token/',
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Token $token'
      },
    );
    if (response.statusCode == 200) {
      final data = json.decode(utf8.decode(response.bodyBytes));
      print(data);
      return Profile.fromJson(data);
    }
  } catch (e) {}
}
