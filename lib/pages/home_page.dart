import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../common/app_colors.dart';
import '../common/app_responsive.dart';
import '../controllers/menu_controller.dart';

import 'dashboard/dashboard.dart';
import 'widget/side_bar_menu.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideBar(),
      key: context
          .read<MenuControllers>()
          .scaffoldKey, // Use context.read to access MenuControllers
      backgroundColor: AppColor.background,
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (AppResponsive.isDesktop(context))
              const Expanded(
                flex: 1,
                child: SideBar(),
              ),
            const Expanded(
              flex: 5,
              child: Dashboard(),
            ),
          ],
        ),
      ),
    );
  }
}
