import 'package:shared_preferences/shared_preferences.dart';

setToken(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('token', token);
}

Future<String?> getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('token');
}

removeToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();
}
