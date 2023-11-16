import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spims/common/app_colors.dart';
import 'package:spims/common/app_font_size.dart';

import '../../common/app_responsive.dart';

class Training {
  final String name;
  final String institutionName;
  final String startingDate;
  final String endingDate;

  Training({
    required this.name,
    required this.institutionName,
    required this.startingDate,
    required this.endingDate,
  });

  factory Training.fromJson(Map<String, dynamic> json) {
    return Training(
      name: json['name'],
      institutionName: json['institution_name'],
      startingDate: json['startingdate'],
      endingDate: json['endingdate'],
    );
  }
}

class TrainingPage extends StatefulWidget {
  const TrainingPage({super.key});

  @override
  _TrainingPageState createState() => _TrainingPageState();
}

class _TrainingPageState extends State<TrainingPage> {
  late Future<List<Training>> _futureTrainings;
  String _searchText = '';

  @override
  void initState() {
    super.initState();
    _futureTrainings = fetchData();
  }

  Future<List<Training>> fetchData() async {
    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/training/trainings'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);

      final List<Training> trainings =
          jsonData.map((data) => Training.fromJson(data)).toList();

      return trainings;
    } else {
      throw Exception('Failed to fetch data from the API');
    }
  }

  List<Training> filterTrainings(List<Training> trainings) {
    if (_searchText.isEmpty) {
      return trainings;
    } else {
      return trainings.where((training) {
        final name = training.name.toLowerCase();
        final institutionName = training.institutionName.toLowerCase();
        final searchLower = _searchText.toLowerCase();
        return name.contains(searchLower) ||
            institutionName.contains(searchLower);
      }).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        title: const Text(
          'Training Details',
          style: TextStyle(color: AppColor.black),
        ),
        backgroundColor: AppColor.background,
        iconTheme: const IconThemeData(
          color:
              AppColor.grey, // Set the back navigation color to AppColor.grey
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  flex: AppResponsive.isMobile(context) ? 0 : 2,
                  child:
                      Container(), // Empty space to take up 2/3 of the available space
                ),
                Expanded(
                  flex: 1,
                  child: TextField(
                    style: const TextStyle(color: AppColor.black),
                    decoration: InputDecoration(
                      hintText: 'Search',
                      filled: true,
                      fillColor: AppColor.grey,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: AppColor.black,
                      ),
                      contentPadding: const EdgeInsets.all(8.0),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchText = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: FutureBuilder<List<Training>>(
              future: _futureTrainings,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final filteredTrainings = filterTrainings(snapshot.data!);

                  return LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
                      final isMobile = AppResponsive.isMobile(context);

                      return GridView.builder(
                        padding: const EdgeInsets.all(8.0),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: isMobile ? 1 : 3,
                          crossAxisSpacing: 16.0,
                          mainAxisSpacing: 16.0,
                        ),
                        itemCount: filteredTrainings.length,
                        itemBuilder: (context, index) {
                          final training = filteredTrainings[index];

                          return Card(
                            color: AppColor.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(10.0),
                                    ),
                                    child: Image.asset(
                                      "assets/user1.jpg",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          training.name,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                                FontSize.header_4(context),
                                            color: AppColor.black,
                                          ),
                                        ),
                                        const SizedBox(height: 4.0),
                                        Text(
                                          training.institutionName,
                                          style: TextStyle(
                                            fontSize:
                                                FontSize.bodyFontSize(context),
                                            color: Colors.grey,
                                          ),
                                        ),
                                        const SizedBox(height: 4.0),
                                        Text(
                                          'Duration: ${getDuration(training.startingDate, training.endingDate)}',
                                          style: TextStyle(
                                            fontSize:
                                                FontSize.bodyFontSize(context),
                                            color: AppColor.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }

                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  static String getDuration(String? startDate, String? endDate) {
    if (startDate != null && endDate != null) {
      final start = DateTime.tryParse(startDate);
      final end = DateTime.tryParse(endDate);

      if (start != null && end != null) {
        final difference = end.difference(start).inDays;
        return '$difference days';
      }
    }

    return 'Unknown duration';
  }
}
