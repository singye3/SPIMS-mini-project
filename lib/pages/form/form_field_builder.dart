import 'package:flutter/material.dart';

import './form_field.dart';

enum FormFieldType { date, text, number, e_num }

Widget buildFormFieldDesktop(context, label, controller, FormFieldType type) {
  switch (type) {
    case FormFieldType.date:
      return dateForDesktop(context, label, controller);
    case FormFieldType.text:
      return stringForDesktop(context, label, controller);
    case FormFieldType.number:
      return numberForDesktop(context, label, controller);
    case FormFieldType.e_num:
      return enumForDesktop(context, label, controller);
  }
}

Widget buildFormFieldMobile(context, label, controller, FormFieldType type) {
  switch (type) {
    case FormFieldType.date:
      return dateForMobile(
        context,
        label,
        controller,
      );
    case FormFieldType.text:
      return stringForMobile(context, label, controller);
    case FormFieldType.number:
      return numberForMobile(context, label, controller);
    case FormFieldType.e_num:
      return enumForMobile(context, label, controller);
  }
}
