import 'package:flutter/material.dart';

import 'form_field.dart';

enum FormFieldType { date, text, number, e_num }

Widget buildFormFieldDesktop(context, label, controller, FormFieldType type,
    [List<String>? options]) {
  switch (type) {
    case FormFieldType.date:
      return dateFormFieldForDesktop(context, label, controller);
    case FormFieldType.text:
      return stringFormFieldForDesktop(context, label, controller);
    case FormFieldType.number:
      return numberFormFieldForDesktop(context, label, controller);
    case FormFieldType.e_num:
      return enumFormFieldForDesktop(context, label, controller, options ?? []);
  }
}

Widget buildFormFieldMobile(context, label, controller, FormFieldType type,
    [List<String>? options]) {
  switch (type) {
    case FormFieldType.date:
      return dateFormFieldForMobile(
        context,
        label,
        controller,
      );
    case FormFieldType.text:
      return stringFormFieldForMobile(context, label, controller);
    case FormFieldType.number:
      return numberFormFieldForMobile(context, label, controller);
    case FormFieldType.e_num:
      return enumFormFieldForMobile(context, label, controller, options ?? []);
  }
}
