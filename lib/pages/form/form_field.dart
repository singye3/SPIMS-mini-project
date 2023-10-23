import 'package:flutter/material.dart';

import './form_field_styles.dart';

Widget dateForMobile(
    BuildContext context, String label, TextEditingController controller) {
  return Column(
    children: [
      Row(
        children: [
          Expanded(
            flex: 3,
            child: TextField(
                controller: controller,
                decoration:
                    buildInputDateDecoration(context, label, controller)),
          )
        ],
      ),
      const SizedBox(height: 10),
    ],
  );
}

Widget dateForDesktop(
    BuildContext context, String label, TextEditingController controller) {
  return Column(
    children: [
      Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 3,
            child: TextField(
                controller: controller,
                decoration:
                    buildInputDateDecoration(context, label, controller)),
          ),
        ],
      ),
      const SizedBox(height: 10),
    ],
  );
}

Widget stringForDesktop(context, label, controller) {
  return Column(
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: TextField(
              controller: controller,
              decoration: buildInputTextDecoration(context, label),
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 10),
    ],
  );
}

Widget stringForMobile(context, label, controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      TextField(
          keyboardType: TextInputType.number,
          controller: controller,
          decoration: buildInputTextDecoration(context, label)),
      const SizedBox(height: 10),
    ],
  );
}

Widget numberForDesktop(context, label, controller) {
  return Column(
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: TextField(
              keyboardType: TextInputType.number,
              controller: controller,
              decoration: buildInputTextDecoration(context, label),
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 10),
    ],
  );
}

Widget numberForMobile(context, label, controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      TextField(
        controller: controller,
        decoration: buildInputTextDecoration(context, label),
      ),
      const SizedBox(height: 10),
    ],
  );
}

Widget enumForMobile(context, label, controller) {
  String selectedValue = 'Option 1';

  return Column(
    children: [
      DropdownButtonFormField(
        value: selectedValue,
        onChanged: (value) {
          controller.text = value.toString();
        },
        icon: const Icon(
          Icons.arrow_drop_down,
          color: Colors.black,
        ),
        dropdownColor: Colors.white,
        items: const [
          DropdownMenuItem(
            value: 'Option 1',
            child: Text('Option 1'),
          ),
          DropdownMenuItem(
            value: 'Option 2',
            child: Text('Option 2'),
          ),
          DropdownMenuItem(
            value: 'Option 3',
            child: Text('Option 3'),
          ),
        ],
        decoration: buildInputTextDecoration(context, label),
      ),
      const SizedBox(height: 10),
    ],
  );
}

Widget enumForDesktop(context, label, controller) {
  String selectedValue = 'Option 1';

  return Column(
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: DropdownButtonFormField(
              value: selectedValue,
              onChanged: (value) {
                controller.text = value.toString();
              },
              icon: const Icon(
                Icons.arrow_drop_down,
                color: Colors.black,
              ),
              dropdownColor: Colors.white,
              items: const [
                DropdownMenuItem(
                  value: 'Option 1',
                  child: Text('Option 1'),
                ),
                DropdownMenuItem(
                  value: 'Option 2',
                  child: Text('Option 2'),
                ),
                DropdownMenuItem(
                  value: 'Option 3',
                  child: Text('Option 3'),
                ),
              ],
              decoration: buildInputTextDecoration(context, label),
            ),
          ),
        ],
      ),
      const SizedBox(height: 10),
    ],
  );
}
