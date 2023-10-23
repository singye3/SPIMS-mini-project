import 'package:flutter/material.dart';
import '../../../common/app_colors.dart';
import '../../../common/app_responsive.dart';
import '../../form/form_field_builder.dart';

class StaffBioDataWidget extends StatefulWidget {
  @override
  _StaffBioDataWidgetState createState() => _StaffBioDataWidgetState();
}

class _StaffBioDataWidgetState extends State<StaffBioDataWidget> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final genderController = TextEditingController();
  final dobController = TextEditingController();
  final bloodGroupController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final permanentAddressController = TextEditingController();
  final temporaryAddressController = TextEditingController();
  final staffIDController = TextEditingController();
  final joiningDateController = TextEditingController();
  final positionLevelController = TextEditingController();
  final positionTitleController = TextEditingController();
  final staffStatusController = TextEditingController();

  @override
  void dispose() {
    staffIDController.dispose(); // Corrected the typo
    nameController.dispose();
    emailController.dispose();
    genderController.dispose();
    dobController.dispose();
    bloodGroupController.dispose();
    phoneNumberController.dispose();
    permanentAddressController.dispose();
    temporaryAddressController.dispose();
    joiningDateController.dispose();
    positionLevelController.dispose();
    positionTitleController.dispose();
    staffStatusController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: AppColor.bgColor,
      ),
      child: Column(
        children: [
          const Center(
            child: Text(
              "Staff Biodata",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
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
        ],
      ),
    );
  }

  Widget buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildFormFieldMobile(
            context, 'Staff ID', staffIDController, FormFieldType.text),
        buildFormFieldMobile(
            context, 'Name', nameController, FormFieldType.text),
        buildFormFieldMobile(
            context, 'E-mail', emailController, FormFieldType.text),
        buildFormFieldMobile(
            context, 'Gender', genderController, FormFieldType.e_num),
        buildFormFieldMobile(
            context, 'Date of Birth', dobController, FormFieldType.date),
        buildFormFieldMobile(
            context, 'Blood Group', bloodGroupController, FormFieldType.e_num),
        buildFormFieldMobile(context, 'Phone Number', phoneNumberController,
            FormFieldType.number),
        buildFormFieldMobile(context, 'Department', permanentAddressController,
            FormFieldType.e_num),
        buildFormFieldMobile(context, 'Permanent Address',
            permanentAddressController, FormFieldType.text),
        buildFormFieldMobile(context, 'Temporary Address',
            temporaryAddressController, FormFieldType.text),
        buildFormFieldMobile(context, 'Position Level', positionLevelController,
            FormFieldType.text),
        buildFormFieldMobile(context, 'Position Title', positionTitleController,
            FormFieldType.text),
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
                  context, 'Staff ID', staffIDController, FormFieldType.text),
              buildFormFieldDesktop(
                  context, 'Name', nameController, FormFieldType.text),
              buildFormFieldDesktop(
                  context, 'E-mail', emailController, FormFieldType.text),
              buildFormFieldDesktop(
                  context, 'Gender', genderController, FormFieldType.e_num),
              buildFormFieldDesktop(
                  context, 'Date of Birth', dobController, FormFieldType.date),
              buildFormFieldDesktop(context, 'Blood Group',
                  bloodGroupController, FormFieldType.e_num),
            ],
          ),
        ),
        SizedBox(width: 40),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildFormFieldDesktop(context, 'Department',
                  permanentAddressController, FormFieldType.e_num),
              buildFormFieldDesktop(context, 'Permanent Address',
                  permanentAddressController, FormFieldType.text),
              buildFormFieldDesktop(context, 'Temporary Address',
                  temporaryAddressController, FormFieldType.text),
              buildFormFieldDesktop(context, 'Position Level',
                  positionLevelController, FormFieldType.text),
              buildFormFieldDesktop(context, 'Position Title',
                  positionTitleController, FormFieldType.text),
            ],
          ),
        ),
      ],
    );
  }
}
