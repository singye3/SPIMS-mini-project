import 'package:flutter/material.dart';
import './widget/staff_info_card_widget.dart';

import '../../common/app_colors.dart';
import '../../common/app_responsive.dart';

import '../../common/calender_widget.dart';
import 'widget/header_widget.dart';
import 'widget/notification_card_widget.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColor.bgColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          /// Header Part
          const HeaderWidget(),
          Expanded(
            child: SingleChildScrollView(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: Column(
                        children: [
                          const NotificationCardWidget(),
                          const SizedBox(
                            height: 20,
                          ),
                          SearchSection(),
                          if (AppResponsive.isMobile(context)) ...{
                            const CalendarWidget(),
                            const SizedBox(
                              height: 20,
                            ),
                          },
                          const StaffInfoCardWidget(),
                        ],
                      ),
                    ),
                  ),
                  if (!AppResponsive.isMobile(context))
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: const Column(
                          children: [
                            CalendarWidget(),
                            SizedBox(
                              height: 20,
                            ),
                            // ProfileCardWidget(),
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

Widget SearchSection() {
  TextEditingController searchController = TextEditingController();

  void handleSubmitted(String value) {
    // Perform the desired action when the user presses enter or submits the search
    print('Search submitted: $value');
    // Replace the print statement with your desired action
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
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                prefixIcon: const Icon(Icons.search),
              ),
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
