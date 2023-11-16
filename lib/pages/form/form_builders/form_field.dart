import 'package:flutter/material.dart';
import 'package:spims/common/app_colors.dart';
import 'package:spims/common/app_font_size.dart';

import 'form_field_styles.dart';

Widget dateFormFieldForMobile(
    BuildContext context, String label, TextEditingController controller) {
  return Column(
    children: [
      TextField(
        controller: controller,
        decoration: buildInputDateDecoration(context, label, controller),
        style: TextStyle(
            color: AppColor.black, fontSize: FontSize.bodyFontSize(context)),
      ),
      const SizedBox(height: 10),
    ],
  );
}

Widget dateFormFieldForDesktop(
    BuildContext context, String label, TextEditingController controller) {
  return Column(
    children: [
      Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              label,
              style: TextStyle(
                color: AppColor.black,
                fontSize: FontSize.bodyFontSize(context),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: TextField(
              controller: controller,
              decoration: buildInputDateDecoration(context, label, controller),
              style: TextStyle(
                color: AppColor.black,
                fontSize: FontSize.bodyFontSize(context),
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 10),
    ],
  );
}

Widget stringFormFieldForDesktop(
    BuildContext context, String label, TextEditingController controller) {
  return Column(
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              label,
              style: TextStyle(
                color: AppColor.black,
                fontSize: FontSize.bodyFontSize(context),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: TextField(
              controller: controller,
              decoration: buildInputTextDecoration(context, label),
              style: TextStyle(
                color: AppColor.black,
                fontSize: FontSize.bodyFontSize(context),
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 10),
    ],
  );
}

Widget stringFormFieldForMobile(
    BuildContext context, String label, TextEditingController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      TextField(
        keyboardType: TextInputType.number,
        controller: controller,
        decoration: buildInputTextDecoration(context, label),
        style: TextStyle(
          color: AppColor.black,
          fontSize: FontSize.bodyFontSize(context),
        ),
      ),
      const SizedBox(height: 10),
    ],
  );
}

Widget numberFormFieldForDesktop(
    BuildContext context, String label, TextEditingController controller) {
  return Column(
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              label,
              style: TextStyle(
                color: AppColor.black,
                fontSize: FontSize.bodyFontSize(context),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: TextField(
              keyboardType: TextInputType.number,
              controller: controller,
              decoration: buildInputTextDecoration(context, label),
              style: TextStyle(
                color: AppColor.black,
                fontSize: FontSize.bodyFontSize(context),
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 10),
    ],
  );
}

Widget numberFormFieldForMobile(
    BuildContext context, String label, TextEditingController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      TextField(
        controller: controller,
        decoration: buildInputTextDecoration(context, label),
        style: TextStyle(
          color: AppColor.black,
          fontSize: FontSize.bodyFontSize(context),
        ),
      ),
      const SizedBox(height: 10),
    ],
  );
}

Widget enumFormFieldForMobile(BuildContext context, String label,
    TextEditingController controller, List<String> options) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      DropdownButtonFormField(
        onChanged: (value) {
          controller.text = value.toString();
        },
        dropdownColor: Colors.white,
        items: options.map((option) {
          return DropdownMenuItem(
            value: option,
            child: Text(option),
          );
        }).toList(),
        decoration: buildInputEnumDecoration(context, label),
        style: TextStyle(
          color: AppColor.black,
          fontSize: FontSize.bodyFontSize(context),
        ),
      ),
      const SizedBox(height: 10),
    ],
  );
}

Widget enumFormFieldForDesktop(BuildContext context, String label,
    TextEditingController controller, List<String> options) {
  return Column(
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              label,
              style: TextStyle(
                color: AppColor.black,
                fontSize: FontSize.bodyFontSize(context),
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: DropdownButtonFormField(
              onChanged: (value) {
                controller.text = value.toString();
              },
              dropdownColor: Colors.white,
              items: options.map((option) {
                return DropdownMenuItem(
                  value: option,
                  child: Text(
                    option,
                    style: TextStyle(fontSize: FontSize.bodyFontSize(context)),
                  ),
                );
              }).toList(),
              decoration: buildInputEnumDecoration(context, label),
              style: TextStyle(
                color: AppColor.black,
                fontSize: FontSize.bodyFontSize(context),
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 10),
    ],
  );
}
