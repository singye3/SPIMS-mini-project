import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../common/app_colors.dart';
import '../../../common/utils.dart';

class StaffBasicDisplay extends StatefulWidget {
  final String staffId;

  const StaffBasicDisplay({Key? key, required this.staffId}) : super(key: key);

  @override
  _StaffBasicDisplayState createState() => _StaffBasicDisplayState();
}

class _StaffBasicDisplayState extends State<StaffBasicDisplay> {
  Future<Map<String, dynamic>>? staffDataFuture;
  bool showCard = true; // Track whether to show the card or not

  @override
  void initState() {
    super.initState();
    staffDataFuture = fetchStaffData();
  }

  @override
  void didUpdateWidget(covariant StaffBasicDisplay oldWidget) {
    showCard = true;
    super.didUpdateWidget(oldWidget);
    if (widget.staffId != oldWidget.staffId) {
      staffDataFuture = fetchStaffData();
    }
  }

  Future<Map<String, dynamic>> fetchStaffData() async {
    final apiUrl = 'http://127.0.0.1:8000/staff/staff/${widget.staffId}/basic';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.body);
        return decodedJson;
      } else {
        throw Exception('Failed to load staff data');
      }
    } catch (error) {
      print(error);
      throw Exception('Failed to load staff data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: staffDataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return const Text('Failed to load staff data');
        } else if (!snapshot.hasData) {
          return const Text('No staff data available');
        } else {
          final staffData = snapshot.data!;

          if (!showCard) {
            return Container(); // Return an empty container if the card should not be shown
          }

          return Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(1000),
                          child: Image.asset(
                            "assets/user1.jpg",
                            height: 60,
                            width: 60,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          children: [
                            Text(
                              staffData['name'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              staffData['positiontitle'],
                              style: const TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Divider(
                      thickness: 0.5,
                      color: Colors.grey,
                    ),
                    profileListTile("Gender", staffData['gender']),
                    profileListTile("Email", staffData['email']),
                    profileListTile("Phone Number", staffData['phonenumber']),
                    profileListTile("Staff Status", staffData['staffstatus']),
                    const Divider(
                      thickness: 0.5,
                      color: Colors.grey,
                    ),
                    directoryTile("Directory", staffData['directory']),
                    const Divider(
                      thickness: 0.5,
                      color: Colors.grey,
                    ),
                    qualificationTile(
                        "Qualifications", staffData['qualification']),
                    const Divider(
                      thickness: 0.5,
                      color: Colors.grey,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.facebook,
                          color: AppColor.accent,
                        ),
                        Icon(
                          Icons.facebook,
                          color: AppColor.accent,
                        ),
                        Icon(
                          Icons.facebook,
                          color: AppColor.accent,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      showCard =
                          false; // Set showCard to false to hide the card
                    });
                  },
                  child: const Icon(
                    Icons.close,
                    color: Colors.grey,
                    size: 15,
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }

  Widget profileListTile(String text, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: const TextStyle(color: AppColor.black),
          ),
          Text(
            text == 'Email' ? value : convertToSentenceCase(value),
            style: const TextStyle(
              color: AppColor.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget qualificationTile(String text, List<dynamic> value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: const TextStyle(
                color: AppColor.black, fontWeight: FontWeight.bold),
          ),
          Column(
            children: value
                .map((item) => Text(
                      item,
                      style: const TextStyle(
                        color: AppColor.black,
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget directoryTile(String text, directory) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: const TextStyle(
                color: AppColor.black, fontWeight: FontWeight.bold),
          ),
          Text(
            convertToSentenceCase(directory),
            style: const TextStyle(
              color: AppColor.black,
            ),
          ),
        ],
      ),
    );
  }
}
