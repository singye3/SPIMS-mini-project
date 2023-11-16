import 'package:flutter/material.dart';
import 'package:spims/common/app_font_size.dart';
import '../../../common/app_colors.dart';
import '../../notification/notification_page.dart';

class NotificationCardWidget extends StatelessWidget {
  const NotificationCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NotificationPage()),
        );
      },
      child: Container(
        decoration: BoxDecoration(
            color: AppColor.white, borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    style: TextStyle(
                        fontSize: FontSize.bodyFontSize(context),
                        color: AppColor.black),
                    children: const [
                      TextSpan(text: "Welcome "),
                      TextSpan(
                        text: "User One!",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Today you have 9 New Applications.\nAlso you need to hire 2 new UX Designers. 1\nReact Native Developer",
                  style: TextStyle(
                    fontSize: FontSize.bodyFontSize(context),
                    color: AppColor.black,
                    height: 1.5,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Read More",
                  style: TextStyle(
                      fontSize: FontSize.bodyFontSize(context),
                      color: AppColor.black,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline),
                )
              ],
            ),
            if (MediaQuery.of(context).size.width >= 620) ...{
              const Spacer(),
              Image.asset(
                "assets/notification_image.png",
                height: 160,
              )
            }
          ],
        ),
      ),
    );
  }
}
