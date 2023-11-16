import 'package:flutter/material.dart';
import 'package:spims/common/app_colors.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({Key? key}) : super(key: key);

  @override
  _ContactUsPageState createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  String? _selectedIssueType;
  List<Item> _issueTypes = [
    Item(
      'Technical issue',
      'Description for technical issue',
    ),
    Item(
      'Account problem',
      'Description for account problem',
    ),
    Item(
      'Billing inquiry',
      'Description for billing inquiry',
    ),
    Item(
      'General question',
      'Description for general question',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Contact Us'),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.grey),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Submit a request',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'What can we help you with?',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 24.0),
            Container(
              color: Colors.white,
              child: ListView(
                shrinkWrap: true,
                children: _issueTypes.map<Widget>((Item item) {
                  return Container(
                    color: Colors.white,
                    child: ExpansionPanelList(
                      elevation: 1,
                      expandedHeaderPadding: EdgeInsets.zero,
                      expansionCallback: (int index, bool isExpanded) {
                        setState(() {
                          _selectedIssueType = isExpanded ? item.title : null;
                        });
                      },
                      children: [
                        ExpansionPanel(
                          backgroundColor: AppColor.white,
                          headerBuilder:
                              (BuildContext context, bool isExpanded) {
                            return ListTile(
                              title: Text(
                                item.title,
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black,
                                ),
                              ),
                            );
                          },
                          body: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 16.0,
                              horizontal: 16.0,
                            ),
                            child: Text(
                              item.description,
                              style: const TextStyle(
                                fontSize: 14.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          isExpanded: _selectedIssueType == item.title,
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                // Handle form submission here
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

class Item {
  Item(this.title, this.description);

  String title;
  String description;
}
