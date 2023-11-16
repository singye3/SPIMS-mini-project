import 'package:flutter/material.dart';
import 'package:spims/common/app_font_size.dart';
import 'package:spims/common/image_widget.dart';
import 'package:spims/common/utils.dart';
import 'package:spims/pages/form/form_utils/create_staff.dart';
import 'package:spims/pages/form/form_widget/qualification_widget.dart';
import '../../../common/app_colors.dart';
import '../../../common/app_responsive.dart';
import '../form_builders/form_field_builder.dart';
import '../../../common/options.dart';

class StaffBioDataWidget extends StatefulWidget {
  final String? username;
  const StaffBioDataWidget({super.key, this.username});

  @override
  _StaffBioDataWidgetState createState() => _StaffBioDataWidgetState();
}

class _StaffBioDataWidgetState extends State<StaffBioDataWidget> {
  final staffIDController = TextEditingController();
  final cidController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final genderController = TextEditingController();
  final dobController = TextEditingController();
  final bloodGroupController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final villagePermController = TextEditingController();
  final gewogPermController = TextEditingController();
  final dzongkhagPermController = TextEditingController();
  final villageTempController = TextEditingController();
  final gewogTempController = TextEditingController();
  final dzongkhagTempController = TextEditingController();
  final joiningDateController = TextEditingController();
  final positionLevelController = TextEditingController();
  final positionTitleController = TextEditingController();
  final directoryController = TextEditingController();
  final statusController = TextEditingController();
  final nationalityController = TextEditingController();
  final staffTypeController = TextEditingController();

  // var showError = false;
  // late Timer _timer;

  @override
  void dispose() {
    staffIDController.dispose(); // Corrected the typo
    cidController.dispose();
    nameController.dispose();
    emailController.dispose();
    genderController.dispose();
    dobController.dispose();
    bloodGroupController.dispose();
    phoneNumberController.dispose();
    villagePermController.dispose();
    villageTempController.dispose();
    gewogPermController.dispose();
    gewogTempController.dispose();
    dzongkhagPermController.dispose();
    dzongkhagTempController.dispose();
    joiningDateController.dispose();
    positionLevelController.dispose();
    positionTitleController.dispose();
    directoryController.dispose();
    nationalityController.dispose();
    statusController.dispose();
    staffTypeController.dispose();

    // _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // startTimer();
  }

  void _clearFields() {
    staffIDController.clear();
    cidController.clear(); // Corrected the typo
    nameController.clear();
    emailController.clear();
    genderController.clear();
    dobController.clear();
    bloodGroupController.clear();
    phoneNumberController.clear();
    villagePermController.clear();
    villageTempController.clear();
    gewogPermController.clear();
    gewogTempController.clear();
    dzongkhagPermController.clear();
    dzongkhagTempController.clear();
    joiningDateController.clear();
    positionLevelController.clear();
    positionTitleController.clear();
    directoryController.clear();
    nationalityController.clear();
    statusController.clear();
    staffTypeController.clear();
  }

  void _validateFields() async {
    // Retrieve the entered data from the TextEditingController instances
    String staffID = widget.username ?? staffIDController.text;
    String cid = cidController.text;
    String name = nameController.text;
    String email = emailController.text;
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
    String positionLevel = positionLevelController.text;
    String positionTitle = positionTitleController.text;
    String directory = directoryController.text;
    String joiningDate = joiningDateController.text;
    String status = statusController.text;
    String nationality = nationalityController.text;
    String staffType = staffTypeController.text;

    // Perform the validation
    if (staffID.isNotEmpty &&
        cid.isNotEmpty &&
        name.isNotEmpty &&
        email.isNotEmpty &&
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
        positionLevel.isNotEmpty &&
        positionTitle.isNotEmpty &&
        status.isNotEmpty &&
        nationality.isNotEmpty &&
        staffType.isNotEmpty &&
        directory.isNotEmpty &&
        joiningDate.isNotEmpty) {
      // Create the staff in parallel and wait for it to complete
      await createStaff(
          staffID: staffID,
          cid: cid,
          name: name,
          email: email,
          gender: gender.toLowerCase(),
          dob: dob,
          bloodGroup: bloodGroup.toLowerCase(),
          phoneNumber: phoneNumber,
          nationality: nationality,
          status: convertToLowerCaseWithUnderscores(status),
          staffType: convertToLowerCaseWithUnderscores(staffType),
          villagePerm: villagePerm,
          gewogPerm: gewogPerm,
          dzongkhagPerm: dzongkhagPerm,
          villageTemp: villageTemp,
          gewogTemp: gewogTemp,
          dzongkhagTemp: dzongkhagTemp,
          positionLevel: positionLevel,
          positionTitle: positionTitle,
          directory: directory,
          joiningDate: joiningDate);

      // Navigate to the next screen
      navigateToNextScreen(staffID);
    } else {
      print("hello World");
    }
  }

