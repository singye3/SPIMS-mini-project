import 'dart:async';
import 'package:flutter/material.dart';

import 'package:spims/common/app_font_size.dart';
import 'package:spims/pages/form/form_widget/dependent_widget.dart';
import '../../../common/app_colors.dart';
import '../../../common/app_responsive.dart';
import '../form_builders/form_field_builder.dart';
import '../form_utils/create_training.dart';

class TrainingWidget extends StatefulWidget {
  final String staffID;
  const TrainingWidget({super.key, required this.staffID});

  @override
  _TrainingWidgetState createState() => _TrainingWidgetState();
}

class _TrainingWidgetState extends State<TrainingWidget> {
  final trainingNameController = TextEditingController();
  final institutionNameController = TextEditingController();
  final institutionLocationController = TextEditingController();
  final startingDateContoller = TextEditingController();
  final endingDateContoller = TextEditingController();

  var addTraining = false;
  var showError = false;
  late Timer _timer;

  @override
  void dispose() {
    trainingNameController.dispose();
    institutionNameController.dispose();
    institutionLocationController.dispose();
    startingDateContoller.dispose();
    endingDateContoller.dispose();

    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    const duration = Duration(seconds: 5); // Adjust the duration as needed
    _timer = Timer.periodic(duration, (Timer timer) {
      setState(() {
        showError = false;
      });
      _timer.cancel(); // Cancel the timer after hiding the error message
    });
  }

  void _clearFields() {
    trainingNameController.clear();
    institutionNameController.clear();
    institutionLocationController.clear();
    startingDateContoller.clear();
    endingDateContoller.clear();
  }

  void _validateFields() async {
    // Retrieve the entered data from the TextEditingController instances
    String name = trainingNameController.text;
    String startingDate = startingDateContoller.text;
    String endingDate = endingDateContoller.text;
    String institutionName = institutionNameController.text;
    String institutionLocation = institutionLocationController.text;

    if (name.isNotEmpty &&
        startingDate.isNotEmpty &&
        endingDate.isNotEmpty &&
        institutionName.isNotEmpty &&
        institutionLocation.isNotEmpty) {
      if (!addTraining) {
        await createOrUpdateTraining(
            name: name,
            startingDate: startingDate,
            endingDate: endingDate,
            institutionName: institutionName,
            institutionLocation: institutionLocation,
            staffID: widget.staffID);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DependentWidget(staffID: widget.staffID),
          ),
        );
      } else {
        await createOrUpdateTraining(
            name: name,
            startingDate: startingDate,
            endingDate: endingDate,
            institutionName: institutionName,
            institutionLocation: institutionLocation,
            staffID: widget.staffID);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TrainingWidget(
              staffID: widget.staffID,
            ),
          ),
        );
      }
    } else {
      setState(() {
        showError = true;
        startTimer(); // Start the timer again when showing the error message
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Staff Training'),
        elevation: 0,
        iconTheme: const IconThemeData(
          color: AppColor
              .grey, // Set the color of the back navigation button to grey
        ),
      ),
      backgroundColor: AppColor.white,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: AppResponsive.isMobile(context) ? 30 : 50),
          padding: EdgeInsets.all(AppResponsive.isMobile(context) ? 30 : 40),
          color: AppColor.white,
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(1000),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColor.primary,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: IconButton(
                        tooltip: "Add more dependents",
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 20,
                        ),
                        onPressed: () {
                          addTraining = true;
                          _validateFields();
                        },
                      ),
                    ),
                  ),
                  if (showError)
                    AnimatedOpacity(
                      opacity: showError ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 500),
                      child: showError
                          ? Text(
                              "Enter all information",
                              style: TextStyle(
                                  fontSize: FontSize.header_3(context),
                                  color: AppColor.error),
                            )
                          : const SizedBox
                              .shrink(), // Return an empty widget when there is no error
                    ),
                  IconButton(
                    tooltip: "Discard changes",
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _clearFields();
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                height: 1,
                color: Colors.grey,
              ),
              const SizedBox(
                height: 20,
              ),
              if (AppResponsive.isMobile(context))
                buildMobileLayout()
              else
                buildDesktopLayout(),
              const SizedBox(height: 20.0),
              const Divider(
                height: 1,
                color: AppColor.grey,
              ),
              const SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      addTraining = false;
                      _validateFields(); // function thats check whether the data was inserted or not
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(AppColor.primary),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.symmetric(vertical: 16),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.0),
                        ),
                      ),
                    ),
                    child: const Text(
                      'Next',
                      style: TextStyle(color: AppColor.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildFormFieldMobile(context, 'Trainning Name', trainingNameController,
            FormFieldType.text),
        buildFormFieldMobile(context, 'Starting Date', startingDateContoller,
            FormFieldType.date),
        buildFormFieldMobile(
            context, 'Ending Date', endingDateContoller, FormFieldType.date),
        const SizedBox(
          height: 10,
        ),
        Text(
          "Institution Details",
          style: TextStyle(
              color: AppColor.black, fontSize: FontSize.header_3(context)),
        ),
        const SizedBox(
          height: 10,
        ),
        const Divider(
          height: 1,
          color: Colors.grey,
        ),
        const SizedBox(
          height: 10,
        ),
        buildFormFieldMobile(context, 'Institution Name',
            institutionNameController, FormFieldType.text),
        buildFormFieldMobile(context, 'Institution Location',
            institutionLocationController, FormFieldType.text),
      ],
    );
  }

  Widget buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildFormFieldDesktop(context, 'Trainning Name',
                  trainingNameController, FormFieldType.text),
              buildFormFieldDesktop(context, 'Starting Date',
                  startingDateContoller, FormFieldType.date),
              buildFormFieldDesktop(context, 'Ending Date', endingDateContoller,
                  FormFieldType.date),
            ],
          ),
        ),
        const SizedBox(width: 40),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Institution Details",
                  style: TextStyle(
                      color: AppColor.black,
                      fontSize: FontSize.header_3(context)),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                height: 1,
                color: Colors.grey,
              ),
              const SizedBox(
                height: 10,
              ),
              buildFormFieldDesktop(context, 'Institution Name',
                  institutionNameController, FormFieldType.text),
              buildFormFieldDesktop(context, 'Institution Location',
                  institutionLocationController, FormFieldType.text),
            ],
          ),
        ),
      ],
    );
  }
}
