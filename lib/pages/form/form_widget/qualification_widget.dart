import 'dart:async';

import 'package:flutter/material.dart';
import 'package:spims/common/options.dart';
import 'package:spims/common/utils.dart';
import 'package:spims/pages/form/form_utils/create_qualification.dart';
import '../../../common/app_colors.dart';
import '../../../common/app_font_size.dart';
import '../../../common/app_responsive.dart';
import '../form_builders/form_field_builder.dart';
import 'training_widget.dart';

class QualificationWidget extends StatefulWidget {
  final String staffID;
  const QualificationWidget({super.key, required this.staffID});

  @override
  _QualificationWidgetState createState() => _QualificationWidgetState();
}

class _QualificationWidgetState extends State<QualificationWidget> {
  final qualificationNameController = TextEditingController();
  final institutionNameController = TextEditingController();
  final institutionLocationController = TextEditingController();

  final graduationDateContoller = TextEditingController();
  final majorFieldController = TextEditingController();
  final gpaGradeController = TextEditingController();
  final honorsAwardController = TextEditingController();

  late Timer _timer;
  var addQualification = false;
  var showError = false;

  @override
  void dispose() {
    qualificationNameController.dispose();
    institutionNameController.dispose();
    institutionLocationController.dispose();
    graduationDateContoller.dispose();
    majorFieldController.dispose();
    gpaGradeController.dispose();
    honorsAwardController.dispose();

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
    qualificationNameController.clear();
    institutionNameController.clear();
    institutionLocationController.clear();
    graduationDateContoller.clear();
    majorFieldController.clear();
    gpaGradeController.clear();
    honorsAwardController.clear();
  }

  void _validateQualificationData() async {
    // Retrieve the entered data from the TextEditingController instances

    String name = qualificationNameController.text;
    String institutionName = institutionNameController.text;
    String institutionLocation = institutionLocationController.text;
    String graduationDate =
        graduationDateContoller.text; // make it to date type
    String majorField = majorFieldController.text;
    String gpaGrade = gpaGradeController.text; // make it to float
    String honorsAward = honorsAwardController.text;

    if (name.isNotEmpty &&
        institutionName.isNotEmpty &&
        institutionLocation.isNotEmpty &&
        graduationDate.isNotEmpty &&
        majorField.isNotEmpty &&
        gpaGrade.isNotEmpty &&
        honorsAward.isNotEmpty) {
      if (!addQualification) {
        await createQualification(
            name: name,
            institutionName: institutionName,
            institutionLocation: institutionLocation,
            majorField: majorField,
            graduationDate: graduationDate,
            gpaGrade: gpaGrade,
            honorsAward: convertToLowerCaseWithUnderscores(honorsAward),
            staffID: widget.staffID);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TrainingWidget(staffID: widget.staffID),
          ),
        );
      } else {
        await createQualification(
          name: name,
          institutionName: institutionName,
          institutionLocation: institutionLocation,
          majorField: majorField,
          graduationDate: graduationDate,
          gpaGrade: gpaGrade,
          honorsAward: convertToLowerCaseWithUnderscores(honorsAward),
          staffID: widget.staffID,
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QualificationWidget(
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
        title: const Text('Staff Qualification'),
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
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: IconButton(
                        tooltip: "Add more qualifications",
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 20,
                        ),
                        onPressed: () {
                          addQualification = true;
                          _validateQualificationData();
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
              const SizedBox(height: 20),
              const Divider(
                height: 1,
                color: Colors.grey,
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        addQualification = false;
                        _validateQualificationData();
                      }); // function thats check whether the data was inserted or not
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(AppColor.primary),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.symmetric(vertical: 16),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
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
        buildFormFieldMobile(context, 'Qualification Name',
            qualificationNameController, FormFieldType.text),
        buildFormFieldMobile(context, 'Graduation Date',
            graduationDateContoller, FormFieldType.date),
        buildFormFieldMobile(
            context, 'Major Field', majorFieldController, FormFieldType.text),
        buildFormFieldMobile(
            context, 'GPA Grade', gpaGradeController, FormFieldType.number),
        buildFormFieldMobile(context, 'Honour Award', honorsAwardController,
            FormFieldType.e_num, honorsAwardOptions),
        const Divider(
          height: 1,
          color: Colors.grey,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "Institution Details",
          style: TextStyle(
              color: AppColor.black,
              fontWeight: FontWeight.bold,
              fontSize: FontSize.header_4(context)),
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
              buildFormFieldDesktop(context, 'Qualification Name',
                  qualificationNameController, FormFieldType.text),
              buildFormFieldDesktop(context, 'Graduation Date',
                  graduationDateContoller, FormFieldType.date),
              buildFormFieldDesktop(context, 'Major Field',
                  majorFieldController, FormFieldType.text),
              buildFormFieldDesktop(context, 'GPA Grade', gpaGradeController,
                  FormFieldType.number),
            ],
          ),
        ),
        const SizedBox(width: 40),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildFormFieldDesktop(
                  context,
                  'Honour Award',
                  honorsAwardController,
                  FormFieldType.e_num,
                  honorsAwardOptions),
              const Divider(
                height: 1,
                color: Colors.grey,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Institution Details",
                style: TextStyle(
                    color: AppColor.black,
                    fontWeight: FontWeight.bold,
                    fontSize: FontSize.header_3(context)),
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