  void navigateToNextScreen(String staffID) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QualificationWidget(staffID: staffID),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: fetchDirectoryNames(),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Display a loading indicator while fetching directory names
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // Display an error message if fetching directory names fails
          return Text('Error: ${snapshot.error}');
        } else {
          // Directory names fetched successfully, build the widget tree
          return Container(
            margin: EdgeInsets.symmetric(
                horizontal: AppResponsive.isMobile(context) ? 30 : 50),
            padding: EdgeInsets.all(AppResponsive.isMobile(context) ? 30 : 40),
            color: AppColor.white,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Spacer(),
                    // if (showError)
                    //   AnimatedOpacity(
                    //     opacity: showError ? 1.0 : 0.0,
                    //     duration: const Duration(milliseconds: 500),
                    //     child: showError
                    //         ? Text(
                    //             "Enter all information",
                    //             style: TextStyle(
                    //                 fontSize: FontSize.header_3(context),
                    //                 color: AppColor.error),
                    //           )
                    //         : const SizedBox
                    //             .shrink(), // Return an empty widget when there is no error
                    //   ),
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
                const ImageWidget(),
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    widget.username ?? "Staff Biodata",
                    style: TextStyle(
                        fontSize: FontSize.header_3(context),
                        fontWeight: FontWeight.bold,
                        color: AppColor.black),
                  ),
                ),
                const Divider(
                  thickness: 1.0,
                  color: Colors.grey,
                ),
                const SizedBox(height: 10),
                if (AppResponsive.isMobile(context))
                  buildMobileLayout()
                else
                  buildDesktopLayout(),
                const Divider(
                  thickness: 1.0,
                  color: Colors.grey,
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
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
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
          );
        }
      },
    );
  }

  Widget buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildFormFieldMobile(
            context, 'Staff ID', staffIDController, FormFieldType.text),
        buildFormFieldMobile(context, 'CID', cidController, FormFieldType.text),
        buildFormFieldMobile(
            context, 'Name', nameController, FormFieldType.text),
        buildFormFieldMobile(
            context, 'E-mail', emailController, FormFieldType.text),
        buildFormFieldMobile(context, 'Gender', genderController,
            FormFieldType.e_num, genderOptions),
        buildFormFieldMobile(
            context, 'Date of Birth', dobController, FormFieldType.date),
        buildFormFieldMobile(context, 'Blood Group', bloodGroupController,
            FormFieldType.e_num, bloodGroupOptions),
        buildFormFieldMobile(context, 'Phone Number', phoneNumberController,
            FormFieldType.number),
        buildFormFieldMobile(
            context, 'Nationality', nationalityController, FormFieldType.text),
        buildFormFieldMobile(
            context, 'Joining Date', joiningDateController, FormFieldType.date),
        buildFormFieldMobile(context, 'Staff Type', staffTypeController,
            FormFieldType.e_num, staffType),
        buildFormFieldMobile(
            context, 'Status', statusController, FormFieldType.e_num, status),
        buildFormFieldMobile(context, 'Department', directoryController,
            FormFieldType.e_num, directoryNames),
        buildFormFieldMobile(context, 'Position Level', positionLevelController,
            FormFieldType.text),
        buildFormFieldMobile(context, 'Position Title', positionTitleController,
            FormFieldType.text),
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
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.username == null)
                    buildFormFieldDesktop(context, 'Staff ID',
                        staffIDController, FormFieldType.text),
                  buildFormFieldDesktop(
                      context, 'CID', cidController, FormFieldType.text),
                  buildFormFieldDesktop(
                      context, 'Name', nameController, FormFieldType.text),
                  buildFormFieldDesktop(
                      context, 'E-mail', emailController, FormFieldType.text),
                  buildFormFieldDesktop(context, 'Gender', genderController,
                      FormFieldType.e_num, genderOptions),
                  buildFormFieldDesktop(context, 'Date of Birth', dobController,
                      FormFieldType.date),
                  buildFormFieldDesktop(
                      context,
                      'Blood Group',
                      bloodGroupController,
                      FormFieldType.e_num,
                      bloodGroupOptions),
                  buildFormFieldDesktop(
                    context,
                    'Phone Number',
                    phoneNumberController,
                    FormFieldType.number,
                  ),
                  buildFormFieldDesktop(context, 'Nationality',
                      nationalityController, FormFieldType.text),
                  buildFormFieldDesktop(context, 'Joining Date',
                      joiningDateController, FormFieldType.date),
                  buildFormFieldDesktop(context, 'Staff Type',
                      staffTypeController, FormFieldType.e_num, staffType),
                  buildFormFieldDesktop(context, 'Status', statusController,
                      FormFieldType.e_num, status),
                ],
              ),
            ),
            const SizedBox(width: 40),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildFormFieldDesktop(context, 'Position Level',
                      positionLevelController, FormFieldType.text),
                  buildFormFieldDesktop(context, 'Position Title',
                      positionTitleController, FormFieldType.text),
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
                  buildFormFieldDesktop(context, "Village",
                      villagePermController, FormFieldType.text),
                  buildFormFieldDesktop(context, 'Gewog', gewogPermController,
                      FormFieldType.text),
                  buildFormFieldDesktop(
                      context,
                      'Dzongkhag',
                      dzongkhagPermController,
                      FormFieldType.e_num,
                      dzongkhagOptions),
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
                  buildFormFieldDesktop(context, "Village",
                      villageTempController, FormFieldType.text),
                  buildFormFieldDesktop(context, 'Gewog', gewogTempController,
                      FormFieldType.text),
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
        ),
        const SizedBox(
          height: 10,
        ),
        Center(
          child: buildFormFieldDesktop(context, 'Department',
              directoryController, FormFieldType.e_num, directoryNames),
        ),
      ],
    );
  }
}
