import 'dart:io';

import 'package:desktop_version/provider/darkModeProvider.dart';
import 'package:desktop_version/provider/userProvider.dart';
import 'package:desktop_version/screen/settingsScreen.dart';
import 'package:desktop_version/widgets.dart/addBondDialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CaseDialog extends StatefulWidget {
  static TextEditingController noteController = TextEditingController();
  Function onPressed;
  CaseDialog({this.onPressed});
  static Function setState;
  static List<bool> clincDiagsBools = [];
  static List<bool> clincTestsBools = [];
  static bool isLoading = false;
  @override
  _CaseDialogState createState() => _CaseDialogState();
}

class _CaseDialogState extends State<CaseDialog> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 0;
        i <
            Provider.of<UserProvier>(context, listen: false)
                .clincUser
                .clincDiags
                .length;
        i++) {
      CaseDialog.clincDiagsBools.add(false);
    }
    for (int i = 0;
        i <
            Provider.of<UserProvier>(context, listen: false)
                .clincUser
                .clincTests
                .length;
        i++) {
      CaseDialog.clincTestsBools.add(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    CaseDialog.setState = setState;
    bool isMobile = Platform.isAndroid || Platform.isIOS;
    var feildStyle = TextStyle(
        fontFamily: 'Cairo',
        fontWeight: FontWeight.bold,
        fontSize: isMobile ? 12 : 16,
        color: Provider.of<DarkModeProvider>(context, listen: false).isDark
            ? Colors.white
            : Colors.black);
    double width = MediaQuery.of(context).size.width;

    double height = MediaQuery.of(context).size.height;
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Consumer<UserProvier>(
          builder: (_, userProvider, child) {
            return AlertDialog(
                backgroundColor:
                    Provider.of<DarkModeProvider>(context, listen: false).isDark
                        ? SettingsScreen.darkMode2
                        : Colors.white,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Row(
                          children: [
                            new Text(
                              "إضافة جلسة",
                              style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontWeight: FontWeight.bold,
                                  fontSize: isMobile ? 13 : 20,
                                  color: Provider.of<DarkModeProvider>(context,
                                              listen: false)
                                          .isDark
                                      ? Colors.white
                                      : Colors.black),
                            ),
                            SizedBox(
                              width: isMobile ? 5 : 10,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  for (int i = 0;
                                      i < CaseDialog.clincDiagsBools.length;
                                      i++) {
                                    CaseDialog.clincDiagsBools[i] = false;
                                  }
                                });
                              },
                              child: SizedBox(
                                width: isMobile ? 60 : 100,
                                child: Center(
                                  child: Text(
                                    'مسح الكل',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Cairo',
                                        fontSize: isMobile ? 11 : 15),
                                  ),
                                ),
                              ),
                              style: ButtonStyle(
                                elevation: MaterialStateProperty.all<double>(0),
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
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                        icon: Icon(Icons.close,
                            color: Provider.of<DarkModeProvider>(context,
                                        listen: false)
                                    .isDark
                                ? Colors.white
                                : Colors.black),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ],
                ),
                content: SizedBox(
                  width: width / 1.5,
                  height: height / 1.5,
                  child: Column(
                    children: [
                      Expanded(
                        child: GridView.builder(
                          itemCount: userProvider.clincUser.clincDiags.length,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                Checkbox(
                                    value: CaseDialog.clincDiagsBools[index],
                                    onChanged: (val) {
                                      setState(() {
                                        CaseDialog.clincDiagsBools[index] =
                                            !CaseDialog.clincDiagsBools[index];
                                      });
                                    }),
                                Text(
                                  userProvider.clincUser.clincDiags[index],
                                  style: TextStyle(
                                      fontSize: isMobile ? 13 : 18,
                                      fontFamily: 'Cairo',
                                      fontWeight: FontWeight.bold,
                                      color: Provider.of<DarkModeProvider>(
                                                  context,
                                                  listen: false)
                                              .isDark
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ],
                            );
                          },
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: isMobile ? 2 : 5,
                            crossAxisSpacing: isMobile ? 0 : 1.0,
                            mainAxisSpacing: isMobile ? 4 : 1.0,
                            childAspectRatio: isMobile ? 4 : 5,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            'فحوصات \ أشعة',
                            style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: isMobile ? 13 : 20,
                                fontWeight: FontWeight.bold,
                                color: Provider.of<DarkModeProvider>(context,
                                            listen: false)
                                        .isDark
                                    ? Colors.white
                                    : Colors.black),
                          ),
                          SizedBox(
                            width: isMobile ? 5 : 10,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                for (int i = 0;
                                    i < CaseDialog.clincTestsBools.length;
                                    i++) {
                                  CaseDialog.clincTestsBools[i] = false;
                                }
                              });
                            },
                            child: SizedBox(
                              width: isMobile ? 60 : 100,
                              child: Center(
                                child: Text(
                                  'مسح الكل',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Cairo',
                                      fontSize: isMobile ? 11 : 15),
                                ),
                              ),
                            ),
                            style: ButtonStyle(
                              elevation: MaterialStateProperty.all<double>(0),
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
                        ],
                      ),
                      Expanded(
                        child: GridView.builder(
                          itemCount: userProvider.clincUser.clincTests.length,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                Checkbox(
                                    value: CaseDialog.clincTestsBools[index],
                                    onChanged: (val) {
                                      setState(() {
                                        CaseDialog.clincTestsBools[index] =
                                            !CaseDialog.clincTestsBools[index];
                                      });
                                    }),
                                Text(userProvider.clincUser.clincTests[index],
                                    style: TextStyle(
                                        fontFamily: 'Cairo',
                                        fontWeight: FontWeight.bold,
                                        color: Provider.of<DarkModeProvider>(
                                                    context,
                                                    listen: false)
                                                .isDark
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: isMobile ? 13 : 18)),
                              ],
                            );
                          },
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: isMobile ? 2 : 5,
                            crossAxisSpacing: isMobile ? 0 : 1.0,
                            mainAxisSpacing: isMobile ? 4 : 1.0,
                            childAspectRatio: isMobile ? 4 : 5,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: TextFormField(
                          controller: CaseDialog.noteController,
                          onFieldSubmitted: (val) {
                            // FocusScope.of(context).requestFocus(focus);
                          },
                          style: feildStyle,
                          cursorColor: Colors.blue,
                          decoration: new InputDecoration(
                            labelStyle: feildStyle,
                            prefixIcon: Icon(Icons.account_circle,
                                color: Provider.of<DarkModeProvider>(context,
                                            listen: false)
                                        .isDark
                                    ? Colors.white
                                    : Colors.black),
                            labelText: "ملاحظات حول الجلسة",
                            focusedBorder: OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(60.0),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(60.0),
                              borderSide: BorderSide(
                                  color: Provider.of<DarkModeProvider>(context,
                                              listen: false)
                                          .isDark
                                      ? Colors.white
                                      : Colors.black),
                            ),
                            //fillColor: Colors.green),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 300,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (_) {
                                  return AddBondDialog('increase');
                                },
                              );
                            },
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: CaseDialog.isLoading
                                    ? SizedBox(
                                        width: isMobile ? 30 : 50,
                                        height: isMobile ? 30 : 50,
                                        child: CircularProgressIndicator(
                                          backgroundColor: Colors.white,
                                        ),
                                      )
                                    : Text(
                                        'إضافة دفعة لهذه الجلسة',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Cairo',
                                            fontSize: 15),
                                      ),
                              ),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.grey),
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
                      SizedBox(
                        width: 500,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: ElevatedButton(
                            onPressed: widget.onPressed,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: CaseDialog.isLoading
                                    ? SizedBox(
                                        width: isMobile ? 30 : 50,
                                        height: isMobile ? 30 : 50,
                                        child: CircularProgressIndicator(
                                          backgroundColor: Colors.white,
                                        ),
                                      )
                                    : Text(
                                        'إضافة',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Cairo',
                                            fontSize: 15),
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
                ));
          },
        ));
  }
}
