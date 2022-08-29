import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shuroop_client_app/url.dart';

class Place {
  final int? id; // pk
  final String? name;
  final String? address;
  final LatLng? position;
  final int? umbrellaCount;
  final int? maxCount;
  final bool? isEmpty;
  final bool? isFull;
  final String? description;
  final String? imageUrl;

  Place({
    this.id,
    this.name,
    this.address,
    this.position,
    this.umbrellaCount,
    this.maxCount,
    this.isEmpty,
    this.isFull,
    this.description,
    this.imageUrl,
  });

  factory Place.fromJson(Map<String, dynamic> json) => Place(
        id: json['id'],
        name: json['name'],
        address: json['address'],
        position: LatLng(double.parse(json['position']['latitude']),
            double.parse(json['position']['longitude'])),
        maxCount: json['max_count'],
        isEmpty: json['is_empty'],
        isFull: json['is_full'],
        description: json['description'],
        umbrellaCount: json['umbrella_count'],
      );
}

Future<List<Place>> getPlaceDataAPI() async {
  List<Place> placeList = [];
  try {
    final response = await http.get(
      Uri.parse(
        '${UrlPrefix.urls}rentals/places/',
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );
    if (response.statusCode == 200) {
      final dataset = json.decode(utf8.decode(response.bodyBytes));

      for (Map<String, dynamic> data in dataset) {
        placeList.add(Place.fromJson(data));
      }
    }
  } catch (e) {}

  return placeList;
}
