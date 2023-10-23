import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:staffpims/pages/dashboard/widget/more_info_screen_widget.dart';
import 'package:spims/pages/home_page.dart';

import './controllers/menu_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        // Use the default font family (typically "Roboto")
        textTheme: Theme.of(context).textTheme.copyWith(
            // Add more text styles here with the default font family.
            ),
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => MenuControllers()),
        ],
        // child: MoreInfoScreenWidget(),
        child: const HomePage(),
      ),
    );
  }
}
