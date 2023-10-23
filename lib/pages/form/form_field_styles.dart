import 'package:flutter/material.dart';

import '../../common/app_responsive.dart';

double getBorderRadius(context) {
  return AppResponsive.isMobile(context) ? 100 : 10;
}

EdgeInsets getContentPadding(context) {
  return EdgeInsets.only(
    left: AppResponsive.isMobile(context) ? 20 : 30,
    right: AppResponsive.isMobile(context) ? 10 : 30,
    top: AppResponsive.isMobile(context) ? 8 : 18,
    bottom: AppResponsive.isMobile(context) ? 8 : 18,
  );
}

InputDecoration buildInputTextDecoration(
  context,
  label,
) {
  return InputDecoration(
      labelText: AppResponsive.isMobile(context) ? label : null,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(getBorderRadius(context))),
      contentPadding: getContentPadding(context));
}

InputDecoration buildInputDateDecoration(context, label, controller) {
  return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(getBorderRadius(context))),
      suffixIcon: IconButton(
        icon: const Icon(Icons.calendar_today),
        onPressed: () {
          _selectDate(context, controller);
        },
      ),
      contentPadding: getContentPadding(context));
}

Future<void> _selectDate(
    BuildContext context, TextEditingController controller) async {
  DateTime? pickedDate = await showDatePicker(
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
    controller.text = pickedDate.toString();
  }
}
