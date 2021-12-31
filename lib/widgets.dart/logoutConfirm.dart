import 'dart:io';

import 'package:desktop_version/provider/darkModeProvider.dart';
import 'package:desktop_version/provider/userProvider.dart';
import 'package:desktop_version/screen/settingsScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LogoutConfirmDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isMobile = Platform.isAndroid || Platform.isIOS;
    var feildStyle =
        TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold);
    double width = MediaQuery.of(context).size.width;

    double height = MediaQuery.of(context).size.height;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AlertDialog(
        backgroundColor:
            Provider.of<DarkModeProvider>(context, listen: false).isDark
                ? SettingsScreen.darkMode2
                : Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            new Text(
              'هل تريد تسجيل الخروج؟',
              style: TextStyle(
                  color: Provider.of<DarkModeProvider>(context, listen: false)
                          .isDark
                      ? Colors.white
                      : Colors.black,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.bold,
                  fontSize: isMobile ? 15 : 25),
            ),
          ],
        ),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
              width: isMobile ? 100 : 200,
              child: ElevatedButton(
                onPressed: () {
                  Provider.of<UserProvier>(context, listen: false)
                      .signout(context);
                },
                child: Center(
                  child: Padding(
                    padding: isMobile?const EdgeInsets.all(5.0): const EdgeInsets.all(12.0),
                    child: Text(
                      'خروج',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cairo',
                          fontSize: isMobile ? 12 : 15),
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
            SizedBox(
              width:isMobile? 3: 10,
            ),
            SizedBox(
              height: 50,
              width: isMobile ? 100 : 200,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Center(
                  child: Padding(
                    padding:isMobile?const EdgeInsets.all(5.0): const EdgeInsets.all(12.0),
                    child: Text(
                      'إلغاء',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cairo',
                          fontSize: isMobile ? 12 : 15),
                    ),
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.grey),
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
      ),
    );
  }
}
