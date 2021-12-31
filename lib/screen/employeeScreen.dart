import 'dart:io';

import 'package:desktop_version/models/user.dart';
import 'package:desktop_version/provider/darkModeProvider.dart';
import 'package:desktop_version/provider/employeesProvider.dart';
import 'package:desktop_version/provider/userProvider.dart';
import 'package:desktop_version/screen/addEmployee.dart';
import 'package:desktop_version/screen/employeeInformationScreen.dart';
import 'package:desktop_version/screen/settingsScreen.dart';
import 'package:desktop_version/widgets.dart/patinetInfoSideContainer.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmployeeScreen extends StatefulWidget {
  @override
  _EmployeeScreenState createState() => _EmployeeScreenState();
  static User selectedEmployee =
      User(name: '', email: '', pass: '', createdDate: '');

  static bool enableEditing = false;
}

class _EmployeeScreenState extends State<EmployeeScreen>
    with AutomaticKeepAliveClientMixin {
  bool showSideInfo = false;
  int counter = 0;
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initScreen();
  }

  Future<void> initScreen() async {
    await Provider.of<EmployeesProvider>(context, listen: false).getEmployee(
        Provider.of<UserProvier>(context, listen: false).user.clincId, context);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    bool isMobile = Platform.isAndroid || Platform.isIOS;
    TextEditingController searchController = TextEditingController();
    final tableHeadersStyle =
        TextStyle(color: Colors.blue, fontWeight: FontWeight.bold);
    return Consumer<DarkModeProvider>(builder: (_, darkModeProvider, child) {
      return Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: isMobile ? width - 42 : 400,
                              height: 50,
                              child: TextField(
                                controller: searchController,
                                onSubmitted: (val) {
                                  print('enter button');
                                  Provider.of<EmployeesProvider>(context,
                                          listen: false)
                                      .search(val);
                                },
                                onChanged: (val) {
                                  Provider.of<EmployeesProvider>(context,
                                          listen: false)
                                      .search(val);
                                },
                                style: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontWeight: FontWeight.bold,
                                    color: Provider.of<DarkModeProvider>(
                                                context,
                                                listen: false)
                                            .isDark
                                        ? Colors.white
                                        : Colors.black),
                                cursorColor: Colors.blue,
                                decoration: new InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: Provider.of<DarkModeProvider>(
                                                context,
                                                listen: false)
                                            .isDark
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                  labelStyle: TextStyle(
                                      fontFamily: 'Cairo',
                                      fontWeight: FontWeight.bold,
                                      color: Provider.of<DarkModeProvider>(
                                                  context,
                                                  listen: false)
                                              .isDark
                                          ? Colors.white
                                          : Colors.black),
                                  labelText: "بحث...",
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(50.0),
                                    borderSide: BorderSide(color: Colors.blue),
                                  ),

                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(50.0),
                                    // borderSide: BorderSide(color: color),
                                  ),
                                  //fillColor: Colors.green),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            isMobile
                                ? Container()
                                : ElevatedButton(
                                    onPressed: () {
                                      Provider.of<EmployeesProvider>(context,
                                              listen: false)
                                          .search(searchController.text);
                                    },
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Row(
                                          children: [
                                            Icon(Icons.search),
                                            Text(
                                              'بحث',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontFamily: 'Cairo',
                                                  fontSize: 15),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                        ),
                                      ),
                                    ),
                                  )
                          ],
                        ),
                        isMobile
                            ? Container()
                            : Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        EmployeeInfoSideContainer
                                            .setStateForAnimation(false);
                                        await Provider.of<EmployeesProvider>(
                                                context,
                                                listen: false)
                                            .getEmployee(
                                                Provider.of<UserProvier>(
                                                        context,
                                                        listen: false)
                                                    .user
                                                    .clincId,
                                                context);
                                        setState(() {
                                          isLoading = false;
                                        });
                                      },
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Row(
                                            children: [
                                              Icon(Icons.refresh),
                                              Text(
                                                'تحد يث',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontFamily: 'Cairo',
                                                    fontSize: 15),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.grey),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AddEmployee()),
                                        );
                                      },
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Row(
                                            children: [
                                              Icon(Icons.add),
                                              Text(
                                                'إضافة موظف',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontFamily: 'Cairo',
                                                    fontSize: 15),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                      ],
                    ),
                  ),
                ),
                !isMobile
                    ? Container()
                    : Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                onPressed: () async {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  EmployeeInfoSideContainer
                                      .setStateForAnimation(false);
                                  await Provider.of<EmployeesProvider>(context,
                                          listen: false)
                                      .getEmployee(
                                          Provider.of<UserProvier>(context,
                                                  listen: false)
                                              .user
                                              .clincId,
                                          context);
                                  setState(() {
                                    isLoading = false;
                                  });
                                },
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.refresh),
                                        Text(
                                          'تحد يث',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontFamily: 'Cairo',
                                              fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.grey),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => AddEmployee()),
                                  );
                                },
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Row(
                                      children: [
                                        Icon(Icons.add),
                                        Text(
                                          'إضافة موظف',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontFamily: 'Cairo',
                                              fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                DottedLine(
                  direction: Axis.horizontal,
                  lineLength: double.infinity,
                  lineThickness: 1.0,
                  dashLength: 4.0,
                  dashColor: Colors.blue,
                  dashRadius: 0.0,
                  dashGapLength: 4.0,
                  dashGapColor: Colors.transparent,
                  dashGapRadius: 0.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Center(
                            child: Text(
                              'الإسم',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontFamily: 'Cairo',
                                  fontSize: isMobile ? 12 : 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              'البريد الإلكتروني',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontFamily: 'Cairo',
                                  fontSize: isMobile ? 12 : 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              'الصلاحيات',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontFamily: 'Cairo',
                                  fontSize: isMobile ? 12 : 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                DottedLine(
                  direction: Axis.horizontal,
                  lineLength: double.infinity,
                  lineThickness: 1.0,
                  dashLength: 4.0,
                  dashColor: Colors.blue,
                  dashRadius: 0.0,
                  dashGapLength: 4.0,
                  dashGapColor: Colors.transparent,
                  dashGapRadius: 0.0,
                ),
                Expanded(
                  child: Container(
                    height: double.infinity,
                    child: Consumer<EmployeesProvider>(
                        builder: (_, empProvider, child) {
                      return isLoading
                          ? Center(
                              child: SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: CircularProgressIndicator()))
                          : empProvider.searchList.length == 0
                              ? Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.search,
                                        size: 60,
                                        color: Colors.blue,
                                      ),
                                      Text(
                                        'لا توجد بيانات لعرضها',
                                        style: TextStyle(
                                            color:
                                                Provider.of<DarkModeProvider>(
                                                            context,
                                                            listen: false)
                                                        .isDark
                                                    ? Colors.white
                                                    : Colors.black,
                                            fontFamily: 'Cairo',
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: empProvider.searchList.length,
                                  itemBuilder: (_, index) {
                                    return Card(
                                      color: Provider.of<DarkModeProvider>(
                                                  context,
                                                  listen: false)
                                              .isDark
                                          ? SettingsScreen.darkMode2
                                          : Colors.grey[100],
                                      child: InkWell(
                                        hoverColor:
                                            Provider.of<DarkModeProvider>(
                                                        context,
                                                        listen: false)
                                                    .isDark
                                                ? Colors.grey[700]
                                                : Colors.grey[300],
                                        onTap: () {
                                          if (isMobile) {
                                            EmployeeScreen.enableEditing =
                                                false;
                                            EmployeeScreen.selectedEmployee =
                                                empProvider.searchList[index];
                                            EmployeeInformationScreen
                                                    .permission =
                                                EmployeeScreen.selectedEmployee
                                                    .permission;
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      EmployeeInformationScreen()),
                                            );
                                          } else {
                                            EmployeeScreen.enableEditing =
                                                false;
                                            EmployeeScreen.selectedEmployee =
                                                empProvider.searchList[index];
                                            EmployeeInfoSideContainer
                                                    .permission =
                                                EmployeeScreen.selectedEmployee
                                                    .permission;
                                            EmployeeInfoSideContainer
                                                .setStateForAnimation(true);
                                          }
                                        },
                                        child: Container(
                                          height: isMobile ? 80 : 50,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Center(
                                                    child: Text(
                                                      empProvider
                                                          .searchList[index]
                                                          .name,
                                                      style: TextStyle(
                                                          fontFamily: 'Cairo',
                                                          fontSize: isMobile
                                                              ? 12
                                                              : 14,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Provider.of<
                                                                          DarkModeProvider>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .isDark
                                                              ? Colors.white
                                                              : Colors.black),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Center(
                                                    child: Text(
                                                      empProvider
                                                          .searchList[index]
                                                          .email,
                                                      style: TextStyle(
                                                          fontFamily: 'Cairo',
                                                          fontSize: isMobile
                                                              ? 12
                                                              : 14,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Provider.of<
                                                                          DarkModeProvider>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .isDark
                                                              ? Colors.white
                                                              : Colors.black),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Center(
                                                    child: Text(
                                                      empProvider
                                                          .searchList[index]
                                                          .permissionString,
                                                      style: TextStyle(
                                                          fontFamily: 'Cairo',
                                                          fontSize: isMobile
                                                              ? 12
                                                              : 14,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Provider.of<
                                                                          DarkModeProvider>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .isDark
                                                              ? Colors.white
                                                              : Colors.black),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                    }),
                  ),
                ),
              ],
            ),
          ),
          EmployeeScreen.selectedEmployee == null
              ? Container()
              : EmployeeInfoSideContainer(),
        ],
      );
    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
