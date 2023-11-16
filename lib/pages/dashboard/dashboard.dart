import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:spims/common/current_user.dart';
import 'dart:convert';

import '../../common/app_colors.dart';
import '../../common/app_responsive.dart';
import '../../common/calender_widget.dart';
import 'widget/add_staff_widget.dart';
import 'widget/header_widget.dart';
import 'widget/notification_card_widget.dart';
import 'widget/staff_info_card_widget.dart';
import 'widget/staffbasicdisplay.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool _isStaffBasicDisplayVisible = false;
  late String _selectedStaffId; // Variable to store the staff ID

  void showStaffBasicDisplay(String staffId) {
    setState(() {
      _isStaffBasicDisplayVisible = true;
      _selectedStaffId = staffId; // Update the selected staff ID
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColor.background,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          const HeaderWidget(),
          Expanded(
            child: SingleChildScrollView(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        const NotificationCardWidget(),
                        const SizedBox(
                          height: 20,
                        ),
                        // searchSection(),
                        if (AppResponsive.isMobile(context)) ...{
                          const CalendarWidget(),
                          const SizedBox(
                            height: 20,
                          ),
                        },
                        StaffInfoCardWidget(
                          onItemClicked: (staffMember) {
                            showStaffBasicDisplay(
                                staffMember.staffid); // Pass the staff ID
                          },
                        ),
                      ],
                    ),
                  ),
                  if (!AppResponsive.isMobile(context))
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            const CalendarWidget(),
                            const SizedBox(
                              height: 20,
                            ),
                            if (UserPreferences.userRole == 'admin')
                              const AddStaffWidget(),
                            if (_isStaffBasicDisplayVisible &&
                                UserPreferences.userRole != 'admin')
                              StaffBasicDisplay(
                                  staffId:
                                      _selectedStaffId), // Pass the staff ID
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget searchSection() {
  TextEditingController searchController = TextEditingController();

  Future<void> handleSubmitted(String value) async {
    final searchValue =
        searchController.text; // Retrieve text from the controller
    final apiUrl = 'http://127.0.0.1:8000/staff/staff/$searchValue/basic';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final staffData = json.decode(response.body);
        print('Staff Data: $staffData');
        // Now you can process the staff data or update your UI with the results.
        // You can replace the print statement with your desired action.
      } else if (response.statusCode == 404) {
        print('Staff not found');
      } else {
        print('Failed to load staff data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  return Column(
    children: [
      Row(
        children: [
          Expanded(
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: AppColor.white, // Adjust as needed
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 16,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
              ),
              style: const TextStyle(color: Colors.black),
              onSubmitted: handleSubmitted,
            ),
          ),
        ],
      ),
      const SizedBox(
        height: 10,
      ),
    ],
  );
}
