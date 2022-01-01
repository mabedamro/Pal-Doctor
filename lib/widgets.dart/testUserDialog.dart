import 'dart:io';

import 'package:desktop_version/provider/darkModeProvider.dart';
import 'package:desktop_version/provider/userProvider.dart';
import 'package:desktop_version/screen/settingsScreen.dart';
import 'package:desktop_version/widgets.dart/addDiagsDialog.dart';
import 'package:desktop_version/widgets.dart/addTestDialog.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TestsUserDialog extends StatefulWidget {
  @override
  _TestsUserDialogState createState() => _TestsUserDialogState();
}

class _TestsUserDialogState extends State<TestsUserDialog> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<void> addDiag(String d) async {
    await Provider.of<UserProvier>(context, listen: false).addTest(d, context);
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Provider.of<DarkModeProvider>(context, listen: false).isDark;
    double width = MediaQuery.of(context).size.width;

    bool isMobile = Platform.isAndroid || Platform.isIOS;
    double height = MediaQuery.of(context).size.height;
    return Directionality(
      textDirection: TextDirection.rtl,
      
      child: AlertDialog(
        backgroundColor: 
                       isDark?SettingsScreen.darkMode1:Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  'فحوصات العيادة',
                  style: TextStyle(
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.bold,
                      color: isDark?Colors.white:Colors.black,
                      fontSize: isMobile? 15:25),
                ),
                isMobile? Container():Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) {
                          return AddTestDialog();
                        },
                      );
                    },
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Icon(Icons.add),
                            Text(
                              'إضافة فحص / أشعة',
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
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            IconButton(
                icon: Icon(Icons.close,
                      color: isDark?Colors.white:Colors.black,),
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
              isMobile?Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) {
                          return AddTestDialog();
                        },
                      );
                    },
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add),
                            Text(
                              'إضافة فحص / أشعة',
                              style: TextStyle(
                                
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontFamily: 'Cairo',
                                  fontSize: 11),
                            ),
                          ],
                        ),
                      ),
                    ),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ),
                    ),
                  ),
                ):Container(),
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
              Expanded(child: Consumer<UserProvier>(
                  builder: (context, userProvider, child) {
                return Container(
                    height: double.infinity,
                    child: userProvider.clincUser.clincTests.length == 0
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
                                      color: Provider.of<DarkModeProvider>(
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
                            itemCount: userProvider.clincUser.clincTests.length,
                            itemBuilder: (_, index) {
                              return Card(

                      color: isDark?SettingsScreen.darkMode2:Colors.grey[100],
                                child: InkWell(
                                  child: Container(
                                    height: 50,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Center(
                                              child: Text(
                                                userProvider
                                                    .clincUser.clincTests[index]
                                                    .toString(),
                                                style: TextStyle(
                                                    fontFamily: 'Cairo',
                                                    fontSize: isMobile?12:14,
                      color: isDark?Colors.white:Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Center(
                                              child: IconButton(
                                                icon: Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                  size: isMobile?20:24,
                                                ),
                                                onPressed: () {
                                                  Provider.of<UserProvier>(
                                                          context,
                                                          listen: false)
                                                      .deleteTest(
                                                          userProvider.clincUser
                                                                  .clincTests[
                                                              index],
                                                          context);
                                                },
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
                          ));
              })),
            ],
          ),
        ),
      ),
    );
  }
}
