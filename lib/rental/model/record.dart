import 'package:http/http.dart' as http;
import 'dart:convert';

class Record {
  final DateTime? returnTime;
  final DateTime? borrowTime;
  final Duration? overTime;

  Record({
    this.returnTime,
    this.borrowTime,
    this.overTime,
  });

  factory Record.fromJson(Map<String, dynamic> json) => Record(
        returnTime: json['return_time'],
        borrowTime: json['borrow_time'],
        overTime: json['over_time'],
      );
}
