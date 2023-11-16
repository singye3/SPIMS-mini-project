import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class ProfileService {
  static const apiBaseUrl = 'http://127.0.0.1:8000/staff/staff/';

  static Future<Map<String, dynamic>> fetchProfileData() async {
    final username = await loadLoginInfo();

    final response = await http.get(Uri.parse(apiBaseUrl + username!));

    if (response.statusCode == 200) {
      final profile = json.decode(response.body);
      return profile;
    }

    throw Exception('Failed to fetch data');
  }

  static Future<String?> loadLoginInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username');

    return username;
  }
}
