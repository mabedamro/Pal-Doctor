
import 'package:desktop_version/screen/datesScreen.dart';
import 'package:desktop_version/screen/employeeScreen.dart';
import 'package:desktop_version/screen/finScreen.dart';
import 'package:desktop_version/screen/patientScreen.dart';
import 'package:desktop_version/screen/settingsScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TabBarCustome extends StatefulWidget {
  @override
  _TabBarCustomeState createState() => _TabBarCustomeState();
}

class _TabBarCustomeState extends State<TabBarCustome>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 5, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // give the tab bar a height [can change hheight to preferred height]
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/images/drawing.svg',
                    width: 150,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 800,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(
                        25.0,
                      ),
                    ),
                    child: TabBar(
                      controller: _tabController,
                      // give the indicator a decoration (color and border radius)
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          25.0,
                        ),
                        color: Colors.blue,
                      ),
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.black,
                      tabs: [
                        // first tab [you can add an icon using the icon property]
                        Tab(
                          text: 'Patient',
                        ),

                        Tab(
                          text: 'Employees',
                        ),
                         Tab(
                          text: 'Dates',
                        ),
                          Tab(
                          text: 'Financial',
                        ),

                          Tab(
                          text: 'Settings',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // tab bar view here
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // first tab bar view widget
                    PatientScreen(),
                    

                    // second tab bar view widget
                   EmployeeScreen (),
                    DatesScreen(),
                    FinScreen(),
                   SettingsScreen(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
