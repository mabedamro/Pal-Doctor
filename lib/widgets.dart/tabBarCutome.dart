import 'dart:io';

import 'package:desktop_version/models/user.dart';
import 'package:desktop_version/provider/darkModeProvider.dart';
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
    debugPrint('1');
    getTabs();

    debugPrint('2');
    getTabsNames();

    debugPrint('3');
    _tabController = TabController(length: tabs.length, vsync: this);

    debugPrint('4');
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = Platform.isAndroid || Platform.isIOS;
    double width = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Flexible(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: isMobile ? 18 : 0,
                ),
                // give the tab bar a height [can change hheight to preferred height]
                Row(
                  children: [
                    isMobile
                        ? Container()
                        : SvgPicture.asset(
                            Provider.of<DarkModeProvider>(context,
                                        listen: false)
                                    .isDark
                                ? 'assets/images/drawingDark.svg'
                                : 'assets/images/drawing.svg',
                            width: 150,
                          ),
                    isMobile
                        ? Container()
                        : SizedBox(
                            width: 20,
                          ),
                    Container(
                      width: isMobile ? width - 20 : 800,
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
      ),
    );
  }

  void getTabsNames() {
    User user = Provider.of<UserProvier>(context, listen: false).user;
    bool isMobile = Platform.isAndroid || Platform.isIOS;
    if (user.permission[0] == '1') {
      tabsNames.add(
        Tab(
          child: isMobile
              ? Icon(Icons.accessible_outlined)
              : Text(
                  'سجل المرضى',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.bold,
                  ),
                ),
          // text: 'المرضى',
        ),
      );
    }
    if (user.permission[2] == '1') {
      tabsNames.add(
        Tab(
          child: isMobile
              ? Icon(Icons.calendar_today)
              : Text(
                  'المواعيد',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      );
    }
    if (user.permission[1] == '1') {
      tabsNames.add(
        Tab(
          child: isMobile
              ? Icon(Icons.person)
              : Text(
                  'سجل الموظفين',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      );
    }
    if (user.permission[3] == '1') {
      tabsNames.add(
        Tab(
          child: isMobile
              ? Icon(Icons.attach_money_outlined)
              : Text(
                  'السجل المالي',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      );
    }
    tabsNames.add(Tab(
      child: isMobile
          ? Icon(Icons.settings)
          : Text(
              'الإعدادات',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontWeight: FontWeight.bold,
              ),
            ),
    ));
  }

  void getTabs() {
    User user = Provider.of<UserProvier>(context, listen: false).user;
    if (user.permission[0] == '1') {
      tabs.add(
        PatientScreen(),
      );
    }
    if (user.permission[2] == '1') {
      tabs.add(
        DatesScreen(),
      );
    }
    if (user.permission[1] == '1') {
      tabs.add(
        EmployeeScreen(),
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
