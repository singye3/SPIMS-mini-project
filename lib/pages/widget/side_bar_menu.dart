import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spims/pages/aboutus/about_us_page.dart';
import 'package:spims/pages/contactus/contact_us_page.dart';
import 'package:spims/pages/home_page.dart';
import 'package:spims/pages/login/login.dart';
import 'package:spims/pages/profile/profilewidget.dart';
import 'package:spims/pages/setting/setting_page.dart';
import 'package:spims/pages/training/training_page.dart';
import '../../common/app_colors.dart';
import '../../common/app_responsive.dart';

class SideBar extends StatefulWidget {
  const SideBar({Key? key});

  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      // elevation: 0,
      child: Container(
        decoration: const BoxDecoration(color: AppColor.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (AppResponsive.isMobile(context))
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 80),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfileWidget(),
                      ),
                    );
                  },
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Flexible(
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: AssetImage("assets/user1.jpg"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            Visibility(
              visible: !AppResponsive.isMobile(context),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      child: Image.asset(
                        "assets/cstlogo.png",
                        height: 60,
                        width: 60,
                      ),
                    ),
                  ),
                  const Text(
                    "S P I M S",
                    style: TextStyle(
                      color: AppColor.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            DrawerListTile(
              title: "Dashboard",
              icon: Icons.home_outlined,
              press: () {
                if (AppResponsive.isMobile(context)) {
                  Navigator.pop(context);
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                );
              },
            ),
            DrawerListTile(
              title: "Training",
              icon: Icons.work_outline,
              press: () {
                if (AppResponsive.isMobile(context)) {
                  Navigator.pop(context);
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TrainingPage(),
                  ),
                );
              },
            ),
            DrawerListTile(
              title: "Settings",
              icon: Icons.settings,
              press: () {
                if (AppResponsive.isMobile(context)) {
                  Navigator.pop(context);
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingPage(),
                  ),
                );
              },
            ),
            DrawerListTile(
              title: "About Us",
              icon: Icons.info_outline,
              press: () {
                if (AppResponsive.isMobile(context)) {
                  Navigator.pop(context);
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AboutUsPage(),
                  ),
                );
              },
            ),
            DrawerListTile(
              title: "Contact Us",
              icon: Icons.info_outline,
              press: () {
                if (AppResponsive.isMobile(context)) {
                  Navigator.pop(context);
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ContactUsPage(),
                  ),
                );
              },
            ),
            DrawerListTile(
              title: "Log Out",
              icon: Icons.logout_outlined,
              press: () {
                if (AppResponsive.isMobile(context)) {
                  Navigator.pop(context);
                }
                showDialog(
                  context: context,
                  builder: (context) => _LogoutAlert(),
                );
              },
            ),
            const Spacer(),
            if (AppResponsive.isDesktop(context))
              Image.asset("assets/sidebar_image.png"),
          ],
        ),
      ),
    );
  }
}

class _LogoutAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColor.background,
      title: const Text(
        'Confirm Logout',
        style: TextStyle(color: AppColor.black),
      ),
      actions: [
        TextButton(
          child: const Text(
            'Cancel',
            style: TextStyle(color: AppColor.black),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        TextButton(
          child: const Text(
            'Yes',
            style: TextStyle(color: AppColor.black),
          ),
          onPressed: () async {
            await _logout(context);

            // ignore: use_build_context_synchronously
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => Login()),
            );
          },
        ),
      ],
    );
  }

  _logout(context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => Login()),
      (route) => false, // Remove all the routes from the stack
    );
  }
}

class DrawerListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback press;

  const DrawerListTile({
    super.key,
    required this.title,
    required this.icon,
    required this.press,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      title: Row(
        children: [
          Icon(
            icon,
            color: AppColor.black,
            size: 24,
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: const TextStyle(color: AppColor.black),
          ),
        ],
      ),
    );
  }
}
