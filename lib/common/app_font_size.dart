import 'package:flutter/material.dart';

import '../common/app_responsive.dart';

class FontSize {
  static double header_1(BuildContext context) {
    return AppResponsive.isMobile(context) ? 26.0 : 30.0;
  }

  static double header_2(BuildContext context) {
    return AppResponsive.isMobile(context) ? 22.0 : 26.0;
  }

  static double header_3(BuildContext context) {
    return AppResponsive.isMobile(context) ? 18.0 : 22.0;
  }

  static double header_4(BuildContext context) {
    return AppResponsive.isMobile(context) ? 14.0 : 18.0;
  }

  static double bodyFontSize(BuildContext context) {
    return AppResponsive.isMobile(context) ? 12.0 : 16.0;
  }
}
