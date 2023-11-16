import 'dart:convert';
import 'package:http/http.dart' as http;

Future<int> createOrGetInstitution({
  required String name,
  required String location,
}) async {
  final checkURL =
      Uri.parse('http://localhost:8000/institution/institutions/name/$name');
  final createURL = Uri.parse('http://localhost:8000/institution/institutions');
  final headers = {'Content-Type': 'application/json'};

  final checkResponse = await http.get(checkURL);

  if (checkResponse.statusCode == 200) {
    final List<dynamic> institutions = jsonDecode(checkResponse.body);
    final existingInstitution = institutions.firstWhere(
      (institution) =>
          institution['name'] == name && institution['location'] == location,
      orElse: () => null,
    );

    if (existingInstitution != null) {
      final existingId = existingInstitution['id'];
      return existingId;
    }
  } else if (checkResponse.statusCode != 404) {
    throw Exception(
        'Failed to check institution. Status code: ${checkResponse.statusCode}');
  }

  final institution = {
    'name': name,
    'location': location,
  };

  final body = jsonEncode(institution);

  final createResponse =
      await http.post(createURL, headers: headers, body: body);

  if (createResponse.statusCode == 201) {
    final responseData = jsonDecode(createResponse.body);
    final createdId = responseData['id'];
    return createdId;
  } else {
    throw Exception(
        'Failed to create institution. Status code: ${createResponse.statusCode}');
  }
}
