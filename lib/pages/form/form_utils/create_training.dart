import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spims/pages/form/form_utils/create_institution.dart';

Future<void> createOrUpdateTraining(
    {required String name,
    required String startingDate,
    required String endingDate,
    required String institutionName,
    required String institutionLocation,
    required String staffID}) async {
  final createURL = Uri.parse('http://127.0.0.1:8000/training/trainings');

  final checkURL =
      Uri.parse('http://127.0.0.1:8000/training/trainings/name/$name');

  final institutionid = await createOrGetInstitution(
      name: institutionName, location: institutionLocation);

  final headers = {'Content-Type': 'application/json'};

  final training = {
    'name': name,
    'startingdate': startingDate,
    'endingdate': endingDate,
    'institutionid': institutionid,
  };

  final body = jsonEncode(training);

  final checkResponse = await http.get(checkURL);
  if (checkResponse.statusCode == 200) {
    final List<dynamic> trainings = jsonDecode(checkResponse.body);

    final existingTraining = trainings.firstWhere(
      (training) =>
          training['name'] == name &&
          training['institutionid'] == institutionid,
      orElse: () => null,
    );

    if (existingTraining != null) {
      final existingId = existingTraining['trainingid'];
      final updateURL =
          Uri.parse('http://localhost:8000/training/trainings/$existingId');
      final updateResponse =
          await http.put(updateURL, headers: headers, body: body);

      if (updateResponse.statusCode == 200) {
        createStaffTraining(staffID: staffID, trainingID: existingId);
      } else {
        print(
            'Failed to update training. Status code: ${updateResponse.statusCode}');
      }
    } else {
      final createResponse =
          await http.post(createURL, headers: headers, body: body);

      if (createResponse.statusCode == 200) {
        final responseData = jsonDecode(createResponse.body);
        print(responseData);
        final id = responseData['trainingid'];
        print(id);
        createStaffTraining(staffID: staffID, trainingID: id);
      } else {
        print(
            'Failed to create training. Status code: ${createResponse.statusCode}');
      }
    }
  } else {
    print(
        'Failed to fetch trainings. Status code: ${checkResponse.statusCode}');
  }
}

Future<void> createStaffTraining(
    {required String staffID, required int trainingID}) async {
  final createURL =
      Uri.parse('http://127.0.0.1:8000/stafftraining/stafftraining');

  final checkURL = Uri.parse(
      'http://127.0.0.1:8000/stafftraining/stafftraining/$staffID/$trainingID');

  final body = jsonEncode({"staffid": staffID, "trainingid": trainingID});
  final headers = {'Content-Type': 'application/json'};

  final checkResponse = await http.get(checkURL);
  if (checkResponse.statusCode == 200) {
    final Map<String, dynamic> stafftraining = jsonDecode(checkResponse.body);

    if (stafftraining.isEmpty) {
      final createResponse =
          await http.post(createURL, headers: headers, body: body);
      if (createResponse.statusCode == 201) {
        print('StaffTraining created successfully.');
      } else {
        print(
            'Failed to create StaffTraining. Status code: ${createResponse.statusCode}');
      }
    } else {
      print(
          'Failed to fetch trainings. Status code: ${checkResponse.statusCode}');
    }
  }
}
