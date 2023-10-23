import 'package:flutter/material.dart';
import '../../../pages/aboutus/about_us_page.dart';
import '../../../pages/contactus/contact_us_page.dart';
import '../../../common/app_colors.dart';
import '../../../common/app_responsive.dart';
import '../../../controllers/menu_controller.dart';
import 'package:provider/provider.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({super.key});

  @override
  _HeaderWidgetState createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Row(
        children: [
          if (!AppResponsive.isDesktop(context))
            IconButton(
              icon: Icon(
                Icons.menu,
                color: AppColor.black,
              ),
              onPressed: Provider.of<MenuControllers>(context, listen: false)
                  .controlMenu,
            ),
          const Text(
            "Dashboard",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (!AppResponsive.isMobile(context)) ...{
            const Spacer(),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: handleNotificationIconClick,
                  child: navigationIcon(icon: Icons.notifications_none_rounded),
                ),
                GestureDetector(
                  onTap: handlePersonIconClick,
                  child: navigationIcon(icon: Icons.person),
                ),
                GestureDetector(
                  onTap: handleNavigationImageClick,
                  child: navigationImage(imagePath: 'assets/user1.jpg'),
                ),
              ],
            )
          }
        ],
      ),
    );
  }

  Widget navigationIcon({required IconData icon}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Icon(
        icon,
        color: AppColor.black,
      ),
    );
  }

  Widget navigationImage({required String imagePath}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipOval(
        child: Image.asset(
          imagePath,
          width: 24,
          height: 24,
        ),
      ),
    );
  }

  void handleNotificationIconClick() {
    // Handle the click event for the notification icon
    // Add your custom logic here
  }

  void handlePersonIconClick() {
    // Handle the click event for the person icon
    // Add your custom logic here
  }

  void handleNavigationImageClick() {
    // Handle the click event for the navigation image
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final screenWidth = MediaQuery.of(context).size.width;
        final dialogWidth =
            screenWidth * 0.3; // Adjust the width percentage as desired

        return Align(
          alignment: Alignment.topRight,
          child: Container(
            width: dialogWidth,
            margin: const EdgeInsets.only(top: 20, right: 20),
            child: Card(
              color: Colors.white, // Set the background color to white
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: const Icon(Icons.person_outline),
                    title: const Text('Profile',
                        style: TextStyle(
                            color:
                                Colors.black)), // Set the font color to black
                    onTap: () {
                      // Handle the click event for the profile option
                      // Add your custom logic here
                      Navigator.of(context).pop(); // Close the dialog
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.work_outline),
                    title: const Text('Training',
                        style: TextStyle(
                            color:
                                Colors.black)), // Set the font color to black
                    onTap: () {
                      // Handle the click event for the profile option
                      // Add your custom logic here
                      Navigator.of(context).pop(); // Close the dialog
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings_outlined),
                    title: const Text('Settings',
                        style: TextStyle(
                            color:
                                Colors.black)), // Set the font color to black
                    onTap: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.info_outline),
                    title: const Text('About Us',
                        style: TextStyle(
                            color:
                                Colors.black)), // Set the font color to black
                    onTap: () {
                      Navigator.of(context).pop(); // Close the dialog
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AboutUsPage()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.info_outline),
                    title: const Text('Contact Us',
                        style: TextStyle(
                            color:
                                Colors.black)), // Set the font color to black
                    onTap: () {
                      Navigator.of(context).pop(); // Close the dialog
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ContactUsPage()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout_outlined),
                    title: const Text('Logout',
                        style: TextStyle(
                            color:
                                Colors.black)), // Set the font color to black
                    onTap: () {
                      // Perform logout action
                      // Add your custom logic here
                      Navigator.of(context).pop(); // Close the dialog
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
