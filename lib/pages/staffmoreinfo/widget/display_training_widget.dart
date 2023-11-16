import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../common/app_colors.dart';
import '../../../common/app_responsive.dart';

class DisplayTrainingWidget extends StatefulWidget {
  const DisplayTrainingWidget({super.key});

  @override
  _DisplayTrainingWidgetState createState() => _DisplayTrainingWidgetState();
}

class _DisplayTrainingWidgetState extends State<DisplayTrainingWidget> {
  List<dynamic> trainingData = [];
  bool isLoading = true;
  String errorMessage = '';
  ScrollController scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();
  static const apiUrl = 'http://127.0.0.1:8000/staff/trainings';

  List<dynamic> filteredtrainingData = [];
  String filteredData = '';

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body);
        setState(() {
          trainingData = decodedData;
          filteredtrainingData = decodedData;
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

      filteredtrainingData = trainingData.where((training) {
        final String searchData = training.toString().toLowerCase();
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
              flex: 1,
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
            itemCount: filteredtrainingData.length,
            itemBuilder: (BuildContext context, int index) {
              return buildDependentTile(index);
            },
          ),
        ),
      ],
    );
  }

  Widget buildDependentTile(int index) {
    final training = filteredtrainingData[index];
    final staffID = training['staffid'].toString();
    final staffName = training['staff_name'].toString();
    final trainings = training['trainings'];

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
      children: trainings.map<Widget>((trainingData) {
        return Card(
          elevation: 1,
          color: AppColor.cardprimary,
          child: ListTile(
            title: Center(
              child: Text(
                'Name: ${trainingData['name']}',
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
                  "Institution Name: ${trainingData['institution_name']}",
                  style: const TextStyle(color: Colors.black),
                ),
                Text(
                  "Starting Date: ${trainingData['startingdate']}",
                  style: const TextStyle(color: Colors.black),
                ),
                Text(
                  "Ending Date: ${trainingData['endingdate']}",
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
