import 'package:flutter/material.dart';
import 'package:spims/common/app_font_size.dart';
import 'package:spims/common/image_widget.dart';
import 'package:spims/common/utils.dart';
import 'package:spims/pages/form/fetch_username.dart';
import 'package:spims/pages/form/form_utils/create_staff.dart';
import 'package:spims/pages/home_page.dart';
import '../../../common/app_colors.dart';
import '../../../common/app_responsive.dart';
import '../../dashboard/widget/staff_details_widget.dart';
import '../../profile/profile_service.dart';
import '../form_builders/form_field_builder.dart';
import '../../../common/options.dart';

class EditBiodata extends StatefulWidget {
  final String? staffID;

  const EditBiodata({super.key, this.staffID});

  @override
  _EditBiodataState createState() => _EditBiodataState();
}

class _EditBiodataState extends State<EditBiodata> {
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

  // ignore: prefer_typing_uninitialized_variables
  late final String? username;
  Map<String, dynamic>? biodata;

  @override
  void dispose() {
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

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.staffID == null || widget.staffID!.isEmpty) {
      getUsername();
      fetchProfileData();
    } else {
      profileData();
    }
  }

  Future<void> profileData() async {
    final profileData =
        await DetailsService.fetchProfileData(username: widget.staffID);

    setState(() {
      biodata = profileData['biodata'];
    });
  }

  Future<void> fetchProfileData() async {
    final profileData = await ProfileService.fetchProfileData();

    setState(() {
      biodata = profileData['biodata'];
    });
  }

  void getUsername() async {
    final storedUsername = await fetchUsername();
    setState(() {
      username = storedUsername ?? '';
    });
  }

  void _clearFields() {
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
    if (cid.isNotEmpty &&
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
          staffID: widget.staffID ?? username!,
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
      navigateToNextScreen();
    } else {
      print("hello World");
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
        title: const Text(
          'Edit Information',
          style: TextStyle(color: AppColor.black),
        ),
        backgroundColor: AppColor.white,
        iconTheme: const IconThemeData(color: AppColor.grey),
      ),
      body: FutureBuilder<void>(
        future: fetchDirectoryNames(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Display a loading indicator while fetching directory names
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            // Display an error message if fetching directory names fails
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            // Directory names fetched successfully, build the widget tree
            return SingleChildScrollView(
              // Wrap with SingleChildScrollView
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: AppResponsive.isMobile(context) ? 30 : 50,
                ),
                padding: EdgeInsets.all(
                  AppResponsive.isMobile(context) ? 30 : 40,
                ),
                color: AppColor.white,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Spacer(),
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
                        widget.staffID ?? username!,
                        style: TextStyle(
                          fontSize: FontSize.header_3(context),
                          fontWeight: FontWeight.bold,
                          color: AppColor.black,
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 1.0,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 10),
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
                            _validateFields(); // function that checks whether the data was inserted or not
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              AppColor.primary,
                            ),
                            padding:
                                MaterialStateProperty.all<EdgeInsetsGeometry>(
                              const EdgeInsets.symmetric(vertical: 16),
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
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
            );
          }
        },
      ),
    );
  }

  Widget buildDesktopLayout() {
    // Set default values for the controllers using the biodata map
    cidController.text = biodata!['cid'];
    nameController.text = biodata!['name'];
    emailController.text = biodata!['email'];
    genderController.text = biodata!['gender'];
    dobController.text = biodata!['dateofbirth'];
    bloodGroupController.text = biodata!['bloodgroup'];
    phoneNumberController.text = biodata!['phonenumber'];
    nationalityController.text = biodata!['nationality'];
    joiningDateController.text = biodata!['joiningdate'];
    staffTypeController.text = biodata!['stafftype'];
    statusController.text = biodata!['staffstatus'];
    positionLevelController.text = biodata!['positionlevel'].toString();
    positionTitleController.text = biodata!['positiontitle'];
    villagePermController.text = biodata!['permanentaddress']['villagename'];
    gewogPermController.text = biodata!['permanentaddress']['gewog'];
    dzongkhagPermController.text = biodata!['permanentaddress']['dzongkhag'];
    villageTempController.text = biodata!['temporaryaddress']['villagename'];
    gewogTempController.text = biodata!['temporaryaddress']['gewog'];
    dzongkhagTempController.text = biodata!['temporaryaddress']['dzongkhag'];

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildFormFieldDesktop(
                    context,
                    'CID',
                    cidController,
                    FormFieldType.text,
                  ),
                  buildFormFieldDesktop(
                    context,
                    'Name',
                    nameController,
                    FormFieldType.text,
                  ),
                  buildFormFieldDesktop(
                    context,
                    'E-mail',
                    emailController,
                    FormFieldType.text,
                  ),
                  buildFormFieldDesktop(
                    context,
                    'Gender',
                    genderController,
                    FormFieldType.e_num,
                    genderOptions,
                  ),
                  buildFormFieldDesktop(
                    context,
                    'Date of Birth',
                    dobController,
                    FormFieldType.date,
                  ),
                  buildFormFieldDesktop(
                    context,
                    'Blood Group',
                    bloodGroupController,
                    FormFieldType.e_num,
                    bloodGroupOptions,
                  ),
                  buildFormFieldDesktop(
                    context,
                    'Phone Number',
                    phoneNumberController,
                    FormFieldType.number,
                  ),
                  buildFormFieldDesktop(
                    context,
                    'Nationality',
                    nationalityController,
                    FormFieldType.text,
                  ),
                  buildFormFieldDesktop(
                    context,
                    'Joining Date',
                    joiningDateController,
                    FormFieldType.date,
                  ),
                  buildFormFieldDesktop(
                    context,
                    'Staff Type',
                    staffTypeController,
                    FormFieldType.e_num,
                    staffType,
                  ),
                  buildFormFieldDesktop(
                    context,
                    'Status',
                    statusController,
                    FormFieldType.e_num,
                    status,
                  ),
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
                    dzongkhagOptions,
                  ),
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
