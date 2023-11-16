import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spims/pages/profile/profile_service.dart';

class UserPreferences {
  static String? userRole;
}

Future<Map<String, dynamic>> fetchData(String username) async {
  final url = 'http://localhost:8000/user/users/$username';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);
    return jsonData;
  } else {
    throw Exception('Failed to fetch data from the API');
  }
}

Future<void> fetchUserData() async {
  final prefs = await SharedPreferences.getInstance();
  final username = prefs.getString('username');

  if (username != null) {
    try {
      final userData = await fetchData(username);
      UserPreferences.userRole = userData['role'];
    } catch (e) {
      // Handle specific error scenarios
      if (e is SocketException) {
        // Handle network-related error
        print('Network error occurred: $e');
      } else if (e is http.ClientException) {
        // Handle HTTP client-related error
        print('HTTP error occurred: $e');
      } else {
        // Handle other types of errors
        print('An error occurred: $e');
      }
    }
  }
}
