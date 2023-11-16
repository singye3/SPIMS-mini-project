import 'package:flutter/material.dart';
import 'package:spims/common/app_colors.dart';

import '../../../common/app_responsive.dart';

double getBorderRadius(BuildContext context) {
  return AppResponsive.isMobile(context) ? 10 : 10;
}

EdgeInsets getContentPadding(BuildContext context) {
  return EdgeInsets.only(
    left: AppResponsive.isMobile(context) ? 10 : 10,
    right: AppResponsive.isMobile(context) ? 10 : 10,
  );
}

InputDecoration buildInputTextDecoration(BuildContext context, String label) {
  return InputDecoration(
    labelText: AppResponsive.isMobile(context) ? label : null,
    labelStyle: const TextStyle(color: AppColor.grey),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(getBorderRadius(context)),
      borderSide: const BorderSide(color: AppColor.grey, width: 0.7),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(getBorderRadius(context)),
      borderSide: const BorderSide(color: AppColor.primary, width: 1.5),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(getBorderRadius(context)),
      borderSide: const BorderSide(color: AppColor.error, width: 1.5),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(getBorderRadius(context)),
      borderSide: const BorderSide(color: AppColor.error, width: 0.7),
    ),
    contentPadding: getContentPadding(context),
  );
}

InputDecoration buildInputEnumDecoration(BuildContext context, String label) {
  return InputDecoration(
    labelText: AppResponsive.isMobile(context) ? label : null,
    labelStyle: const TextStyle(color: AppColor.grey),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(getBorderRadius(context)),
      borderSide: const BorderSide(color: AppColor.grey, width: 0.7),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(getBorderRadius(context)),
      borderSide: const BorderSide(color: AppColor.primary, width: 1.5),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(getBorderRadius(context)),
      borderSide: const BorderSide(color: AppColor.error, width: 1.5),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(getBorderRadius(context)),
      borderSide: const BorderSide(color: AppColor.error, width: 0.7),
    ),
    suffixIcon: const Icon(
      Icons.arrow_drop_down_outlined,
      color: AppColor.grey,
    ),
    contentPadding: getContentPadding(context),
  );
}

InputDecoration buildInputDateDecoration(
    BuildContext context, String label, TextEditingController controller) {
  return InputDecoration(
    labelText: AppResponsive.isMobile(context) ? label : null,
    labelStyle: const TextStyle(color: AppColor.grey),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(getBorderRadius(context)),
      borderSide: const BorderSide(color: AppColor.grey, width: 0.7),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(getBorderRadius(context)),
      borderSide: const BorderSide(color: AppColor.primary, width: 1.5),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(getBorderRadius(context)),
      borderSide: const BorderSide(color: AppColor.error, width: 1.5),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(getBorderRadius(context)),
      borderSide: const BorderSide(color: AppColor.error, width: 0.7),
    ),
    suffixIcon: IconButton(
      icon: const Icon(
        Icons.calendar_today,
        color: AppColor.grey,
      ),
      onPressed: () {
        _selectDate(context, controller);
      },
    ),
    contentPadding: getContentPadding(context),
  );
}

Future<void> _selectDate(
    BuildContext context, TextEditingController controller) async {
  final DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
    builder: (context, child) {
      return Theme(
        data: ThemeData.dark().copyWith(
          colorScheme: const ColorScheme.dark(
            primary: Colors.black,
            onPrimary: Colors.white,
            surface: Colors.white,
            onSurface: Colors.black,
          ),
        ),
        child: child!,
      );
    },
  );

  if (pickedDate != null) {
    controller.text = pickedDate.toIso8601String().substring(0, 10);
  }
}
