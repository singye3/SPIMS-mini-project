import 'dart:convert';

import 'package:flutter/material.dart';

import '../../common/link_launcher.dart';
import 'developer.dart';

Future<List<Developer>> readDevelopersFromJson(BuildContext context) async {
  final jsonString = await DefaultAssetBundle.of(context)
      .loadString('assets/data/developers.json');
  final jsonData = json.decode(jsonString) as List<dynamic>;

  return jsonData.map((item) {
    return Developer(
      name: item['name'] as String,
      email: item['email'] as String,
      phone: item['phone'] as String,
      image: item['image'] as String,
    );
  }).toList();
}

void showDeveloperDetails(BuildContext context, Developer developer) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: Text(
          developer.name,
          style: const TextStyle(color: Colors.black),
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () => sendEmail(developer.email),
              child: Text(
                'Email: ${developer.email}',
                style: const TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            InkWell(
              onTap: () => callPhone(developer.phone),
              child: Text(
                'Phone: ${developer.phone}',
                style: const TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
            ),
            child: const Text(
              'Close',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      );
    },
  );
}
