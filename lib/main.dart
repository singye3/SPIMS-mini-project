import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spims/common/app_colors.dart';
import 'package:spims/pages/login/login.dart';
import 'package:spims/controllers/menu_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MenuControllers()),
      ],
      child: MaterialApp(
        title: 'Staff P I M S ',
        debugShowCheckedModeBanner: false,
        theme: AppColor.darkTheme,
        home: Login(),
      ),
    );
  }
}
