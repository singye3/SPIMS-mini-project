import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spims/common/utils.dart';

List<String> users = [
  'Student',
  'Staff',
  'Admin',
];

List<String> staffType = [
  'Academic',
  'Non Academic',
];

List<String> genderOptions = [
  'Male',
  'Female',
  'Others',
];

List<String> bloodGroupOptions = [
  'A+',
  'A-',
  'B+',
  'B-',
  'AB+',
  'AB-',
  'O+',
  'O-',
];
List<String> status = [
  "Active",
  "Study Leave",
  "Resignation",
  "Suspended",
  "Deceased",
  "Retired",
  "Maternity Paternity Leave",
  "Medical Leave",
  "On Leave",
  "Probationary"
];

List<String> relationTypeOptions = [
  'Spouse',
  'Child',
  'Parent',
  'Sibling',
  'Other',
];

List<String> honorsAwardOptions = [
  'None',
  'Cum Laude',
  'Magna Cum Laude',
  'Summa Cum Laude',
];

List<String> dzongkhagOptions = [
  'Thimphu',
  'Paro',
  'Punakha',
  'Wangdue Phodrang',
  'Chhukha',
  'Trashigang',
  'Bumthang',
  'Trongsa',
  'Mongar',
  'Gasa',
  'Haa',
  'Samdrup Jongkhar',
  'Tsirang',
  'Dagana',
  'Zhemgang',
  'Pema Gatshel',
  'Lhuentse',
  'Sarpang',
  'Trashiyangtse',
  'Samtse',
];
List<String> directoryNames = [];

Future<void> fetchDirectoryNames() async {
  final response =
      await http.get(Uri.parse('http://127.0.0.1:8000/directory/directories'));

  if (response.statusCode == 200) {
    final List<dynamic> directoriesJson = json.decode(response.body);

    directoryNames = directoriesJson
        .map((directory) => convertToSentenceCase(directory['name'].toString()))
        .toList();
  } else {
    throw Exception('Failed to fetch directory names');
  }
}
