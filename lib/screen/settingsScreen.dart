import 'dart:io';

import 'package:desktop_version/provider/darkModeProvider.dart';
import 'package:desktop_version/provider/userProvider.dart';
import 'package:desktop_version/screen/employeeScreen.dart';
import 'package:desktop_version/screen/finScreen.dart';
import 'package:desktop_version/screen/homeScreen.dart';
import 'package:desktop_version/screen/patientScreen.dart';
import 'package:desktop_version/widgets.dart/diagsUserDialog.dart';
import 'package:desktop_version/widgets.dart/logoutConfirm.dart';
import 'package:desktop_version/widgets.dart/testUserDialog.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  static Color darkMode1 = Colors.grey[850];

  static Color darkMode2 = Colors.grey[800];
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isTests = false, isDiags = false;
  @override
  Widget build(BuildContext context) {
    bool isMobile = Platform.isAndroid || Platform.isIOS;
    bool isClincAccount =
        Provider.of<UserProvier>(context, listen: false).clincUser.id ==
            Provider.of<UserProvier>(context, listen: false).user.id;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Consumer<DarkModeProvider>(builder: (_, darkModeProvider, child) {
      return SizedBox(
          width: width - 50,
          child: Row(children: [
            Expanded(
              child: Container(
                child: Column(
                  children: [
                    isMobile
                        ? Container(
                            decoration: BoxDecoration(
                                color: Provider.of<DarkModeProvider>(context,
                                            listen: false)
                                        .isDark
                                    ? SettingsScreen.darkMode2
                                    : Colors.grey[100],
                                borderRadius: BorderRadius.circular(15)),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Icon(
                                  Icons.person,
                                  size: isMobile ? 40 : 120,
                                  color: Colors.blue,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    initialValue: Provider.of<UserProvier>(
                                            context,
                                            listen: false)
                                        .user
                                        .name,
                                    enabled: false,
                                    onFieldSubmitted: (val) {
                                      // FocusScope.of(context).requestFocus(focus);
                                    },
                                    style: TextStyle(
                                      color: Provider.of<DarkModeProvider>(
                                                  context,
                                                  listen: false)
                                              .isDark
                                          ? Colors.white
                                          : Colors.black,
                                      fontFamily: 'Cairo',
                                      fontSize: isMobile ? 12 : 16,
                                    ),
                                    cursorColor: Colors.blue,
                                    decoration: new InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.person,
                                        color: Provider.of<DarkModeProvider>(
                                                    context,
                                                    listen: false)
                                                .isDark
                                            ? Colors.white
                                            : Colors.black,
                                        size: 20,
                                      ),
                                      labelStyle: TextStyle(
                                          color: Provider.of<DarkModeProvider>(
                                                      context,
                                                      listen: false)
                                                  .isDark
                                              ? Colors.white
                                              : Colors.black,
                                          fontFamily: 'Cairo',
                                          fontSize: isMobile ? 12 : 16,
                                          fontWeight: FontWeight.bold),
                                      labelText: "الإسم",
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(25.0),
                                        borderSide:
                                            BorderSide(color: Colors.blue),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(25.0),
                                        // borderSide: BorderSide(color: color),
                                      ),
                                      //fillColor: Colors.green),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    initialValue: Provider.of<UserProvier>(
                                            context,
                                            listen: false)
                                        .user
                                        .email,
                                    enabled: false,
                                    onFieldSubmitted: (val) {
                                      // FocusScope.of(context).requestFocus(focus);
                                    },
                                    style: TextStyle(
                                      color: Provider.of<DarkModeProvider>(
                                                  context,
                                                  listen: false)
                                              .isDark
                                          ? Colors.white
                                          : Colors.black,
                                      fontFamily: 'Cairo',
                                      fontSize: isMobile ? 12 : 16,
                                    ),
                                    cursorColor: Colors.blue,
                                    decoration: new InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.email,
                                        color: Provider.of<DarkModeProvider>(
                                                    context,
                                                    listen: false)
                                                .isDark
                                            ? Colors.white
                                            : Colors.black,
                                        size: 20,
                                      ),
                                      labelText: "البريد الألكتروني",
                                      labelStyle: TextStyle(
                                          color: Provider.of<DarkModeProvider>(
                                                      context,
                                                      listen: false)
                                                  .isDark
                                              ? Colors.white
                                              : Colors.black,
                                          fontFamily: 'Cairo',
                                          fontSize: isMobile ? 12 : 16,
                                          fontWeight: FontWeight.bold),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(25.0),
                                        borderSide:
                                            BorderSide(color: Colors.blue),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(25.0),
                                        // borderSide: BorderSide(color: color),
                                      ),
                                      //fillColor: Colors.green),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        'الصلاحيات: ',
                                        style: TextStyle(
                                            fontFamily: 'Cairo',
                                            fontSize: isMobile ? 12 : 15,
                                            color:
                                                Provider.of<DarkModeProvider>(
                                                            context,
                                                            listen: false)
                                                        .isDark
                                                    ? Colors.white
                                                    : Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Checkbox(
                                                  value:
                                                      Provider.of<UserProvier>(
                                                                  context,
                                                                  listen: false)
                                                              .user
                                                              .permission[0] ==
                                                          '1',
                                                  onChanged: (val) {}),
                                              Text(
                                                'الوصول لسجل المرضى',
                                                style: TextStyle(
                                                    fontFamily: 'Cairo',
                                                    fontSize:
                                                        isMobile ? 12 : 15,
                                                    color:
                                                        Provider.of<DarkModeProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .isDark
                                                            ? Colors.white
                                                            : Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Checkbox(
                                                  value:
                                                      Provider.of<UserProvier>(
                                                                  context,
                                                                  listen: false)
                                                              .user
                                                              .permission[1] ==
                                                          '1',
                                                  onChanged: (val) {}),
                                              Text(
                                                'الوصول الى سجل الموظفين',
                                                style: TextStyle(
                                                    fontFamily: 'Cairo',
                                                    fontSize:
                                                        isMobile ? 12 : 15,
                                                    color:
                                                        Provider.of<DarkModeProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .isDark
                                                            ? Colors.white
                                                            : Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Checkbox(
                                                  value:
                                                      Provider.of<UserProvier>(
                                                                  context,
                                                                  listen: false)
                                                              .user
                                                              .permission[2] ==
                                                          '1',
                                                  onChanged: (val) {}),
                                              Text(
                                                'الوصول الى المواعيد',
                                                style: TextStyle(
                                                    fontFamily: 'Cairo',
                                                    fontSize:
                                                        isMobile ? 12 : 15,
                                                    color:
                                                        Provider.of<DarkModeProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .isDark
                                                            ? Colors.white
                                                            : Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Checkbox(
                                                value: Provider.of<UserProvier>(
                                                            context,
                                                            listen: false)
                                                        .user
                                                        .permission[3] ==
                                                    '1',
                                                onChanged: (val) {},
                                              ),
                                              Text(
                                                'الوصول الى السجل المالي',
                                                style: TextStyle(
                                                    fontSize:
                                                        isMobile ? 12 : 15,
                                                    fontFamily: 'Cairo',
                                                    color:
                                                        Provider.of<DarkModeProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .isDark
                                                            ? Colors.white
                                                            : Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                // Row(
                                //   children: [
                                //     Padding(
                                //       padding: const EdgeInsets.all(8.0),
                                //       child: Text(
                                //                     'تشخيصات العيادة',
                                //                     style: TextStyle(
                                //                         fontFamily: 'Cairo',
                                //                         fontSize: 20,
                                //                         fontWeight: FontWeight.bold),
                                //                   ),
                                //     ),
                                //   ],
                                // ),
                                // DottedLine(
                                //   direction: Axis.horizontal,
                                //   lineLength: double.infinity,
                                //   lineThickness: 1.0,
                                //   dashLength: 4.0,
                                //   dashColor: Colors.blue,
                                //   dashRadius: 0.0,
                                //   dashGapLength: 4.0,
                                //   dashGapColor: Colors.transparent,
                                //   dashGapRadius: 0.0,
                                // ),

                                // SizedBox(
                                //   height: height - 200,
                                //   child:
                                //       Consumer<UserProvier>(builder: (_, userProvider, child) {
                                //     return ListView.builder(
                                //       itemCount: userProvider.clincUser.clincDiags.length,
                                //       itemBuilder: (_, index) {
                                //         return Card(
                                //           child: InkWell(
                                //             hoverColor: Colors.grey[300],
                                //             // // focusColor: Colors.red,
                                //             // overlayColor:
                                //             //     MaterialStateProperty.all(Colors.red),
                                //             // highlightColor: Colors.red,

                                //             onTap: () {},
                                //             child: Container(
                                //               height: 50,
                                //               child: Padding(
                                //                 padding: const EdgeInsets.all(8.0),
                                //                 child: Row(
                                //                   mainAxisAlignment:
                                //                       MainAxisAlignment.spaceBetween,
                                //                   children: [
                                //                     Expanded(
                                //                       child: Center(
                                //                         child: Text(
                                //                           userProvider
                                //                               .clincUser.clincDiags[index],
                                //                           style: TextStyle(
                                //                               fontFamily: 'Cairo',
                                //                               fontWeight: FontWeight.bold),
                                //                         )
                                //                       ),
                                //                     ),
                                //                   ],
                                //                 ),
                                //               ),
                                //             ),
                                //           ),
                                //         );
                                //       },
                                //     );
                                //   }),
                                // ),
                              ],
                            ),
                          )
                        : Container(),
                    Card(
                      color:
                          Provider.of<DarkModeProvider>(context, listen: false)
                                  .isDark
                              ? SettingsScreen.darkMode2
                              : Colors.grey[100],
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.brightness_2_rounded,
                                  color: Colors.blue,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'الوضع المظلم',
                                  style: TextStyle(
                                      color: Provider.of<DarkModeProvider>(
                                                  context,
                                                  listen: false)
                                              .isDark
                                          ? Colors.white
                                          : Colors.black,
                                      fontFamily: 'Cairo',
                                      fontSize: isMobile ? 13 : 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Switch(
                              value: Provider.of<DarkModeProvider>(context,
                                      listen: false)
                                  .isDark,
                              onChanged: (value) async {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                prefs.setBool(
                                    'isDark',
                                    Provider.of<DarkModeProvider>(context,
                                            listen: false)
                                        .isDark);
                                await Provider.of<DarkModeProvider>(context,
                                        listen: false)
                                    .changeDarkTo(value);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    isClincAccount
                        ? Card(
                            color: Provider.of<DarkModeProvider>(context,
                                        listen: false)
                                    .isDark
                                ? SettingsScreen.darkMode2
                                : Colors.grey[100],
                            child: InkWell(
                              hoverColor: Provider.of<DarkModeProvider>(context,
                                          listen: false)
                                      .isDark
                                  ? Colors.grey[700]
                                  : Colors.grey[300],
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (_) {
                                    return DiagsUserDialog();
                                  },
                                );
                              },
                              child: Container(
                                width: double.infinity,
                                height: 50,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      Icons.assignment,
                                      color: Colors.blue,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'عرض تشخيصات العيادة',
                                      style: TextStyle(
                                          color: Provider.of<DarkModeProvider>(
                                                      context,
                                                      listen: false)
                                                  .isDark
                                              ? Colors.white
                                              : Colors.black,
                                          fontFamily: 'Cairo',
                                          fontSize: isMobile ? 13 : 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Container(),
                    isClincAccount
                        ? Card(
                            color: Provider.of<DarkModeProvider>(context,
                                        listen: false)
                                    .isDark
                                ? SettingsScreen.darkMode2
                                : Colors.grey[100],
                            child: InkWell(
                              hoverColor: Provider.of<DarkModeProvider>(context,
                                          listen: false)
                                      .isDark
                                  ? Colors.grey[700]
                                  : Colors.grey[300],
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (_) {
                                    return TestsUserDialog();
                                  },
                                );
                              },
                              child: Container(
                                width: double.infinity,
                                height: 50,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      Icons.biotech_rounded,
                                      color: Colors.blue,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'عرض فحوصات العيادة',
                                      style: TextStyle(
                                          color: Provider.of<DarkModeProvider>(
                                                      context,
                                                      listen: false)
                                                  .isDark
                                              ? Colors.white
                                              : Colors.black,
                                          fontFamily: 'Cairo',
                                          fontSize: isMobile ? 13 : 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Container(),
                    Card(
                      color:
                          Provider.of<DarkModeProvider>(context, listen: false)
                                  .isDark
                              ? SettingsScreen.darkMode2
                              : Colors.grey[100],
                      child: InkWell(
                        hoverColor: Provider.of<DarkModeProvider>(context,
                                    listen: false)
                                .isDark
                            ? Colors.grey[700]
                            : Colors.grey[300],
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (_) {
                              return LogoutConfirmDialog();
                            },
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.logout,
                                color: Colors.blue,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'تسجيل الخروج',
                                style: TextStyle(
                                    color: Provider.of<DarkModeProvider>(
                                                context,
                                                listen: false)
                                            .isDark
                                        ? Colors.white
                                        : Colors.black,
                                    fontFamily: 'Cairo',
                                    fontSize: isMobile ? 13 : 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            isMobile
                ? Container()
                : Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Provider.of<DarkModeProvider>(context,
                                      listen: false)
                                  .isDark
                              ? SettingsScreen.darkMode2
                              : Colors.grey[100],
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Icon(
                            Icons.person,
                            size: 120,
                            color: Colors.blue,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              initialValue: Provider.of<UserProvier>(context,
                                      listen: false)
                                  .user
                                  .name,
                              enabled: false,
                              onFieldSubmitted: (val) {
                                // FocusScope.of(context).requestFocus(focus);
                              },
                              style: TextStyle(
                                color: Provider.of<DarkModeProvider>(context,
                                            listen: false)
                                        .isDark
                                    ? Colors.white
                                    : Colors.black,
                                fontFamily: 'Cairo',
                              ),
                              cursorColor: Colors.blue,
                              decoration: new InputDecoration(
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Provider.of<DarkModeProvider>(context,
                                              listen: false)
                                          .isDark
                                      ? Colors.white
                                      : Colors.black,
                                  size: 20,
                                ),
                                labelStyle: TextStyle(
                                    color: Provider.of<DarkModeProvider>(
                                                context,
                                                listen: false)
                                            .isDark
                                        ? Colors.white
                                        : Colors.black,
                                    fontFamily: 'Cairo',
                                    fontWeight: FontWeight.bold),
                                labelText: "الإسم",
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(25.0),
                                  borderSide: BorderSide(color: Colors.blue),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(25.0),
                                  // borderSide: BorderSide(color: color),
                                ),
                                //fillColor: Colors.green),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              initialValue: Provider.of<UserProvier>(context,
                                      listen: false)
                                  .user
                                  .email,
                              enabled: false,
                              onFieldSubmitted: (val) {
                                // FocusScope.of(context).requestFocus(focus);
                              },
                              style: TextStyle(
                                color: Provider.of<DarkModeProvider>(context,
                                            listen: false)
                                        .isDark
                                    ? Colors.white
                                    : Colors.black,
                                fontFamily: 'Cairo',
                              ),
                              cursorColor: Colors.blue,
                              decoration: new InputDecoration(
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Provider.of<DarkModeProvider>(context,
                                              listen: false)
                                          .isDark
                                      ? Colors.white
                                      : Colors.black,
                                  size: 20,
                                ),
                                labelText: "البريد الألكتروني",
                                labelStyle: TextStyle(
                                    color: Provider.of<DarkModeProvider>(
                                                context,
                                                listen: false)
                                            .isDark
                                        ? Colors.white
                                        : Colors.black,
                                    fontFamily: 'Cairo',
                                    fontWeight: FontWeight.bold),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(25.0),
                                  borderSide: BorderSide(color: Colors.blue),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(25.0),
                                  // borderSide: BorderSide(color: color),
                                ),
                                //fillColor: Colors.green),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text(
                                  'الصلاحيات: ',
                                  style: TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 15,
                                      color: Provider.of<DarkModeProvider>(
                                                  context,
                                                  listen: false)
                                              .isDark
                                          ? Colors.white
                                          : Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Checkbox(
                                            value: Provider.of<UserProvier>(
                                                        context,
                                                        listen: false)
                                                    .user
                                                    .permission[0] ==
                                                '1',
                                            onChanged: (val) {}),
                                        Text(
                                          'الوصول لسجل المرضى',
                                          style: TextStyle(
                                              fontFamily: 'Cairo',
                                              color:
                                                  Provider.of<DarkModeProvider>(
                                                              context,
                                                              listen: false)
                                                          .isDark
                                                      ? Colors.white
                                                      : Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Checkbox(
                                            value: Provider.of<UserProvier>(
                                                        context,
                                                        listen: false)
                                                    .user
                                                    .permission[1] ==
                                                '1',
                                            onChanged: (val) {}),
                                        Text(
                                          'الوصول الى سجل الموظفين',
                                          style: TextStyle(
                                              fontFamily: 'Cairo',
                                              color:
                                                  Provider.of<DarkModeProvider>(
                                                              context,
                                                              listen: false)
                                                          .isDark
                                                      ? Colors.white
                                                      : Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Checkbox(
                                            value: Provider.of<UserProvier>(
                                                        context,
                                                        listen: false)
                                                    .user
                                                    .permission[2] ==
                                                '1',
                                            onChanged: (val) {}),
                                        Text(
                                          'الوصول الى المواعيد',
                                          style: TextStyle(
                                              fontFamily: 'Cairo',
                                              color:
                                                  Provider.of<DarkModeProvider>(
                                                              context,
                                                              listen: false)
                                                          .isDark
                                                      ? Colors.white
                                                      : Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Checkbox(
                                          value: Provider.of<UserProvier>(
                                                      context,
                                                      listen: false)
                                                  .user
                                                  .permission[3] ==
                                              '1',
                                          onChanged: (val) {},
                                        ),
                                        Text(
                                          'الوصول الى السجل المالي',
                                          style: TextStyle(
                                              fontFamily: 'Cairo',
                                              color:
                                                  Provider.of<DarkModeProvider>(
                                                              context,
                                                              listen: false)
                                                          .isDark
                                                      ? Colors.white
                                                      : Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // Row(
                          //   children: [
                          //     Padding(
                          //       padding: const EdgeInsets.all(8.0),
                          //       child: Text(
                          //                     'تشخيصات العيادة',
                          //                     style: TextStyle(
                          //                         fontFamily: 'Cairo',
                          //                         fontSize: 20,
                          //                         fontWeight: FontWeight.bold),
                          //                   ),
                          //     ),
                          //   ],
                          // ),
                          // DottedLine(
                          //   direction: Axis.horizontal,
                          //   lineLength: double.infinity,
                          //   lineThickness: 1.0,
                          //   dashLength: 4.0,
                          //   dashColor: Colors.blue,
                          //   dashRadius: 0.0,
                          //   dashGapLength: 4.0,
                          //   dashGapColor: Colors.transparent,
                          //   dashGapRadius: 0.0,
                          // ),

                          // SizedBox(
                          //   height: height - 200,
                          //   child:
                          //       Consumer<UserProvier>(builder: (_, userProvider, child) {
                          //     return ListView.builder(
                          //       itemCount: userProvider.clincUser.clincDiags.length,
                          //       itemBuilder: (_, index) {
                          //         return Card(
                          //           child: InkWell(
                          //             hoverColor: Colors.grey[300],
                          //             // // focusColor: Colors.red,
                          //             // overlayColor:
                          //             //     MaterialStateProperty.all(Colors.red),
                          //             // highlightColor: Colors.red,

                          //             onTap: () {},
                          //             child: Container(
                          //               height: 50,
                          //               child: Padding(
                          //                 padding: const EdgeInsets.all(8.0),
                          //                 child: Row(
                          //                   mainAxisAlignment:
                          //                       MainAxisAlignment.spaceBetween,
                          //                   children: [
                          //                     Expanded(
                          //                       child: Center(
                          //                         child: Text(
                          //                           userProvider
                          //                               .clincUser.clincDiags[index],
                          //                           style: TextStyle(
                          //                               fontFamily: 'Cairo',
                          //                               fontWeight: FontWeight.bold),
                          //                         ),
                          //                       ),
                          //                     ),
                          //                   ],
                          //                 ),
                          //               ),
                          //             ),
                          //           ),
                          //         );
                          //       },
                          //     );
                          //   }),
                          // ),
                        ],
                      ),
                    ),
                  )
          ]));
    });
  }
}
