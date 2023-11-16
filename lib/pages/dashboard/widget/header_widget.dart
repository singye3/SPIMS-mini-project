import 'package:flutter/material.dart';
import 'package:spims/common/app_font_size.dart';
import 'package:spims/pages/notification/notification_page.dart';
import 'package:spims/pages/profile/profilewidget.dart';
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
      decoration: const BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.all(Radius.circular(100))),
      padding: const EdgeInsets.only(left: 20),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          if (!AppResponsive.isDesktop(context))
            IconButton(
              icon: const Icon(
                Icons.menu,
                color: AppColor.black,
              ),
              onPressed: Provider.of<MenuControllers>(context, listen: false)
                  .controlMenu,
            ),
          Text(
            "Dashboard",
            style: TextStyle(
                fontSize: FontSize.header_1(context),
                fontWeight: FontWeight.bold,
                color: AppColor.black),
          ),
          if (!AppResponsive.isMobile(context)) ...{
            const Spacer(),
            Container(
              decoration: const BoxDecoration(
                  color: AppColor.primary,
                  borderRadius: BorderRadius.all(Radius.circular(100))),
              margin:
                  const EdgeInsets.only(left: 12, top: 4, bottom: 4, right: 4),
              padding: const EdgeInsets.only(left: 22),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const NotificationPage()),
                      );
                    },
                    child: const Icon(
                      Icons.notifications_outlined,
                      color: AppColor.white,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfileWidget()),
                      );
                    },
                    child: navigationImage(imagePath: 'assets/user1.jpg'),
                  ),
                ],
              ),
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
          width: 34,
          height: 34,
        ),
      ),
    );
  }
}
