import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
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

enum PlaceRecordType {
  search,
  favorite,
}

class PlaceRecord {
  final int? id;
  final Place? place;

  PlaceRecord({
    this.id,
    this.place,
  });

  factory PlaceRecord.fromJson(
    Map<String, dynamic> json,
    PlaceRecordType type,
  ) =>
      PlaceRecord(
          id: json['id'],
          place: type == PlaceRecordType.search
              ? Place.fromJson(json['search_place'])
              : Place.fromJson(json['favorite_place']));
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
          'X-NCP-APIGW-API-KEY-ID': dotenv.env['X-NCP-APIGW-API-KEY-ID']!,
          'X-NCP-APIGW-API-KEY': dotenv.env['X-NCP-APIGW-API-KEY']!,
        });

    if (response.statusCode == 200) {
      final dataset = json.decode(utf8.decode(response.bodyBytes));

      final area = dataset['results'][0]['region'];
      address = area['area1']['name'] + " " + area['area2']['name'];
    }
  } catch (e) {}
  return address;
}

Future<List<PlaceRecord>> getSearchPlaces(String? token) async {
  List<PlaceRecord> places = [];
  if (token == null) return places;
  try {
    final response = await http.get(
      Uri.parse("${UrlPrefix.urls}rentals/places/search/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Token $token',
      },
    );

    if (response.statusCode == 200) {
      final dataset = json.decode(utf8.decode(response.bodyBytes));

      for (Map<String, dynamic> data in dataset) {
        places.add(PlaceRecord.fromJson(data, PlaceRecordType.search));
      }
    }
  } catch (e) {}

  return places;
}

Future<List<PlaceRecord>> getFavoritePlaces(String? token) async {
  List<PlaceRecord> places = [];
  if (token == null) return places;
  try {
    final response = await http.get(
      Uri.parse("${UrlPrefix.urls}rentals/places/favorite/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Token $token',
      },
    );

    if (response.statusCode == 200) {
      final dataset = json.decode(utf8.decode(response.bodyBytes));

      for (Map<String, dynamic> data in dataset) {
        places.add(PlaceRecord.fromJson(data, PlaceRecordType.favorite));
      }
    }
  } catch (e) {}

  return places;
}

Future<void> removePlaceRecord(
    int id, String token, PlaceRecordType type) async {
  final String url = type == PlaceRecordType.favorite
      ? "${UrlPrefix.urls}rentals/places/favorite/remove/$id/"
      : "${UrlPrefix.urls}rentals/places/search/remove/$id/";
  try {
    final response = await http.delete(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Token $token',
      },
    );
  } catch (e) {}
}

Future<List<Place>> searchPlacesWithKeyword(String keyword) async {
  final List<Place> places = [];
  try {
    final response = await http.get(
      Uri.parse("${UrlPrefix.urls}rentals/places/search/$keyword/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      final dataset = json.decode(utf8.decode(response.bodyBytes));

      for (Map<String, dynamic> data in dataset) {
        places.add(Place.fromJson(data));
      }
    }
  } catch (e) {}

  return places;
}

Future<void> addFavoritePlace(int id, String? token) async {
  if (token == null) return;
  try {
    final response = await http.get(
      Uri.parse("${UrlPrefix.urls}rentals/places/favorite/add/$id/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Token $token',
      },
    );
  } catch (e) {}
}

Future<void> addSearchedPlace(int id, String? token) async {
  if (token == null) return;
  try {
    final response = await http.get(
      Uri.parse("${UrlPrefix.urls}rentals/places/search/add/$id/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Token $token',
      },
    );
  } catch (e) {}
}
