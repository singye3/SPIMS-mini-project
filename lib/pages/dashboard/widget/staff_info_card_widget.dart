import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:spims/common/app_responsive.dart';
import 'package:spims/common/current_user.dart';
import 'package:spims/common/utils.dart';
import 'package:spims/pages/dashboard/widget/desktop_add.dart';
import 'package:spims/pages/dashboard/widget/staff_details_widget.dart';
import 'package:spims/pages/staffmoreinfo/staff_more_info.dart';
import 'dart:convert';
import 'dart:async';

import '../../../common/app_colors.dart';
import '../../../common/app_font_size.dart';
import '../../profile/profile_service.dart';
import '../../profile/profilewidget.dart';
import 'desktop_staff_detail.dart';
import 'enter_data_widget.dart';

class StaffInfoCardWidget extends StatefulWidget {
  final Function(Staff) onItemClicked; // Define the callback function type

  const StaffInfoCardWidget({super.key, required this.onItemClicked});

  @override
  _StaffInfoCardWidgetState createState() => _StaffInfoCardWidgetState();
}

class _StaffInfoCardWidgetState extends State<StaffInfoCardWidget> {
  List<Staff> allStaffs = []; // List to store all staff members' data
  List<Staff> displayedStaffs =
      []; // List to store currently displayed staff members' data
  Timer? timer; // Timer to periodically update the displayed staff members
  int currentIndex = 0; // Current index in the allStaffs list
  bool isLoading = true; // Loading state flag
  bool isError = false;
  bool isStaffExists = false;
  String? staffID; // Error state flag

  @override
  void initState() {
    super.initState();
    loadStaffsData(); // Start loading the staffs data
    startTimer();
    isStaffExist(); // Start the timer to periodically update the displayed staff members
  }

  Future<void> isStaffExist() async {
    try {
      staffID = await ProfileService.loadLoginInfo();
      final response = await http
          .get(Uri.parse('http://localhost:8000/staff/staff/check/$staffID'));
      if (response.statusCode == 200) {
        isStaffExists = response.body.toLowerCase() == 'true';
      }
    } catch (e) {
      print('An error occurred: $e');
    }
  }

