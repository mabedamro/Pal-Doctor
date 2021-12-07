import 'package:desktop_version/models/user.dart';
import 'package:desktop_version/provider/userProvider.dart';
import 'package:desktop_version/screen/datesScreen.dart';
import 'package:desktop_version/screen/employeeScreen.dart';
import 'package:desktop_version/screen/finScreen.dart';
import 'package:desktop_version/screen/patientScreen.dart';
import 'package:desktop_version/screen/settingsScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class TabBarCustome extends StatefulWidget {
  @override
  _TabBarCustomeState createState() => _TabBarCustomeState();
}

class _TabBarCustomeState extends State<TabBarCustome>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
    List<Tab> tabsNames = [];

    List<Widget> tabs = [];
  @override
  void initState() {
    print('1');
    getTabs();

    print('2');
    getTabsNames();

    print('3');
    _tabController = TabController(length: tabs.length, vsync: this);

    print('4');
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
                      tabs: tabsNames,
                    ),
                  ),
                ],
              ),
              // tab bar view here
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: tabs,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void getTabsNames() {
    User user = Provider.of<UserProvier>(context,listen: false).user;
  

    if (user.permission[0] == '1') {
      tabsNames.add(
        Tab(
          text: 'Patient',
        ),
      );
    }
    if (user.permission[1] == '1') {
      tabsNames.add(
        Tab(
          text: 'Employees',
        ),
      );
    }
    if (user.permission[2] == '1') {
      tabsNames.add(
        Tab(
          text: 'Dates',
        ),
      );
    }
    if (user.permission[3] == '1') {
      tabsNames.add(
        Tab(
          text: 'Financial',
        ),
      );
    }
    tabsNames.add(Tab(
      text: 'Settings',
    ));
  }

  void getTabs() {
    User user = Provider.of<UserProvier>(context,listen: false).user;
    if (user.permission[0] == '1') {
      tabs.add(
        PatientScreen(),
      );
    }
    if (user.permission[1] == '1') {
      tabs.add(
        EmployeeScreen(),
      );
    }
    if (user.permission[2] == '1') {
      tabs.add(
        DatesScreen(),
      );
    }
    if (user.permission[3] == '1') {
      tabs.add(
        FinScreen(),
      );
    }
    tabs.add(
      SettingsScreen(),
    );
  }
}
