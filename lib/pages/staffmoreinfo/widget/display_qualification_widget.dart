import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../common/app_colors.dart';
import '../../../common/app_responsive.dart';

class DisplayQualificationWidget extends StatefulWidget {
  const DisplayQualificationWidget({super.key});

  @override
  _DisplayDependentWidgetState createState() => _DisplayDependentWidgetState();
}

class _DisplayDependentWidgetState extends State<DisplayQualificationWidget> {
  List<dynamic> qualificationData = [];
  bool isLoading = true;
  String errorMessage = '';
  ScrollController scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();
  static const apiUrl = 'http://127.0.0.1:8000/staff/qualifications';

  List<dynamic> filteredqualificationData = [];
  String filteredData = '';

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body);
        setState(() {
          qualificationData = decodedData;
          filteredqualificationData = decodedData;
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = 'Failed to fetch data';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'An error occurred';
        isLoading = false;
      });
    }
  }

  void filterData(String searchInput) {
    setState(() {
      filteredData = searchInput;

      filteredqualificationData = qualificationData.where((qualification) {
        final String searchData = qualification.toString().toLowerCase();
        return searchData.contains(searchInput.toLowerCase());
      }).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage.isNotEmpty) {
      return Center(child: Text(errorMessage));
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              flex: AppResponsive.isDesktop(context) ? 2 : 1,
              child:
                  const SizedBox(), // Empty space to take up 2/3 of the available space
            ),
            Expanded(
              flex: AppResponsive.isDesktop(context) ? 1 : 3,
              child: TextField(
                style: const TextStyle(color: AppColor.black),
                decoration: const InputDecoration(
                  hintText: 'Search',
                  filled: true,
                  fillColor: AppColor.white,
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(
                    Icons.search,
                    color: AppColor.black,
                  ),
                  contentPadding: EdgeInsets.only(),
                ),
                onChanged: (value) {
                  filterData(value);
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          color: Colors.grey[200],
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: const Row(
            children: [
              SizedBox(width: 48),
              Expanded(
                child: Center(
                  child: Text(
                    'Staff ID',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    'Staff Name',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(),
        Expanded(
          child: ListView.builder(
            controller: scrollController,
            itemCount: filteredqualificationData.length,
            itemBuilder: (BuildContext context, int index) {
              return buildDependentTile(index);
            },
          ),
        ),
      ],
    );
  }

  Widget buildDependentTile(int index) {
    final qualification = filteredqualificationData[index];
    final staffID = qualification['staffid'].toString();
    final staffName = qualification['staff_name'].toString();
    final qualifications = qualification['qualifications'];

    return ExpansionTile(
      title: Row(
        children: [
          const SizedBox(width: 48),
          Expanded(
            child: Center(
              child: Text(
                staffID,
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                staffName,
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
      children: qualifications.map<Widget>((qualificationData) {
        return Card(
          elevation: 1,
          color: AppColor.cardprimary,
          child: ListTile(
            title: Center(
              child: Text(
                'Name: ${qualificationData['name']}',
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            subtitle: Column(
              children: [
                const SizedBox(height: 4),
                Text(
                  "Graduation Date: ${qualificationData['graduationdate']}",
                  style: const TextStyle(color: Colors.black),
                ),
                Text(
                  "Major Field: ${qualificationData['majorfield']}",
                  style: const TextStyle(color: Colors.black),
                ),
                Text(
                  "GPA Grade: ${qualificationData['gpagrade']}",
                  style: const TextStyle(color: Colors.black),
                ),
                Text(
                  "Honors Award: ${qualificationData['honorsaward']}",
                  style: const TextStyle(color: Colors.black),
                ),
                Text(
                  "Institution: ${qualificationData['institution']}",
                  style: const TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
