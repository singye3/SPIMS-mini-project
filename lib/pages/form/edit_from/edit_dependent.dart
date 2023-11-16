import 'dart:async';

import 'package:flutter/material.dart';
import 'package:spims/common/options.dart';
import 'package:spims/pages/home_page.dart';
import '../../../common/app_colors.dart';
import '../../../common/app_font_size.dart';
import '../../../common/app_responsive.dart';
import '../../../common/utils.dart';
import '../../profile/profile_service.dart';
import '../fetch_username.dart';
import '../form_builders/form_field_builder.dart';
import '../form_utils/create_dependent.dart';

class EditDependent extends StatefulWidget {
  final String name;
  final String cid;
  const EditDependent({super.key, required this.name, required this.cid});

  @override
  _EditDependentState createState() => _EditDependentState();
}

class _EditDependentState extends State<EditDependent> {
  final nameController = TextEditingController();
  final cidController = TextEditingController();
  final genderController = TextEditingController();
  final dobController = TextEditingController();

  final bloodGroupController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final dependentTypeController = TextEditingController();

  final villagePermController = TextEditingController();
  final gewogPermController = TextEditingController();
  final dzongkhagPermController = TextEditingController();

  final villageTempController = TextEditingController();
  final gewogTempController = TextEditingController();
  final dzongkhagTempController = TextEditingController();

  var showError = false;
  late Timer _timer;
  late final staffID;
  Map<String, dynamic>? dependent;

  @override
  void dispose() {
    cidController.dispose();
    nameController.dispose();
    genderController.dispose();
    dobController.dispose();
    bloodGroupController.dispose();
    phoneNumberController.dispose();
    dependentTypeController.dispose();
    villagePermController.dispose();
    villageTempController.dispose();
    gewogPermController.dispose();
    gewogTempController.dispose();
    dzongkhagPermController.dispose();
    dzongkhagTempController.dispose();

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

    List<dynamic> dependents = profileData['dependents'];

    int index = findDependentIndex(dependents, widget.cid, widget.name);

    setState(() {
      dependent = profileData['dependents'][index];
    });
  }

