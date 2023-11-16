import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spims/pages/dashboard/widget/add_staff_widget.dart';

import 'create_address.dart';

Future<int> getDirectoryID(String name) async {
  final url =
      Uri.parse('http://127.0.0.1:8000/directory/directories/name/$name');

  final response = await http.get(url);
  if (response.statusCode == 200) {
    final directoryID = int.parse(response.body);
    return directoryID;
  } else {
    throw Exception('Failed to get directory ID: ${response.statusCode}');
  }
}

Future<void> createStaff({
  required String staffID,
  required String name,
  required String email,
  required String gender,
  required String dob,
  required String bloodGroup,
  required String phoneNumber,
  required String nationality,
  required String status,
  required String staffType,
  required String villagePerm,
  required String gewogPerm,
  required String dzongkhagPerm,
  required String villageTemp,
  required String gewogTemp,
  required String dzongkhagTemp,
  required String positionLevel,
  required String positionTitle,
  required String directory,
  required String joiningDate,
  required String cid,
}) async {
  final tempAddressID =
      await createAddress(villageTemp, gewogTemp, dzongkhagTemp);
  final permAddressID =
      await createAddress(villagePerm, gewogPerm, dzongkhagPerm);
  final directoryID = await getDirectoryID(directory);

  final createURL = Uri.parse('http://127.0.0.1:8000/staff/staff');
  final updateURL = Uri.parse('http://127.0.0.1:8000/staff/staff/$staffID');
  final checkURL =
      Uri.parse('http://127.0.0.1:8000/staff/staff/check/$staffID');

  final headers = {'Content-Type': 'application/json'};

  final body = jsonEncode({
    'staffid': staffID,
    'cid': cid,
    'name': name,
    'gender': gender,
    'nationality': nationality,
    'phonenumber': phoneNumber,
    'email': email,
    'bloodgroup': bloodGroup,
    'dateofbirth': dob,
    'permanentaddress': permAddressID,
    'temporaryaddress': tempAddressID,
    'joiningdate': joiningDate,
    'staffstatus': status,
    'positionlevel': positionLevel,
    'positiontitle': positionTitle,
    'stafftype': staffType,
    'directoryid': directoryID,
  });

  try {
    final checkResponse = await http.get(checkURL);
    if (checkResponse.statusCode == 200) {
      final bool staffExists = jsonDecode(checkResponse.body);
      if (staffExists) {
        final updateResponse =
            await http.put(updateURL, headers: headers, body: body);
        if (updateResponse.statusCode == 200) {
          print('Staff information updated successfully!');
        } else {
          print(
              'Failed to update staff information. Status code: ${updateResponse.statusCode}');
        }
      } else {
        // Staff doesn't exist, create a new staff
        final createResponse =
            await http.post(createURL, headers: headers, body: body);
        if (createResponse.statusCode == 200) {
          final checkResponse = await http
              .get(Uri.parse("http://localhost:8000/user/users/$staffID"));
          final response = jsonDecode(checkResponse.body);

          if (response.isEmpty) {
            createUser(
                username: staffID,
                password: 'password',
                selectedRole: 'Staff',
                email: email);
          }
        } else {
          print(
              'Failed to create new staff. Status code: ${createResponse.statusCode}');
        }
      }
    } else {
      print(
          'Failed to check staff information. Status code: ${checkResponse.statusCode}');
    }
  } catch (error) {
    print('Failed to update/create staff information: $error');
  }
}
