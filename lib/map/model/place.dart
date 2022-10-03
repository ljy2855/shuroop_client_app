import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:http/http.dart' as http;
import 'package:shuroop_client_app/colors.dart';
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

Future<List<Marker>> getPlaceDataAPI() async {
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

  return getMarkerWithImage(placeList);
}

List<Marker> getMarkerWithImage(final List<Place> places) {
  List<Marker> rentalMarkers = [];
  OverlayImage.fromAssetImage(
    assetName: "assets/images/rentalMarker.png",
    devicePixelRatio: 4.0,
  ).then((image) {
    rentalMarkers.addAll(
        places.map<Marker>((place) => getRentalMarker(image, place)).toList());
  });
  return rentalMarkers;
}

Marker getRentalMarker(OverlayImage image, Place place) => Marker(
      markerId: place.id.toString(),
      position: place.position,
      icon: image,
      alpha: 1.0,
      flat: true,
      captionText: place.umbrellaCount.toString(),
      captionTextSize: 13,
      captionColor: ZeplinColors.white,
      captionOffset: -27,
      anchor: AnchorPoint(0.5, 1),
      width: 30,
      height: 43,
      infoWindow: '${place.name} 지점\n남은 개수: ${place.umbrellaCount}',
    );

Future<String> getPositionToAddress(LatLng position) async {
  String address = "";

  const url =
      "https://naveropenapi.apigw.ntruss.com/map-reversegeocode/v2/gc?output=json";
  try {
    final response = await http.get(
        Uri.parse("$url&coords=${position.longitude},${position.latitude}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'X-NCP-APIGW-API-KEY-ID': "18cehr1pfe",
          'X-NCP-APIGW-API-KEY': "324sXV024P66v8XPFuf3mFXAByg6o5pwkbFqPktu",
        });

    if (response.statusCode == 200) {
      final dataset = json.decode(utf8.decode(response.bodyBytes));

      final area = dataset['results'][0]['region'];
      address = area['area1']['name'] + " " + area['area2']['name'];
    }
  } catch (e) {
    //print(e);
  }
  return address;
}
