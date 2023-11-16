import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spims/pages/form/form_utils/create_institution.dart';

Future<void> createQualification({
  required String name,
  required String institutionName,
  required String institutionLocation,
  required String majorField,
  required String graduationDate,
  required String gpaGrade,
  required String honorsAward,
  required String staffID,
}) async {
  final createURL =
      Uri.parse('http://localhost:8000/qualification/qualifications');

  final checkURL =
      Uri.parse('http://localhost:8000/staff/qualifications/$staffID');

  final institutionid = await createOrGetInstitution(
      name: institutionName, location: institutionLocation);

  final headers = {'Content-Type': 'application/json'};

  final qualification = {
    'institutionid': institutionid,
    'name': name,
    'graduationdate': graduationDate,
    'majorfield': majorField,
    'gpagrade': gpaGrade,
    'honorsaward': honorsAward,
    'staffid': staffID,
  };

  print(qualification);

  final body = jsonEncode(qualification);

  final checkResponse = await http.get(checkURL);
  if (checkResponse.statusCode == 200) {
    final List<dynamic> qualifications = jsonDecode(checkResponse.body);

    final existingQualification = qualifications.firstWhere(
      (qualification) =>
          qualification['name'] == name &&
          qualification['institutionid'] == institutionid,
      orElse: () => null,
    );

    if (existingQualification != null) {
      final existingId = existingQualification['id'];
      final updateURL = Uri.parse(
          'http://localhost:8000/qualification/qualifications/$existingId');
      final updateResponse =
          await http.put(updateURL, headers: headers, body: body);

      if (updateResponse.statusCode == 200) {
        print('Qualification updated successfully.');
      } else {
        print(
            'Failed to update qualification. Status code: ${updateResponse.statusCode}');
      }
    } else {
      final createResponse =
          await http.post(createURL, headers: headers, body: body);

      if (createResponse.statusCode == 200) {
        print('Qualification created successfully.');
      } else {
        print(
            'Failed to create qualification. Status code: ${createResponse.statusCode}');
      }
    }
  } else {
    print(
        'Failed to fetch qualifications. Status code: ${checkResponse.statusCode}');
  }
}
