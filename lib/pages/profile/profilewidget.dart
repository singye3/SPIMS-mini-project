import 'package:flutter/material.dart';
import 'package:spims/common/app_font_size.dart';
import 'package:spims/common/app_responsive.dart';
import 'package:spims/pages/form/edit_from/edit_biodata.dart';
import 'package:spims/pages/form/edit_from/edit_dependent.dart';
import 'package:spims/pages/form/edit_from/edit_qualification.dart';
import 'package:spims/pages/form/edit_from/edit_training.dart';

import '../../common/app_colors.dart';
import 'profile_service.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({super.key});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  Map<String, dynamic>? biodata;
  List<dynamic>? qualifications;
  List<dynamic>? trainings;
  List<dynamic>? dependents;

  @override
  void initState() {
    super.initState();
    fetchProfileData();
  }

  Future<void> fetchProfileData() async {
    final profileData = await ProfileService.fetchProfileData();

    setState(() {
      biodata = profileData['biodata'];
      qualifications = profileData['qualifications'];
      trainings = profileData['trainings'];
      dependents = profileData['dependents'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            AppResponsive.isDesktop(context)
                ? _displayCard(biodata, 'Biodata')
                : _displayCardForDesktop(biodata, 'Biodata'),
            const Divider(),
            _displayListSection(qualifications, 'Qualifications'),
            const Divider(),
            _displayListSection(trainings, 'Trainings'),
            const Divider(),
            _displayListSection(dependents, 'Dependents'),
          ],
        ),
      ),
    );
  }

  Widget _displayListSection(List<dynamic>? data, String title) {
    if (data == null || data.isEmpty) {
      return Container();
    }

    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _capitalize(title),
              style: const TextStyle(
                color: AppColor.black,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: data.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final item = data[index];
                if (item is Map<String, dynamic>) {
                  if (title == 'Qualifications') {
                    return _buildQualificationExpansionTile(
                        item); // Call _buildExpansionTile for 'Qualification'
                  } else if (title == 'Dependents') {
                    return _buildDependentExpansionTile(
                        item); // Call _buildDependentExpansionTile for 'Dependent'
                  } else if (title == 'Trainings') {
                    return _buildTrainingExpansionTile(
                        item); // Call _buildTrainingExpansionTile for 'Training'
                  }
                } else if (item is String) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      _capitalize(item),
                      style: const TextStyle(
                        color: AppColor.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQualificationExpansionTile(Map<String, dynamic> data) {
    final String name = data['name'] as String;
    final String institutionName = data['institution_name'] as String;

    return Card(
      color: Colors.transparent,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      child: ExpansionTile(
        leading: const Icon(
          Icons.school_outlined,
          color: AppColor.grey,
        ),
        title: Text(
          _capitalize(name),
          style: TextStyle(
            color: AppColor.black,
            fontSize: FontSize.bodyFontSize(context),
          ),
        ),
        subtitle: Text(
          _capitalize(institutionName),
          style: const TextStyle(
            color: AppColor.grey,
            fontSize: 14.0,
          ),
        ),
        trailing: const Icon(
          Icons.expand_more,
          color: AppColor.grey,
        ),
        backgroundColor: Colors.white,
        collapsedTextColor: Colors.black,
        initiallyExpanded: false,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Column(
                  children: [
                    ...data.entries
                        .where((entry) =>
                            entry.key != 'name' &&
                            entry.key != 'institution_name')
                        .map((entry) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          '${_capitalize(entry.key)}: ${entry.value.toString()}',
                          style: const TextStyle(
                            color: AppColor.grey,
                            fontSize: 14.0,
                          ),
                        ),
                      );
                    }),
                  ],
                ),
                const Spacer(),
                IconButton(
                  tooltip: "Edit",
                  highlightColor: AppColor.accent,
                  icon: const Icon(
                    Icons.edit,
                    color: AppColor.black,
                  ),
                  onPressed: () {
                    _navigateToEditQualification(name, institutionName);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDependentExpansionTile(Map<String, dynamic> data) {
    final String name = data['name'] as String;
    final String type = data['type'] as String;

    return Card(
      color: Colors.transparent,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      child: ExpansionTile(
        leading: const Icon(
          Icons.family_restroom_outlined,
          color: AppColor.grey,
        ),
        title: Text(
          _capitalize(name),
          style: TextStyle(
            color: AppColor.black,
            fontSize: FontSize.bodyFontSize(context),
          ),
        ),
        subtitle: Text(
          _capitalize(type),
          style: const TextStyle(
            color: AppColor.grey,
            fontSize: 14.0,
          ),
        ),
        trailing: const Icon(
          Icons.expand_more,
          color: AppColor.grey,
        ),
        backgroundColor: Colors.white,
        collapsedTextColor: Colors.black,
        initiallyExpanded: false,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Spacer(),
                Column(
                  children: [
                    ...data.entries
                        .where((entry) =>
                            entry.key != 'name' && entry.key != 'type')
                        .map((entry) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          '${_capitalize(entry.key)}: ${entry.value.toString()}',
                          style: const TextStyle(
                            color: AppColor.grey,
                            fontSize: 14.0,
                          ),
                        ),
                      );
                    }),
                  ],
                ),
                const Spacer(),
                IconButton(
                  tooltip: "Edit",
                  highlightColor: AppColor.accent,
                  icon: const Icon(
                    Icons.edit,
                    color: AppColor.black,
                  ),
                  onPressed: () {
                    _navigateToEditDependent(name, data['cid']);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrainingExpansionTile(Map<String, dynamic> data) {
    final String name = data['name'] as String;
    final String institutionName = data['institution_name'] as String;

    return Card(
      color: Colors.transparent,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      child: ExpansionTile(
        leading: const Icon(
          Icons.work,
          color: AppColor.grey,
        ),
        title: Text(
          _capitalize(name),
          style: TextStyle(
            color: AppColor.black,
            fontSize: FontSize.bodyFontSize(context),
          ),
        ),
        subtitle: Text(
          _capitalize(institutionName),
          style: const TextStyle(
            color: AppColor.grey,
            fontSize: 14.0,
          ),
        ),
        trailing: const Icon(
          Icons.expand_more,
          color: AppColor.grey,
        ),
        backgroundColor: Colors.white,
        collapsedTextColor: Colors.black,
        initiallyExpanded: false,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Spacer(),
                Column(
                  children: [
                    ...data.entries
                        .where((entry) =>
                            entry.key != 'name' &&
                            entry.key != 'institution_name')
                        .map((entry) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          '${_capitalize(entry.key)}: ${entry.value.toString()}',
                          style: const TextStyle(
                            color: AppColor.grey,
                            fontSize: 14.0,
                          ),
                        ),
                      );
                    }),
                  ],
                ),
                const Spacer(),
                IconButton(
                  tooltip: "Edit",
                  highlightColor: AppColor.accent,
                  icon: const Icon(
                    Icons.edit,
                    color: AppColor.black,
                  ),
                  onPressed: () {
                    _navigateToEditTraining(name, institutionName);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _displayCard(Map<String, dynamic>? data, String title) {
    if (data == null) {
      return Container();
    }

    final List<MapEntry<String, dynamic>> entries = data.entries.toList();
    final int halfLength = entries.length ~/ 2;

    return Card(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(2000),
                  child: Image.asset(
                    "assets/user1.jpg",
                    width: 100,
                    height: 100,
                  ),
                ),
                IconButton(
                  tooltip: "Edit",
                  highlightColor: AppColor.accent,
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.grey,
                  ),
                  onPressed: _navigateToEditProfile,
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _buildEntries(entries.sublist(0, halfLength)),
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _buildEntries(entries.sublist(halfLength)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _displayCardForDesktop(Map<String, dynamic>? data, String title) {
    if (data == null) {
      return Container();
    }

    final List<MapEntry<String, dynamic>> entries = data.entries.toList();

    return Card(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(2000),
              child: Image.asset(
                "assets/user1.jpg",
                width: 100,
                height: 100,
              ),
            ),
            ListTile(
              trailing: IconButton(
                icon: const Icon(
                  Icons.edit,
                  color: Colors.grey,
                ),
                onPressed: _navigateToEditProfile,
              ),
            ),
            const SizedBox(height: 16.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _buildEntries(entries),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToEditProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const EditBiodata()),
    );
  }

  void _navigateToEditQualification(String name, String institution_name) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => EditQualification(
                q_name: name,
                institution_name: institution_name,
              )),
    );
  }

  void _navigateToEditDependent(String name, String cid) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => EditDependent(name: name, cid: cid)),
    );
  }

  void _navigateToEditTraining(String name, String institution_name) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => EditTraining(
                name: name,
                institution: institution_name,
              )),
    );
  }

  List<Widget> _buildEntries(List<MapEntry<String, dynamic>> entries) {
    return entries.map((entry) {
      Widget valueWidget;

      if (entry.value is Map<String, dynamic>) {
        // Handle nested maps (addresses)
        final Map<String, dynamic> address =
            entry.value as Map<String, dynamic>;
        final String formattedAddress =
            '${address['villagename']}, ${address['gewog']}, ${address['dzongkhag']}';
        valueWidget = Text(
          formattedAddress,
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: 14.0,
          ),
        );
      } else {
        // Handle other values
        valueWidget = Text(
          entry.value.toString(),
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: 14.0,
          ),
        );
      }

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                _capitalize(entry.key),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: FontSize.bodyFontSize(context),
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: valueWidget,
            ),
          ],
        ),
      );
    }).toList();
  }

  String _capitalize(String text) {
    final words = text.split(' ');
    final capitalizedWords = words.map((word) {
      return word[0].toUpperCase() + word.substring(1);
    });
    return capitalizedWords.join(' ');
  }
}
