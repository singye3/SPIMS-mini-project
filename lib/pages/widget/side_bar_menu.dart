import 'package:flutter/material.dart';
import 'package:spims/pages/aboutus/about_us_page.dart';
import 'package:spims/pages/contactus/contact_us_page.dart';
import '../../common/app_colors.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: Container(
        color: AppColor.bgSideMenu,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: Image.asset(
                  "assets/cstlogo.png",
                  height: 80,
                  width: 80,
                ),
              ),
            ),
            Text(
              "S P I M S",
              style: TextStyle(
                color: AppColor.yellow,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            DrawerListTile(
              title: "Dashboard",
              icon: Icons.home_outlined,
              press: () {},
            ),

            DrawerListTile(
              title: "Training",
              icon: Icons.work_outline,
              press: () {},
            ),
            DrawerListTile(
              title: "Settings",
              icon: Icons.settings,
              press: () {},
            ),
            DrawerListTile(
              title: "About Us",
              icon: Icons.info_outline,
              press: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AboutUsPage()));
              },
            ),
            DrawerListTile(
              title: "Contact Us",
              icon: Icons.info_outline,
              press: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ContactUsPage()));
              },
            ),
            DrawerListTile(
              title: "Log Out",
              icon: Icons.logout_outlined,
              press: () {},
            ),
            const Spacer(),
            Image.asset("assets/sidebar_image.png")
            // Image.asset(
            //   "assets/back.png",
            //   width: 200, // Set the desired width
            //   height: 200, // Set the desired height
            // ),
          ],
        ),
      ),
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
            color: AppColor.white,
            size: 24,
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: TextStyle(color: AppColor.white),
          ),
        ],
      ),
    );
  }
}
