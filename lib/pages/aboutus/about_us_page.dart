import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class AboutUsPage extends StatelessWidget {
  Future<String> _loadAsset(String path) async {
    return await rootBundle.loadString(path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
      ),
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.8, // Adjust the width factor as per your preference
          child: Container(
            padding: const EdgeInsets.all(16.0),
            color:
                Colors.grey[200], // Set the background color of the Container
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/cstlogo.png',
                    width: 200.0,
                    height: 200.0,
                  ),
                  const SizedBox(height: 16.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SelectableText(
                            'M I S S I O N',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          FutureBuilder(
                            future:
                                _loadAsset('assets/data/system_mission.txt'),
                            builder: (BuildContext context,
                                AsyncSnapshot<String> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return const Text(
                                  'Error loading system mission',
                                  style: TextStyle(color: Colors.black),
                                );
                              } else {
                                return SelectableText(
                                  snapshot.data!,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    height: 1.5,
                                    fontSize: 16.0,
                                  ),
                                  textAlign: TextAlign.justify,
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SelectableText(
                            'V I S I O N',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          FutureBuilder(
                            future: _loadAsset('assets/data/system_vision.txt'),
                            builder: (BuildContext context,
                                AsyncSnapshot<String> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return const Text(
                                  'Error loading system vision',
                                  style: TextStyle(color: Colors.black),
                                );
                              } else {
                                return SelectableText(
                                  snapshot.data!,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    height: 1.5,
                                    fontSize: 16.0,
                                  ),
                                  textAlign: TextAlign.justify,
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24.0),
                ],
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white, // Set the background color of the Scaffold
    );
  }
}
