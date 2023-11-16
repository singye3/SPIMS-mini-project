import 'package:flutter/material.dart';
import 'package:spims/common/app_colors.dart';
import 'package:spims/pages/form/form_widget/staff_biodata_widget.dart';

class EnterDataWidget extends StatefulWidget {
  final String? staffID;
  const EnterDataWidget({super.key, this.staffID});

  @override
  _EnterDataWidgetState createState() => _EnterDataWidgetState();
}

class _EnterDataWidgetState extends State<EnterDataWidget>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Staff Form'),
        backgroundColor: AppColor.white,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: AppColor
              .grey, // Set the color of the back navigation button to grey
        ),
      ),
      backgroundColor: AppColor.white,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: AppColor.blackWithOpacity,
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
                StaffBioDataWidget(
                  username: widget.staffID,
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
