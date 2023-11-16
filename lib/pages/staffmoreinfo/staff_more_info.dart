import 'package:flutter/material.dart';
import 'package:spims/common/app_colors.dart';
import 'package:spims/common/app_font_size.dart';
import 'package:spims/pages/staffmoreinfo/widget/display_dependent_widget.dart';
import 'package:spims/pages/staffmoreinfo/widget/display_qualification_widget.dart';
import 'package:spims/pages/staffmoreinfo/widget/display_training_widget.dart';

import 'widget/display_biodata_widget.dart';

class StaffMoreInfo extends StatelessWidget {
  const StaffMoreInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // Number of tabs
      child: Scaffold(
        backgroundColor: AppColor.background,
        appBar: AppBar(
          backgroundColor: AppColor
              .background, // Set the background color to match your app's background
          elevation: 0, // Remove the elevation and shadow
          iconTheme: const IconThemeData(
              color: AppColor.black), // Change the back arrow color to black
          flexibleSpace: TabBar(
            tabs: const [
              Tab(text: 'Biodata'),
              Tab(text: 'Qualification'),
              Tab(text: 'Dependent'),
              Tab(text: 'Training'),
            ],
            labelColor:
                AppColor.black, // Set the color for the selected tab label
            unselectedLabelColor:
                Colors.grey, // Set the color for unselected tab labels
            labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize:
                    FontSize.header_4(context) // Make the selected tab bold
                ),
          ),
        ),
        body: const TabBarView(
          children: [
            DisplayBioDataWidget(),
            DisplayQualificationWidget(),
            DisplayDependentWidget(),
            DisplayTrainingWidget()
          ],
        ),
      ),
    );
  }
}
