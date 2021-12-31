import 'dart:io';

import 'package:desktop_version/models/bond.dart';
import 'package:desktop_version/models/patDate.dart';
import 'package:desktop_version/models/patient.dart';
import 'package:desktop_version/models/user.dart';
import 'package:desktop_version/provider/bondsProvider.dart';
import 'package:desktop_version/provider/darkModeProvider.dart';
import 'package:desktop_version/provider/dateTimeProvider.dart';
import 'package:desktop_version/provider/patDatesProvider.dart';
import 'package:desktop_version/provider/userProvider.dart';
import 'package:desktop_version/screen/employeeScreen.dart';
import 'package:desktop_version/screen/patientScreen.dart';
import 'package:desktop_version/screen/settingsScreen.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShowPatDateDialog extends StatefulWidget {
  PatDate date;
  ShowPatDateDialog(this.date);
  @override
  _ShowPatDateDialogState createState() => _ShowPatDateDialogState();
}

class _ShowPatDateDialogState extends State<ShowPatDateDialog> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    PatDate selectedDate = widget.date;
    double width = MediaQuery.of(context).size.width;

    bool isMobile = Platform.isAndroid || Platform.isIOS;
    var feildStyle = TextStyle(
        fontFamily: 'Cairo',
        fontWeight: FontWeight.bold,
        color: Provider.of<DarkModeProvider>(context, listen: false).isDark
            ? Colors.white
            : Colors.black);
    double height = MediaQuery.of(context).size.height;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AlertDialog(
        backgroundColor:
            Provider.of<DarkModeProvider>(context, listen: false).isDark
                ? SettingsScreen.darkMode1
                : Colors.white,
        content: SizedBox(
            width: width / 1.5,
            height: isMobile ? 250 : 300,
            child: Container(
              // color: Colors.red,
              child: Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Row(
                              children: [
                                Text(
                                  selectedDate == null
                                      ? 'التاريخ:                          '
                                      : 'التاريخ: ${DateTimeProvider.date(selectedDate.date)}      ',
                                  style: TextStyle(
                                      color: Provider.of<DarkModeProvider>(
                                                  context,
                                                  listen: false)
                                              .isDark
                                          ? Colors.white
                                          : Colors.black,
                                      fontFamily: 'Cairo',
                                      fontWeight: FontWeight.bold,
                                      fontSize: isMobile ? 12 : 25),
                                ),
                                Text(
                                  selectedDate == null
                                      ? 'الوقت:                 '
                                      : 'الوقت: ${DateTimeProvider.time(selectedDate.date)}',
                                  style: TextStyle(
                                      color: Provider.of<DarkModeProvider>(
                                                  context,
                                                  listen: false)
                                              .isDark
                                          ? Colors.white
                                          : Colors.black,
                                      fontFamily: 'Cairo',
                                      fontWeight: FontWeight.bold,
                                      fontSize: isMobile ? 12 : 25),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ]),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: TextFormField(
                      enabled: false,
                      style: feildStyle,
                      initialValue: widget.date.patName,
                      decoration: new InputDecoration(
                        prefixIcon: Icon(
                          Icons.account_circle,
                        ),
                        labelText: "إسم المريض",
                        labelStyle: feildStyle,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(60.0),
                          // borderSide: BorderSide(color: color),
                        ),
                        //fillColor: Colors.green),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: TextFormField(
                      enabled: false,
                      style: feildStyle,
                      cursorColor: Colors.blue,
                      initialValue:
                          selectedDate == null ? '' : selectedDate.note,
                      decoration: new InputDecoration(
                        prefixIcon: Icon(
                          Icons.account_circle,
                        ),
                        labelText: "ملاحظات",
                        labelStyle: feildStyle,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(60.0),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(60.0),
                          // borderSide: BorderSide(color: color),
                        ),
                        //fillColor: Colors.green),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "توقيع:  ",
                        style: TextStyle(
                            color: Provider.of<DarkModeProvider>(context,
                                        listen: false)
                                    .isDark
                                ? Colors.white
                                : Colors.black,
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.bold,
                            fontSize: isMobile ? 15 : 20),
                      ),
                      Text(
                        selectedDate == null
                            ? '                        '
                            : selectedDate.userName,
                        style: TextStyle(
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            fontSize: isMobile ? 15 : 20),
                      ),
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
