import 'dart:convert';
import 'package:http/http.dart' as http;

import 'create_address.dart';

Future<void> createDependent({
  required String cid,
  required String name,
  required String gender,
  required String phoneNumber,
  required String bloodGroup,
  required String dateOfBirth,
  required String relationType,
  required String villagePerm,
  required String gewogPerm,
  required String dzongkhagPerm,
  required String villageTemp,
  required String gewogTemp,
  required String dzongkhagTemp,
  required String staffID,
}) async {
  final tempAddressID =
      await createAddress(villageTemp, gewogTemp, dzongkhagTemp);
  final permAddressID =
      await createAddress(villagePerm, gewogPerm, dzongkhagPerm);

  final createURL = Uri.parse('http://127.0.0.1:8000/dependent/dependents');
  final checkURL = Uri.parse('http://127.0.0.1:8000/staff/dependents/$staffID');

  final headers = {'Content-Type': 'application/json'};

  final body = jsonEncode({
    'staffid': staffID,
    'cid': cid,
    'name': name,
    'gender': gender,
    'phonenumber': phoneNumber,
    'bloodgroup': bloodGroup,
    'dateofbirth': dateOfBirth,
    'permanentaddress': permAddressID,
    'temporaryaddress': tempAddressID,
    'relationtype': relationType,
  });

  final checkResponse = await http.get(checkURL);
  if (checkResponse.statusCode == 200) {
    final List<dynamic> dependents = jsonDecode(checkResponse.body);

    final existingDependent = dependents.firstWhere(
      (dependent) => dependent['cid'] == cid,
      orElse: () => null,
    );

    if (existingDependent != null) {
      final existingId = existingDependent['number'];
      final updateURL =
          Uri.parse('http://127.0.0.1:8000/dependent/dependents/$existingId');
      final updateResponse =
          await http.put(updateURL, headers: headers, body: body);

      if (updateResponse.statusCode == 200) {
        print('Dependent updated successfully.');
      } else {
        print(
            'Failed to update dependent. Status code: ${updateResponse.statusCode}');
      }
    } else {
      final createResponse =
          await http.post(createURL, headers: headers, body: body);

      if (createResponse.statusCode == 201) {
        print('Dependent created successfully.');
      } else {
        print(
            'Failed to create dependent. Status code: ${createResponse.statusCode}');
      }
    }
  } else {
    print(
        'Failed to fetch dependents. Status code: ${checkResponse.statusCode}');
  }
}
