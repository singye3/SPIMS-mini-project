import 'dart:async';
import 'package:flutter/material.dart';

import 'package:spims/common/app_font_size.dart';
import 'package:spims/pages/form/form_widget/dependent_widget.dart';
import 'package:spims/pages/home_page.dart';
import '../../../common/app_colors.dart';
import '../../../common/app_responsive.dart';
import '../../profile/profile_service.dart';
import '../fetch_username.dart';
import '../form_builders/form_field_builder.dart';
import '../form_utils/create_training.dart';

class EditTraining extends StatefulWidget {
  final String name;
  final String institution;
  const EditTraining(
      {super.key, required this.name, required this.institution});

  @override
  _EditTrainingState createState() => _EditTrainingState();
}

class _EditTrainingState extends State<EditTraining> {
  final trainingNameController = TextEditingController();
  final institutionNameController = TextEditingController();
  final institutionLocationController = TextEditingController();
  final startingDateContoller = TextEditingController();
  final endingDateContoller = TextEditingController();

  var addTraining = false;
  var showError = false;
  late Timer _timer;

  late final staffID;
  Map<String, dynamic>? training;

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
    getUsername();
    fetchProfileData();
  }

  Future<void> fetchProfileData() async {
    final profileData = await ProfileService.fetchProfileData();

    List<dynamic> trainings = profileData['trainings'];

    int index = findTrainingIndex(trainings, widget.name, widget.institution);

    setState(() {
      training = profileData['trainings'][index];
    });
  }

  int findTrainingIndex(
      List<dynamic> trainings, String name, String institutionName) {
    for (int i = 0; i < trainings.length; i++) {
      Map<String, dynamic> training = trainings[i];
      if (training['name'] == name &&
          training['institution_name'] == institutionName) {
        return i;
      }
    }
    return -1;
  }

  void getUsername() async {
    final storedUsername = await fetchUsername();
    setState(() {
      staffID = storedUsername ?? '';
    });
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
      await createOrUpdateTraining(
          name: name,
          startingDate: startingDate,
          endingDate: endingDate,
          institutionName: institutionName,
          institutionLocation: institutionLocation,
          staffID: staffID);

      navigateToNextScreen();
    } else {
      setState(() {
        showError = true;
        startTimer(); // Start the timer again when showing the error message
      });
    }
  }

  void navigateToNextScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
    );
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

  Widget buildDesktopLayout() {
    trainingNameController.text = training!['name'];
    institutionNameController.text = training!['institution_name'];
    institutionLocationController.text = training!['location'];
    startingDateContoller.text = training!['startingdate'];
    endingDateContoller.text = training!['endingdate'];
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
