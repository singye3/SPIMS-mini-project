import 'package:flutter/material.dart';

import '../../../common/app_colors.dart';
import '../../../common/app_responsive.dart';
import './more_info_screen_widget.dart';
import './show_detail_table.dart';

class StaffInfoCardWidget extends StatefulWidget {
  const StaffInfoCardWidget({super.key});

  @override
  _StaffInfoCardWidgetState createState() => _StaffInfoCardWidgetState();
}

class _StaffInfoCardWidgetState extends State<StaffInfoCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Staff Infomation",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColor.black,
                  fontSize: 22,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColor.yellow,
                  borderRadius: BorderRadius.circular(100),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ShowDetailTable()),
                    );
                  },
                  child: Text(
                    "Add Staff",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColor.black,
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColor.yellow,
                  borderRadius: BorderRadius.circular(100),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ShowDetailTable()),
                    );
                  },
                  child: Text(
                    "View All",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColor.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Divider(
            thickness: 0.5,
            color: Colors.grey,
          ),
          GridView.count(
            crossAxisCount: AppResponsive.isMobile(context) ? 2 : 5,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 1,
            padding: const EdgeInsets.only(top: 10),
            children: [
              gridItem(
                name: "Mary G Lolus",
                image: "assets/user1.jpg",
                designation: "Project Manager",
              ),
              gridItem(
                name: "Vince Jacob",
                image: "assets/user2.jpg",
                designation: "UI/UX Designer",
              ),
              gridItem(
                name: "Nell Brian",
                image: "assets/user3.jpg",
                designation: "React Developer",
              ),
              gridItem(
                name: "Vince Jacob",
                image: "assets/user2.jpg",
                designation: "UI/UX Designer",
              ),
              gridItem(
                name: "Mary G Lolus",
                image: "assets/user1.jpg",
                designation: "Project Manager",
              ),
              gridItem(
                name: "Vince Jacob",
                image: "assets/user2.jpg",
                designation: "UI/UX Designer",
              ),
              gridItem(
                name: "Nell Brian",
                image: "assets/user3.jpg",
                designation: "React Developer",
              ),
              gridItem(
                name: "Vince Jacob",
                image: "assets/user2.jpg",
                designation: "UI/UX Designer",
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Showing 4 out of 4 Results"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget gridItem({
    required String name,
    required String image,
    required String designation,
  }) {
    return GestureDetector(
      onTap: () {
        // Handle grid item tap
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MoreInfoScreenWidget(
                // name: name,
                // image: image,
                // designation: designation,
                ),
          ),
        );
      },
      child: Column(
        children: [
          Expanded(
            child: Card(
              color: Colors.grey[200],
              child: Column(
                children: [
                  SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(1000),
                    child: Image.asset(
                      image,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          designation,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
