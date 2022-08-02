import 'package:flutter_naver_map/flutter_naver_map.dart';

class Rental {
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

  Rental({
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

  factory Rental.fromJson(Map<String, dynamic> json) => Rental(
        id: json['id'],
        position: json['position'],
        umbrellaCount: json['umbrella_count'],
      );
}
