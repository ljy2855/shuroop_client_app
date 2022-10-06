import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shuroop_client_app/auth/model/profile.dart';

class Record {
  final DateTime? returnTime;
  final DateTime? borrowTime;
  final Duration? overTime;
  final int? charge;

  Record({
    this.charge,
    this.returnTime,
    this.borrowTime,
    this.overTime,
  });

  factory Record.fromJson(Map<String, dynamic> json) => Record(
        returnTime: DateTime.parse(json['return_time']),
        borrowTime: DateTime.parse(json['borrow_time']),
        overTime: parseDuration(json['over_time']),
        charge: json['charge'],
      );
}
