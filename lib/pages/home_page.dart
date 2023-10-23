import 'package:flutter/material.dart';
import '../common/app_colors.dart';
import '../controllers/menu_controller.dart';
import 'package:provider/provider.dart';

import 'dashboard/dashboard.dart';
import 'widget/side_bar_menu.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBar(),
      key: Provider.of<MenuControllers>(context, listen: false).scaffoldKey,
      backgroundColor: AppColor.bgSideMenu,
      body: const SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // / Side Navigation Menu
            // / Only show in desktop
            // if (AppResponsive.isDesktop(context))
            //   Expanded(
            //     child: SideBar(),
            //   ),

            /// Main Body Part
            Expanded(
              // flex: 4,
              child: Dashboard(),
            ),
          ],
        ),
      ),
    );
  }
}
