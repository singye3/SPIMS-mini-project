import 'package:flutter/material.dart';
import '../../../pages/form/widget/dependent_widget.dart';
import '../../../common/image_widget.dart';
import '../../../pages/form/widget/qualification_widget.dart';
import '../../../pages/form/widget/staff_biodata_widget.dart';
import '../../../common/app_responsive.dart';

class MoreInfoScreenWidget extends StatefulWidget {
  @override
  _MoreInfoScreenWidgetState createState() => _MoreInfoScreenWidgetState();
}

class _MoreInfoScreenWidgetState extends State<MoreInfoScreenWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('More Info'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: AppResponsive.isMobile(context)
                ? EdgeInsets.zero
                : const EdgeInsets.symmetric(horizontal: 40),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(right: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            tooltip: "Save changes",
                            icon: const Icon(Icons.save),
                            onPressed: () {},
                          ),
                          IconButton(
                            tooltip: "Discard changes",
                            icon: const Icon(Icons.delete),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                ImageWidget(),
                const SizedBox(height: 20),
                StaffBioDataWidget(),
                const SizedBox(height: 20),
                TabBar(
                  controller: _tabController,
                  tabs: const [
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.school, size: 20),
                          SizedBox(width: 8),
                          Flexible(
                            // or Expanded
                            child: Text(
                              'Staff Qualification',
                              style: TextStyle(fontSize: 16),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.people, size: 20),
                          SizedBox(width: 8),
                          Flexible(
                            // or Expanded
                            child: Text(
                              'Dependent Details',
                              style: TextStyle(fontSize: 16),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height -
                      400, // Adjust the value as needed
                  child: TabBarView(
                    controller: _tabController,
                    children: const [
                      QualificationWidget(),
                      DependentWidget(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
