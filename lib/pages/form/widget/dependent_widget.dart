import 'package:flutter/material.dart';
import '../../../common/app_colors.dart';
import '../../../common/app_responsive.dart';
import '../form_field_builder.dart';

class DependentWidget extends StatefulWidget {
  const DependentWidget({super.key});

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
  final permanentAddressController = TextEditingController();
  final temporaryAddressController = TextEditingController();

  @override
  void dispose() {
    cidController.dispose();
    nameController.dispose();
    genderController.dispose();
    dobController.dispose();
    bloodGroupController.dispose();
    phoneNumberController.dispose();
    dependentTypeController.dispose();
    permanentAddressController.dispose();
    temporaryAddressController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: AppResponsive.isMobile(context) ? 30 : 50),
        padding: EdgeInsets.all(AppResponsive.isMobile(context) ? 30 : 40),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: AppColor.bgColor,
        ),
        child: Column(
          children: [
            const SizedBox(height: 10),
            if (AppResponsive.isMobile(context))
              buildMobileLayout()
            else
              buildDesktopLayout(),
          ],
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
            context, 'Gender', genderController, FormFieldType.e_num),
        buildFormFieldMobile(
            context, 'Date of Birth', dobController, FormFieldType.date),
        buildFormFieldMobile(
            context, 'Blood Group', bloodGroupController, FormFieldType.e_num),
        buildFormFieldMobile(context, 'Phone Number', phoneNumberController,
            FormFieldType.number),
        buildFormFieldMobile(context, 'Relation Type',
            permanentAddressController, FormFieldType.e_num),
        buildFormFieldMobile(context, 'Permanent Address',
            permanentAddressController, FormFieldType.text),
        buildFormFieldMobile(context, 'Temporary Address',
            temporaryAddressController, FormFieldType.text),
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
                  context, 'Gender', genderController, FormFieldType.e_num),
              buildFormFieldDesktop(
                  context, 'Date of Birth', dobController, FormFieldType.date),
              buildFormFieldDesktop(context, 'Blood Group',
                  bloodGroupController, FormFieldType.e_num),
            ],
          ),
        ),
        const SizedBox(width: 40),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildFormFieldDesktop(context, 'Phone Number',
                  phoneNumberController, FormFieldType.number),
              buildFormFieldDesktop(context, 'Relation Type',
                  permanentAddressController, FormFieldType.e_num),
              buildFormFieldDesktop(context, 'Permanent Address',
                  permanentAddressController, FormFieldType.text),
              buildFormFieldDesktop(context, 'Temporary Address',
                  temporaryAddressController, FormFieldType.text),
            ],
          ),
        ),
      ],
    );
  }
}
