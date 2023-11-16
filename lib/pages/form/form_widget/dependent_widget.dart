import 'dart:async';

import 'package:flutter/material.dart';
import 'package:spims/common/options.dart';
import 'package:spims/pages/home_page.dart';
import '../../../common/app_colors.dart';
import '../../../common/app_font_size.dart';
import '../../../common/app_responsive.dart';
import '../../../common/utils.dart';
import '../form_builders/form_field_builder.dart';
import '../form_utils/create_dependent.dart';

class DependentWidget extends StatefulWidget {
  final String staffID;
  const DependentWidget({super.key, required this.staffID});

  @override
  _DependentWidgetState createState() => _DependentWidgetState();
}

class _DependentWidgetState extends State<DependentWidget> {
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

  var addDependent = false;
  var showError = false;
  late Timer _timer;

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
      if (!addDependent) {
        await createDependent(
            staffID: widget.staffID,
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
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      } else {
        await createDependent(
            staffID: widget.staffID,
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
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DependentWidget(
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
      backgroundColor: AppColor.white,
      appBar: AppBar(
        title: const Text('Dependents Data'),
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
                          addDependent = true;
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
              if (AppResponsive.isMobile(context))
                buildMobileLayout()
              else
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
                      addDependent = false;
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

  Widget buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildFormFieldMobile(
            context, 'CID Number', cidController, FormFieldType.text),
        buildFormFieldMobile(
            context, "Name", nameController, FormFieldType.text),
        buildFormFieldMobile(context, 'Gender', genderController,
            FormFieldType.e_num, genderOptions),
        buildFormFieldMobile(
            context, 'Date of Birth', dobController, FormFieldType.date),
        buildFormFieldMobile(context, 'Blood Group', bloodGroupController,
            FormFieldType.e_num, bloodGroupOptions),
        buildFormFieldMobile(context, 'Phone Number', phoneNumberController,
            FormFieldType.number),
        buildFormFieldMobile(context, 'Relation Type', dependentTypeController,
            FormFieldType.e_num, relationTypeOptions),
        const SizedBox(
          height: 10,
        ),
        const Divider(
          thickness: 1.0,
          color: Colors.grey,
        ),
        const SizedBox(
          height: 10,
        ),
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
          height: 15,
        ),
        buildFormFieldMobile(
            context, "Village", villagePermController, FormFieldType.text),
        buildFormFieldMobile(
            context, 'Gewog', gewogPermController, FormFieldType.text),
        buildFormFieldMobile(context, 'Dzongkhag', dzongkhagPermController,
            FormFieldType.e_num, dzongkhagOptions),
        const SizedBox(
          height: 10,
        ),
        const Divider(
          thickness: 1.0,
          color: Colors.grey,
        ),
        const SizedBox(
          height: 10,
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
          height: 15,
        ),
        buildFormFieldMobile(
            context, "Village", villageTempController, FormFieldType.text),
        buildFormFieldMobile(
            context, 'Gewog', gewogTempController, FormFieldType.text),
        buildFormFieldMobile(context, 'Dzongkhag', dzongkhagTempController,
            FormFieldType.e_num, dzongkhagOptions),
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
