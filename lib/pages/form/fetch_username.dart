import 'package:shared_preferences/shared_preferences.dart';

Future<String?> fetchUsername() async {
  final prefs = await SharedPreferences.getInstance();
  final storedUsername = prefs.getString('username');
  return storedUsername;
}
