// import 'package:http/http.dart' as http;
// import 'dart:convert';

// Future<void> fetchData(ai) async {
//   try {
//     final response = await http.get(Uri.parse(apiUrl));

//     if (response.statusCode == 200) {
//       final decodedData = json.decode(response.body);
//       setState(() {
//         dependentData = decodedData;
//         filteredDependentData = decodedData;
//         isLoading = false;
//       });
//     } else {
//       setState(() {
//         errorMessage = 'Failed to fetch data';
//         isLoading = false;
//       });
//     }
//   } catch (e) {
//     setState(() {
//       errorMessage = 'An error occurred';
//       isLoading = false;
//     });
//   }
// }
