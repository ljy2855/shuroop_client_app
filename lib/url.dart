import 'package:flutter_dotenv/flutter_dotenv.dart';

class UrlPrefix {
  // static var urls = "http://10.0.2.2/";
  static String urls = dotenv.env['SERVER_URL'] ?? "http://10.0.2.2/";
}
