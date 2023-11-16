import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:spims/common/app_responsive.dart';
import 'package:spims/common/app_font_size.dart';

import '../../common/app_colors.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  Future<String> _loadAsset(String path) async {
    return await rootBundle.loadString(path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: AppColor.grey,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          Center(
            child: FractionallySizedBox(
              widthFactor: AppResponsive.isMobile(context) ? 0.9 : 0.7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/cstlogo.png',
                    width: AppResponsive.isMobile(context) ? 120 : 200,
                    height: AppResponsive.isMobile(context) ? 120 : 200,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: _buildSection(
                      context,
                      'M I S S I O N',
                      'assets/data/system_mission.txt',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: _buildSection(
                      context,
                      'V I S I O N',
                      'assets/data/system_vision.txt',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, String assetPath) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColor.primary,
            fontSize: FontSize.header_3(context),
          ),
        ),
        const SizedBox(height: 8.0),
        FutureBuilder(
          future: _loadAsset(assetPath),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text(
                'Error loading $title',
                style: TextStyle(
                  color: AppColor.black,
                  fontSize: FontSize.bodyFontSize(context),
                ),
              );
            } else {
              return SelectableText(
                snapshot.data!,
                style: TextStyle(
                  color: AppColor.black,
                  fontSize: FontSize.bodyFontSize(context),
                  height: 1.5,
                ),
                textAlign: TextAlign.justify,
              );
            }
          },
        ),
      ],
    );
  }
}
