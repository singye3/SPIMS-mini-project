import 'package:flutter/material.dart';
import '../../../common/app_colors.dart';
import '../../../common/app_responsive.dart';
import '../form_field_builder.dart';

class QualificationWidget extends StatefulWidget {
  const QualificationWidget({super.key});

  @override
  _QualificationWidgetState createState() => _QualificationWidgetState();
}

class _QualificationWidgetState extends State<QualificationWidget> {
  final qualificationNameController = TextEditingController();
  final qualificationIDController = TextEditingController();
  final institutionNameController = TextEditingController();
  final institutionLocationController = TextEditingController();
  final graduationDateContoller = TextEditingController();
  final majorFieldController = TextEditingController();
  final gpaGradeController = TextEditingController();
  final honorsAwardController = TextEditingController();

  @override
  void dispose() {
    qualificationIDController.dispose();
    qualificationNameController.dispose();
    institutionNameController.dispose();
    institutionLocationController.dispose();
    graduationDateContoller.dispose();
    majorFieldController.dispose();
    gpaGradeController.dispose();
    honorsAwardController.dispose();

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
        buildFormFieldMobile(context, 'Qualification ID',
            qualificationIDController, FormFieldType.text),
        buildFormFieldMobile(context, 'Qualification Name',
            qualificationNameController, FormFieldType.text),
        buildFormFieldMobile(context, 'Institution Name',
            institutionNameController, FormFieldType.text),
        buildFormFieldMobile(context, 'Institution Location',
            institutionLocationController, FormFieldType.text),
        buildFormFieldMobile(context, 'Graduation Date',
            graduationDateContoller, FormFieldType.text),
        buildFormFieldMobile(
            context, 'Major Field', majorFieldController, FormFieldType.text),
        buildFormFieldMobile(
            context, 'GPA Grade', gpaGradeController, FormFieldType.number),
        buildFormFieldMobile(context, 'Honour Award', honorsAwardController,
            FormFieldType.e_num),
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
              buildFormFieldDesktop(context, 'Qualification ID',
                  qualificationIDController, FormFieldType.text),
              buildFormFieldDesktop(context, 'Qualification Name',
                  qualificationNameController, FormFieldType.text),
              buildFormFieldDesktop(context, 'Institution Name',
                  institutionNameController, FormFieldType.text),
              buildFormFieldDesktop(context, 'Institution Location',
                  institutionLocationController, FormFieldType.text),
            ],
          ),
        ),
        const SizedBox(width: 40),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildFormFieldDesktop(context, 'Graduation Date',
                  graduationDateContoller, FormFieldType.date),
              buildFormFieldDesktop(context, 'Major Field',
                  majorFieldController, FormFieldType.text),
              buildFormFieldDesktop(context, 'GPA Grade', gpaGradeController,
                  FormFieldType.number),
              buildFormFieldDesktop(context, 'Honour Award',
                  honorsAwardController, FormFieldType.e_num),
            ],
          ),
        ),
      ],
    );
  }
}
