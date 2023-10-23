import 'package:flutter/material.dart';
import '../../common/link_launcher.dart';
import 'dev_helper.dart';
import 'developer.dart';
import '../../common/app_responsive.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
      ),
      backgroundColor: Colors.white,
      body: AppResponsive.isMobile(context)
          ? _buildMobileLayout(context)
          : _buildDesktopLayout(context),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return FutureBuilder<List<Developer>>(
      future: readDevelopersFromJson(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData ||
            snapshot.data == null ||
            snapshot.data!.isEmpty) {
          return const Center(child: Text('No data available.'));
        } else {
          final developers = snapshot.data!;
          return ListView.builder(
            itemCount: developers.length,
            itemBuilder: (context, index) {
              final developer = developers[index];
              return InkWell(
                onTap: () => showDeveloperDetails(context, developer),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(developer.image),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        developer.name,
                        style: const TextStyle(color: Colors.black),
                      ),
                      const SizedBox(height: 5),
                      InkWell(
                        onTap: () => sendEmail(developer.email),
                        child: Text(
                          developer.email,
                          style: const TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => callPhone(developer.phone),
                        child: Text(
                          developer.phone,
                          style: const TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return FutureBuilder<List<Developer>>(
      future: readDevelopersFromJson(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData ||
            snapshot.data == null ||
            snapshot.data!.isEmpty) {
          return const Center(child: Text('No data available.'));
        } else {
          final developers = snapshot.data!;
          return Center(
            child: Container(
              width: 400,
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const Text(
                    'Developers',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    // Add Expanded widget
                    child: GridView.extent(
                      maxCrossAxisExtent: 200,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      children: developers.map((developer) {
                        return InkWell(
                          onTap: () => showDeveloperDetails(context, developer),
                          child: Container(
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundImage: AssetImage(developer.image),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  developer.name,
                                  style: const TextStyle(color: Colors.black),
                                ),
                                const SizedBox(height: 5),
                                InkWell(
                                  onTap: () => sendEmail(developer.email),
                                  child: Text(
                                    developer.email,
                                    style: const TextStyle(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () => callPhone(developer.phone),
                                  child: Text(
                                    developer.phone,
                                    style: const TextStyle(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
