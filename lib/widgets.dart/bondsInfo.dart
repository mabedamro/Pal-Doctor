import 'dart:io';

import 'package:desktop_version/models/bond.dart';
import 'package:desktop_version/provider/bondsProvider.dart';
import 'package:desktop_version/provider/darkModeProvider.dart';
import 'package:desktop_version/provider/dateTimeProvider.dart';
import 'package:desktop_version/provider/userProvider.dart';
import 'package:desktop_version/screen/settingsScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BondInfo extends StatefulWidget {
  Bond b;
  Function refresh;
  BondInfo(this.b,this.refresh);
  @override
  _BondInfoState createState() => _BondInfoState();
}

class _BondInfoState extends State<BondInfo> {
  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Provider.of<DarkModeProvider>(context, listen: false).isDark;
    bool isMobile = Platform.isIOS || Platform.isAndroid;
    var feildStyle = TextStyle(
      fontFamily: 'Cairo',
      fontWeight: FontWeight.bold,
      color: isDark ? Colors.white : Colors.black,
    );
    double width = MediaQuery.of(context).size.width;

    double height = MediaQuery.of(context).size.height;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AlertDialog(
        backgroundColor: isDark ? SettingsScreen.darkMode1 : Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Row(
                  children: [
                    new Text(
                      widget.b.type == 'increase' ? "سند قبض" : 'سند صرف',
                      style: TextStyle(
                          fontFamily: 'Cairo',
                          color: isDark ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: isMobile ? 20 : 25),
                    ),
                  ],
                ),
              ],
            ),
            IconButton(
                icon: Icon(
                  Icons.close,
                  color: isDark ? Colors.white : Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ],
        ),
        content: SizedBox(
          width: width / 2,
          height: 400,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "التاريخ:  ",
                        style: TextStyle(
                            fontFamily: 'Cairo',
                            color: isDark ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: isMobile ? 15 : 20),
                      ),
                      Text(
                        DateTimeProvider.dateAndTime(widget.b.date),
                        style: TextStyle(
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            fontSize: isMobile ? 15 : 20),
                      ),
                    ],
                  ),
                  widget.b.type == 'increase'
                      ? Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: TextFormField(
                            enabled: false,
                            style: feildStyle,
                            initialValue: widget.b.patName,
                            decoration: new InputDecoration(
                              prefixIcon: Icon(
                                Icons.account_circle,
                              ),
                              labelText: "إسم المريض",
                              labelStyle: TextStyle(
                                color: isDark ? Colors.white : Colors.black,
                                fontSize: isMobile ? 12 : 14,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(60.0),
                                // borderSide: BorderSide(color: color),
                              ),
                              //fillColor: Colors.green),
                            ),
                          ),
                        )
                      : widget.b.type == 'decrease emp'
                          ? Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: TextFormField(
                                enabled: false,
                                style: feildStyle,
                                initialValue: widget.b.empName,
                                decoration: new InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.account_circle,
                                  ),
                                  labelText: "إسم الموظف",
                                  labelStyle: TextStyle(
                                    fontSize: isMobile ? 12 : 14,
                                    color: isDark ? Colors.white : Colors.black,
                                  ),

                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(60.0),
                                    // borderSide: BorderSide(color: color),
                                  ),
                                  //fillColor: Colors.green),
                                ),
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 80,
                                  child: Text(
                                    'نوع الصرف',
                                    style: TextStyle(
                                        fontFamily: 'Cairo',
                                        fontSize: isMobile ? 12 : 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text(
                                  widget.b.description,
                                  style: TextStyle(
                                      fontFamily: 'Cairo',
                                      color: Colors.red,
                                      fontSize: isMobile ? 12 : 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: TextFormField(
                      style: feildStyle,
                      enabled: false,
                      initialValue: widget.b.amount.toString(),
                      cursorColor: Colors.blue,
                      decoration: new InputDecoration(
                        prefixIcon: Icon(
                          Icons.account_circle,
                        ),
                        labelText: "المبلغ",
                        labelStyle: TextStyle(
                          fontSize: isMobile ? 12 : 15,
                          color: isDark ? Colors.white : Colors.black,
                        ),
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
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: TextFormField(
                      style: feildStyle,
                      initialValue: widget.b.note,
                      cursorColor: Colors.blue,
                      enabled: false,
                      decoration: new InputDecoration(
                        prefixIcon: Icon(
                          Icons.account_circle,
                        ),
                        labelText: "ملاحظات",
                        labelStyle: TextStyle(
                          fontSize: isMobile ? 12 : 15,
                          color: isDark ? Colors.white : Colors.black,
                        ),
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
                            fontFamily: 'Cairo',
                            color: isDark ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: isMobile ? 15 : 20),
                      ),
                      Text(
                        widget.b.userName,
                        style: TextStyle(
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            fontSize: isMobile ? 15 : 20),
                      ),
                    ],
                  ),
                  Provider.of<UserProvier>(context, listen: false)
                              .user
                              .createdBy ==
                          'me'
                      ? Row(
                          children: [
                            Container(
                                width: 60,
                                height: 60,
                                child: IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (_) {
                                        return Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: AlertDialog(
                                            backgroundColor:
                                                Provider.of<DarkModeProvider>(
                                                            context,
                                                            listen: false)
                                                        .isDark
                                                    ? SettingsScreen.darkMode2
                                                    : Colors.white,
                                            title: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                new Text(
                                                  'هل تريد حذف هذا السند؟',
                                                  style: TextStyle(
                                                      color:
                                                          Provider.of<DarkModeProvider>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .isDark
                                                              ? Colors.white
                                                              : Colors.black,
                                                      fontFamily: 'Cairo',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize:
                                                          isMobile ? 15 : 25),
                                                ),
                                              ],
                                            ),
                                            content: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  height: 50,
                                                  width: isMobile ? 100 : 200,
                                                  child: ElevatedButton(
                                                    onPressed: () async {
                                                      await Provider.of<
                                                                  BondsProvider>(
                                                              context,
                                                              listen: false)
                                                          .deleteBond(
                                                              widget.b.id,
                                                              context);
                                                      widget.refresh();
                                                    },
                                                    child: Center(
                                                      child: Padding(
                                                        padding: isMobile
                                                            ? const EdgeInsets
                                                                .all(5.0)
                                                            : const EdgeInsets
                                                                .all(12.0),
                                                        child: Text(
                                                          'نعم',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  'Cairo',
                                                              fontSize: isMobile
                                                                  ? 12
                                                                  : 15),
                                                        ),
                                                      ),
                                                    ),
                                                    style: ButtonStyle(
                                                      shape: MaterialStateProperty
                                                          .all<
                                                              RoundedRectangleBorder>(
                                                        RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      50.0),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: isMobile ? 3 : 10,
                                                ),
                                                SizedBox(
                                                  height: 50,
                                                  width: isMobile ? 100 : 200,
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Center(
                                                      child: Padding(
                                                        padding: isMobile
                                                            ? const EdgeInsets
                                                                .all(5.0)
                                                            : const EdgeInsets
                                                                .all(12.0),
                                                        child: Text(
                                                          'لا',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  'Cairo',
                                                              fontSize: isMobile
                                                                  ? 12
                                                                  : 15),
                                                        ),
                                                      ),
                                                    ),
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(Colors.grey),
                                                      shape: MaterialStateProperty
                                                          .all<
                                                              RoundedRectangleBorder>(
                                                        RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      50.0),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    size: 30,
                                    color: Colors.red,
                                  ),
                                )),
                          ],
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String trim(String s) {
    s = s.trim();
    if (s == '') {
      return s;
    } else {
      String temp = '';
      for (var i = 0; i < s.length; i++) {
        if (s[i].codeUnitAt(0) != 32 && s[i].codeUnitAt(0) != 8207) {
          temp += s[i];
          for (var j = i + 1; j < s.length; j++) {
            temp += s[j];
          }
          break;
        }
      }
      debugPrint(temp);
      String temp2 = '';
      for (var i = temp.length - 1; i >= 0; i--) {
        if (temp[i].codeUnitAt(0) != 32 && temp[i].codeUnitAt(0) != 8207) {
          temp2 += temp[i];
          for (var j = i - 1; j >= 0; j--) {
            temp2 += temp[j];
          }
          break;
        }
      }
      String result = '';
      for (var i = temp2.length - 1; i >= 0; i--) {
        result += temp2[i];
      }

      debugPrint(result);
      debugPrint(temp.length.toString());

      return result;
    }
  }
}
