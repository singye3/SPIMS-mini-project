import 'dart:convert';
import 'package:http/http.dart' as http;

Future<int> createAddress(
    String villageName, String gewog, String dzongkhag) async {
  final url = Uri.parse('http://127.0.0.1:8000/address/addresses');

  final headers = {'Content-Type': 'application/json'};

  final body = jsonEncode({
    'villagename': villageName,
    'gewog': gewog,
    'dzongkhag': dzongkhag,
  });

  try {
    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final addressId = responseData['addressid'];

      print('Address created successfully!');
      return addressId;
    } else {
      print('Failed to create address. Status code: ${response.statusCode}');
      return 0; // or any other value to indicate failure
    }
  } catch (error) {
    print('Failed to create address: $error');
    return 0; // or any other value to indicate failure
  }
}
