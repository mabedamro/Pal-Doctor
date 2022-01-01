import 'dart:io';

import 'package:desktop_version/provider/darkModeProvider.dart';
import 'package:desktop_version/provider/userProvider.dart';
import 'package:desktop_version/screen/settingsScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddTestDialog extends StatefulWidget {
  @override
  _AddTestDialogState createState() => _AddTestDialogState();
}

class _AddTestDialogState extends State<AddTestDialog> {
  TextEditingController inputController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    bool isMobile = Platform.isAndroid || Platform.isIOS;
    bool isDark = Provider.of<DarkModeProvider>(context, listen: false).isDark;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AlertDialog(
        backgroundColor: isDark ? SettingsScreen.darkMode1 : Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  'أدخل فحص / أشعة الجديد',
                  style: TextStyle(
                      fontFamily: 'Cairo',
                      color: isDark ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
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
          width: 500,
          height: 180,
          child: Column(
            children: [
              SizedBox(
                width: 400,
                child: TextField(
                  onSubmitted: (val) {
                    print('enter button');
                  },
                  onChanged: (val) {},
                  controller: inputController,
                  cursorColor: Colors.blue,
                  style: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                      fontFamily: 'Cairo'),
                  decoration: new InputDecoration(
                    prefixIcon: Icon(
                      Icons.assignment,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                    labelText: "فحص / أشعة...",
                    labelStyle: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                        fontFamily: 'Cairo'),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(50.0),
                      borderSide: BorderSide(color: Colors.blue),
                    ),

                    enabledBorder: OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(500.0),
                      borderSide: BorderSide(
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                    //fillColor: Colors.green),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                width: 200,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      await Provider.of<UserProvier>(context, listen: false)
                          .addTest(inputController.text, context);
                      Navigator.of(context).pop();
                    },
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            isLoading ? Container() : Icon(Icons.add),
                            isLoading
                                ? SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: CircularProgressIndicator(
                                      backgroundColor: Colors.white,
                                    ),
                                  )
                                : Text(
                                    'إضافة',
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