  @override
  void dispose() {
    timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  Future<void> loadStaffsData() async {
    setState(() {
      isLoading = true; // Set loading state to true
      isError = false; // Reset error state
    });

    const apiUrl = 'http://127.0.0.1:8000/staff/staff/basic';
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final staffData = json.decode(response.body) as List<dynamic>;
        final List<Staff> staffList =
            staffData.map((data) => Staff.fromJson(data)).toList();

        setState(() {
          allStaffs =
              staffList; // Populate the allStaffs list with the fetched data
          displayedStaffs =
              getNextSetOfStaffs(); // Initialize displayedStaffs with the first set of staff members
          isLoading = false; // Set loading state to false
        });
      } else {
        setState(() {
          isError = true; // Set error state to true if the request failed
          isLoading = false; // Set loading state to false
        });
      }
    } catch (e) {
      setState(() {
        isError = true; // Set error state to true if an exception occurred
        isLoading = false; // Set loading state to false
      });
    }
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 10), (Timer t) {
      setState(() {
        displayedStaffs =
            getNextSetOfStaffs(); // Update the displayed staff members every 10 seconds
      });
    });
  }

  List<Staff> getNextSetOfStaffs() {
    final int end = currentIndex + 6;
    final List<Staff> nextStaffs = allStaffs.sublist(
        currentIndex, end > allStaffs.length ? allStaffs.length : end);
    currentIndex = end >= allStaffs.length ? 0 : end;
    return nextStaffs;
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (isError) {
      return const Center(
        child: Text(
          'Failed to load staff data',
          style: TextStyle(color: Colors.red),
        ),
      );
    } else if (allStaffs.isEmpty) {
      return const Center(
        child: Text('No staff data available'),
      );
    } else {
      return Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          if (AppResponsive.isDesktop(context))
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Staff Infomation",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColor.black,
                    fontSize: 22,
                  ),
                ),
                if (UserPreferences.userRole == 'admin')
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(AppColor.primary),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EnterDataWidget()),
                      );
                    },
                    child: const Text(
                      'Add Staff',
                      style: TextStyle(
                        color: AppColor.white,
                      ),
                    ),
                  ),
                if (UserPreferences.userRole == 'admin')
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(AppColor.primary),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const StaffMoreInfo()),
                      );
                    },
                    child: const Text(
                      'View All',
                      style: TextStyle(
                        color: AppColor.white,
                      ),
                    ),
                  ),
                if (UserPreferences.userRole == 'staff' && !isStaffExists)
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(AppColor.primary),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EnterDataWidget(
                                  staffID: staffID,
                                )),
                      );
                    },
                    child: const Text(
                      'Add Your Details',
                      style: TextStyle(
                        color: AppColor.white,
                      ),
                    ),
                  ),
              ],
            ),
          if (AppResponsive.isMobile(context))
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (UserPreferences.userRole == 'admin')
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(AppColor.primary),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EnterDataWidget()),
                      );
                    },
                    child: const Text(
                      'Add Staff',
                      style: TextStyle(
                        color: AppColor.white,
                      ),
                    ),
                  ),
                const SizedBox(
                  height: 10,
                ),
                if (UserPreferences.userRole == 'admin')
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(AppColor.primary),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const StaffMoreInfo()),
                      );
                    },
                    child: const Text(
                      'View All',
                      style: TextStyle(
                        color: AppColor.white,
                      ),
                    ),
                  ),
                const SizedBox(
                  height: 10,
                ),
                if (UserPreferences.userRole == 'admin')
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(AppColor.primary),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DesktopAdd()),
                      );
                    },
                    child: const Text(
                      'Add User',
                      style: TextStyle(
                        color: AppColor.white,
                      ),
                    ),
                  ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Staff Infomation",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColor.black,
                    fontSize: FontSize.header_3(context),
                  ),
                ),
              ],
            ),
          const SizedBox(
            height: 15,
          ),
          const Divider(),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: AppResponsive.isDesktop(context) ? 3 : 1,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.3,
            ),
            itemCount: displayedStaffs.length,
            itemBuilder: (ctx, index) {
              final staff = displayedStaffs[index];
              return GestureDetector(
                onTap: () {
                  if (UserPreferences.userRole != 'admin' &&
                      AppResponsive.isDesktop(context)) {
                    widget.onItemClicked(staff);
                  } else if (UserPreferences.userRole != 'admin' &&
                      AppResponsive.isMobile(context)) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DesktopStaffDetail(
                          staffId: staff.staffid,
                        ),
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StaffDetailsWidget(
                          staffID: staff.staffid,
                        ),
                      ),
                    );
                  }
                },
                child: Card(
                  color: AppColor.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        0), // Set the border radius to 0 to remove the rounded border
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(1000),
                        child: Image.asset(
                          "assets/user1.jpg",
                          height: 60,
                          width: 60,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        displayedStaffs[index].name,
                        style: TextStyle(
                          fontSize: FontSize.header_4(context),
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        displayedStaffs[index].email,
                        style: TextStyle(
                          fontSize: FontSize.bodyFontSize(context),
                          color: AppColor.black,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        displayedStaffs[index].phonenumber,
                        style: TextStyle(
                          fontSize: FontSize.bodyFontSize(context),
                          color: AppColor.black,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        removeUnderscores(displayedStaffs[index].staffstatus),
                        style: TextStyle(
                          fontSize: FontSize.bodyFontSize(context),
                          color: AppColor.accent,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Showing ${displayedStaffs.length} out of ${allStaffs.length} Results",
                  style: TextStyle(
                    fontSize: FontSize.bodyFontSize(context),
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }
  }
}

class Staff {
  final String staffid;
  final String name;
  final String email;
  final String phonenumber;
  final String staffstatus;

  Staff(
      {required this.staffid,
      required this.name,
      required this.email,
      required this.phonenumber,
      required this.staffstatus});

  factory Staff.fromJson(Map<String, dynamic> json) {
    return Staff(
      staffid: json['staffid'],
      name: json['name'],
      email: json['email'],
      phonenumber: json['phonenumber'],
      staffstatus: json['staffstatus'],
    );
  }
}
