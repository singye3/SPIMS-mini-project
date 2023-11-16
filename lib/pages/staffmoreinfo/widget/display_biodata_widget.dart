import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:spims/common/app_responsive.dart';
import 'dart:convert';

import '../../../common/app_colors.dart';

class DisplayBioDataWidget extends StatefulWidget {
  const DisplayBioDataWidget({Key? key}) : super(key: key);

  @override
  _DisplayBioDataWidgetState createState() => _DisplayBioDataWidgetState();
}

class _DisplayBioDataWidgetState extends State<DisplayBioDataWidget> {
  List<dynamic> staffData = [];
  bool isLoading = true;
  String errorMessage = '';
  ScrollController scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();

  List<dynamic> filteredStaffData = [];
  String filteredData = '';

  Future<void> fetchData() async {
    const apiUrl = 'http://127.0.0.1:8000/staff/staff';
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body);
        setState(() {
          staffData = decodedData;
          filteredStaffData =
              decodedData; // Initialize the filteredStaffData with the fetched data
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

      filteredStaffData = staffData.where((staff) {
        final String searchData = staff.toString().toLowerCase();
        return searchData.contains(searchInput.toLowerCase());
      }).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  bool sortAscending = true;
  int sortColumnIndex = 0;

  void sortColumn(int columnIndex, bool ascending) {
    setState(() {
      sortColumnIndex = columnIndex;
      sortAscending = ascending;

      // Sort the staffData list based on the selected column
      staffData.sort((a, b) {
        final aValue = a[getColumnKey(columnIndex)];
        final bValue = b[getColumnKey(columnIndex)];

        // Compare the values based on the data type of the column
        if (aValue is String && bValue is String) {
          return ascending
              ? aValue.compareTo(bValue)
              : bValue.compareTo(aValue);
        } else if (aValue is int && bValue is int) {
          return ascending
              ? aValue.compareTo(bValue)
              : bValue.compareTo(aValue);
        } else if (aValue is double && bValue is double) {
          return ascending
              ? aValue.compareTo(bValue)
              : bValue.compareTo(aValue);
        } else if (aValue is DateTime && bValue is DateTime) {
          return ascending
              ? aValue.compareTo(bValue)
              : bValue.compareTo(aValue);
        } else {
          // If the data types are not comparable, consider them equal
          return 0;
        }
      });
    });
  }

  String getColumnKey(int columnIndex) {
    switch (columnIndex) {
      case 0:
        return 'staffid';
      case 1:
        return 'cid';
      case 2:
        return 'name';
      case 3:
        return 'gender';
      case 4:
        return 'nationality';
      case 5:
        return 'phonenumber';
      case 6:
        return 'email';
      case 7:
        return 'bloodgroup';
      case 8:
        return 'dateofbirth';
      case 9:
        return 'salary';
      case 10:
        return 'joiningdate';
      case 11:
        return 'staffstatus';
      case 12:
        return 'positionlevel';
      case 13:
        return 'positiontitle';
      case 14:
        return 'stafftype';
      default:
        throw ArgumentError('Invalid column index');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Container(
                  color: AppColor.cardprimary,
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
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
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    controller: scrollController,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: DataTableTheme(
                        data: const DataTableThemeData(
                          headingTextStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          dataTextStyle: TextStyle(
                            color: Colors.black,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          // Set the divider color to black
                        ),
                        child: DataTable(
                          dataRowMaxHeight: 50.0,
                          headingRowColor: MaterialStateColor.resolveWith(
                            (states) => AppColor
                                .cardprimary, // Set the desired color for the header row
                          ),
                          columns: [
                            DataColumn(
                              label: const Text('Staff ID'),
                              onSort: (columnIndex, ascending) {
                                sortColumn(columnIndex, ascending);
                              },
                            ),
                            DataColumn(
                              label: const Text('CID'),
                              onSort: (columnIndex, ascending) {
                                sortColumn(columnIndex, ascending);
                              },
                            ),
                            DataColumn(
                              label: const Text('Name'),
                              onSort: (columnIndex, ascending) {
                                sortColumn(columnIndex, ascending);
                              },
                            ),
                            DataColumn(
                              label: const Text('Gender'),
                              onSort: (columnIndex, ascending) {
                                sortColumn(columnIndex, ascending);
                              },
                            ),
                            DataColumn(
                              label: const Text('Nationality'),
                              onSort: (columnIndex, ascending) {
                                sortColumn(columnIndex, ascending);
                              },
                            ),
                            DataColumn(
                              label: const Text('Phone Number'),
                              onSort: (columnIndex, ascending) {
                                sortColumn(columnIndex, ascending);
                              },
                            ),
                            DataColumn(
                              label: const Text('Email'),
                              onSort: (columnIndex, ascending) {
                                sortColumn(columnIndex, ascending);
                              },
                            ),
                            DataColumn(
                              label: const Text('Blood Group'),
                              onSort: (columnIndex, ascending) {
                                sortColumn(columnIndex, ascending);
                              },
                            ),
                            DataColumn(
                              label: const Text('Date of Birth'),
                              onSort: (columnIndex, ascending) {
                                sortColumn(columnIndex, ascending);
                              },
                            ),
                            DataColumn(
                              label: const Text('Salary'),
                              onSort: (columnIndex, ascending) {
                                sortColumn(columnIndex, ascending);
                              },
                            ),
                            DataColumn(
                              label: const Text('Joining Date'),
                              onSort: (columnIndex, ascending) {
                                sortColumn(columnIndex, ascending);
                              },
                            ),
                            DataColumn(
                              label: const Text('Staff Status'),
                              onSort: (columnIndex, ascending) {
                                sortColumn(columnIndex, ascending);
                              },
                            ),
                            DataColumn(
                              label: const Text('Position Level'),
                              onSort: (columnIndex, ascending) {
                                sortColumn(columnIndex, ascending);
                                sortColumn(columnIndex, ascending);
                              },
                            ),
                            DataColumn(
                              label: const Text('Position Title'),
                              onSort: (columnIndex, ascending) {
                                sortColumn(columnIndex, ascending);
                              },
                            ),
                            DataColumn(
                              label: const Text('Staff Type'),
                              onSort: (columnIndex, ascending) {
                                sortColumn(columnIndex, ascending);
                              },
                            ),
                          ],
                          rows: filteredStaffData.map((staff) {
                            return DataRow(cells: [
                              DataCell(
                                Text(
                                  staff['staffid'].toString(),
                                ),
                              ),
                              DataCell(
                                Text(
                                  staff['cid'].toString(),
                                ),
                              ),
                              DataCell(
                                Text(
                                  staff['name'],
                                ),
                              ),
                              DataCell(
                                Text(
                                  staff['gender'],
                                ),
                              ),
                              DataCell(
                                Text(
                                  staff['nationality'],
                                ),
                              ),
                              DataCell(
                                Text(
                                  staff['phonenumber'].toString(),
                                ),
                              ),
                              DataCell(
                                Text(
                                  staff['email'],
                                ),
                              ),
                              DataCell(
                                Text(
                                  staff['bloodgroup'],
                                ),
                              ),
                              DataCell(
                                Text(
                                  staff['dateofbirth'],
                                ),
                              ),
                              DataCell(
                                Text(
                                  staff['salary'].toString(),
                                ),
                              ),
                              DataCell(
                                Text(
                                  staff['joiningdate'],
                                ),
                              ),
                              DataCell(
                                Text(
                                  staff['staffstatus'],
                                ),
                              ),
                              DataCell(
                                Text(
                                  staff['positionlevel'].toString(),
                                ),
                              ),
                              DataCell(
                                Text(
                                  staff['positiontitle'],
                                ),
                              ),
                              DataCell(
                                Text(
                                  staff['stafftype'],
                                ),
                              ),
                            ]);
                          }).toList(), // Add a horizontal line
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