  int findDependentIndex(List<dynamic> dependents, String name, String cid) {
    for (int i = 0; i < dependents.length; i++) {
      Map<String, dynamic> dependent = dependents[i];
      print(dependent);
      if (dependent['name'] == name && dependent['cid'] == cid) {
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
    cidController.clear();
    nameController.clear();
    genderController.clear();
    dobController.clear();
    bloodGroupController.clear();
    phoneNumberController.clear();
    dependentTypeController.clear();
    villagePermController.clear();
    villageTempController.clear();
    gewogPermController.clear();
    gewogTempController.clear();
    dzongkhagPermController.clear();
    dzongkhagTempController.clear();
  }

  void _validateFields() async {
    // Retrieve the entered data from the TextEditingController instances
    String cid = cidController.text;
    String name = nameController.text;
    String gender = genderController.text;
    String dob = dobController.text;
    String bloodGroup = bloodGroupController.text;
    String phoneNumber = phoneNumberController.text;
    String villagePerm = villagePermController.text;
    String gewogPerm = gewogPermController.text;
    String dzongkhagPerm = dzongkhagPermController.text;
    String villageTemp = villageTempController.text;
    String gewogTemp = gewogTempController.text;
    String dzongkhagTemp = dzongkhagTempController.text;
    String dependentType = dependentTypeController.text;

    if (cid.isNotEmpty &&
        name.isNotEmpty &&
        gender.isNotEmpty &&
        dob.isNotEmpty &&
        bloodGroup.isNotEmpty &&
        phoneNumber.isNotEmpty &&
        villagePerm.isNotEmpty &&
        gewogPerm.isNotEmpty &&
        dzongkhagPerm.isNotEmpty &&
        villageTemp.isNotEmpty &&
        gewogTemp.isNotEmpty &&
        dzongkhagTemp.isNotEmpty &&
        dependentType.isNotEmpty) {
      await createDependent(
          staffID: staffID,
          cid: cid,
          name: name,
          gender: convertToLowerCaseWithUnderscores(gender),
          dateOfBirth: dob,
          bloodGroup: convertToLowerCaseWithUnderscores(bloodGroup),
          phoneNumber: phoneNumber,
          villagePerm: villagePerm,
          gewogPerm: gewogPerm,
          dzongkhagPerm: dzongkhagPerm,
          villageTemp: villageTemp,
          gewogTemp: gewogTemp,
          dzongkhagTemp: dzongkhagTemp,
          relationType: convertToLowerCaseWithUnderscores(dependentType));
      navigateToNextScreen();
    } else {
      setState(() {
        showError = true;
        startTimer(); // Start the timer again when showing the error message
      });
    }
  }

  void navigateToNextScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        title: const Text('Edit dependent Data'),
        elevation: 0,
        iconTheme: const IconThemeData(
          color: AppColor
              .grey, // Set the color of the back navigation button to grey
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: AppResponsive.isMobile(context) ? 30 : 50,
          ),
          padding: EdgeInsets.all(AppResponsive.isMobile(context) ? 30 : 40),
          color: AppColor.white,
          child: Column(
            children: [
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
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
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                height: 1,
                color: AppColor.grey,
              ),
              const SizedBox(
                height: 16,
              ),
              buildDesktopLayout(),
              const SizedBox(height: 16.0),
              const Divider(
                height: 1,
                color: AppColor.grey,
              ),
              const SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
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
                      'Finish',
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
    cidController.text = dependent!['cid'];
    nameController.text = dependent!['name'];
    genderController.text = dependent!['gender'];
    bloodGroupController.text = dependent!['bloodgroup'];
    phoneNumberController.text = dependent!['phonenumber'];
    dependentTypeController.text = dependent!['type'];
    dobController.text = dependent!['dateofbirth'];
    villagePermController.text = dependent!['villagename'];
    villageTempController.text = dependent!['villagename'];
    gewogPermController.text = dependent!['gewog'];
    gewogTempController.text = dependent!['gewog'];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildFormFieldDesktop(
                  context, 'CID Number', cidController, FormFieldType.text),
              buildFormFieldDesktop(
                  context, 'Name', nameController, FormFieldType.text),
              buildFormFieldDesktop(context, 'Gender', genderController,
                  FormFieldType.e_num, genderOptions),
              buildFormFieldDesktop(
                  context, 'Date of Birth', dobController, FormFieldType.date),
              buildFormFieldDesktop(context, 'Blood Group',
                  bloodGroupController, FormFieldType.e_num, bloodGroupOptions),
              buildFormFieldDesktop(context, 'Phone Number',
                  phoneNumberController, FormFieldType.number),
              buildFormFieldDesktop(
                  context,
                  'Relation Type',
                  dependentTypeController,
                  FormFieldType.e_num,
                  relationTypeOptions),
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
                  'Permanent Address',
                  style: TextStyle(
                      color: AppColor.black,
                      fontWeight: FontWeight.bold,
                      fontSize: FontSize.header_4(context)),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              buildFormFieldDesktop(context, "Village", villagePermController,
                  FormFieldType.text),
              buildFormFieldDesktop(
                  context, 'Gewog', gewogPermController, FormFieldType.text),
              buildFormFieldDesktop(
                  context,
                  'Dzongkhag',
                  dzongkhagPermController,
                  FormFieldType.e_num,
                  dzongkhagOptions),
              const Divider(
                thickness: 1.0,
                color: Colors.grey,
              ),
              Center(
                child: Text(
                  'Temporary Address',
                  style: TextStyle(
                      color: AppColor.black,
                      fontWeight: FontWeight.bold,
                      fontSize: FontSize.header_4(context)),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              buildFormFieldDesktop(context, "Village", villageTempController,
                  FormFieldType.text),
              buildFormFieldDesktop(
                  context, 'Gewog', gewogTempController, FormFieldType.text),
              buildFormFieldDesktop(
                  context,
                  'Dzongkhag',
                  dzongkhagTempController,
                  FormFieldType.e_num,
                  dzongkhagOptions),
            ],
          ),
        ),
      ],
    );
  }
}
