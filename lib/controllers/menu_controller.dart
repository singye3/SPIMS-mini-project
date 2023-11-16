import 'package:flutter/material.dart';

class MenuControllers extends ChangeNotifier {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  String _selectedMenuItem = "Dashboard"; // Default selected menu item

  GlobalKey<ScaffoldState> get scaffoldKey => _globalKey;

  String get selectedMenuItem =>
      _selectedMenuItem; // Getter for selected menu item

  void selectMenuItem(String menuItem) {
    _selectedMenuItem = menuItem;
    notifyListeners();
  }

  void controlMenu() {
    if (!_globalKey.currentState!.isDrawerOpen) {
      _globalKey.currentState!.openDrawer();
    }
  }
}
