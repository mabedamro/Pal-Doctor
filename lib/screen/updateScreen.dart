import 'dart:io';

import 'package:desktop_version/provider/darkModeProvider.dart';
import 'package:desktop_version/provider/userProvider.dart';
import 'package:desktop_version/screen/homeScreen.dart';
import 'package:desktop_version/screen/loginScreen.dart';
import 'package:desktop_version/screen/settingsScreen.dart';
import 'package:firedart/auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class UpdateScreen extends StatefulWidget {
  UpdateScreen(this.url);
  String url;
  @override
  _UpdateScreenState createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  @override
  Widget build(BuildContext context) {

    bool isMobile = Platform.isAndroid || Platform.isIOS;

    bool isDark = Provider.of<DarkModeProvider>(context, listen: false).isDark;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor:  Provider.of<DarkModeProvider>(context,listen: false).isDark? SettingsScreen.darkMode1:Colors.white,

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: SvgPicture.asset(isDark
                        ? 'assets/images/drawingDark.svg'
                        : 'assets/images/drawing.svg',
                width: isMobile?160 : 300,
              ),
            ),
            Text(
              isMobile?'قم بتحديث التطبيق من المتجر الخاص بالهاتف' :':قم بتحديث البرنامج من خلال الرابط التالي',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                  color: Colors.blue,
                  fontSize:isMobile?15 :  20),
            ),
           isMobile? Container(): SizedBox(
              width: width -300,
              child: Text(
                widget.url,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo',
                    fontSize: 15),
              ),
            ),
           isMobile? Container(): Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ElevatedButton(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: widget.url));
                },
                child: SizedBox(
                  width: 200,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'نسخ الرابط',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Cairo',
                              fontSize: 15),
                        ),
                        Icon(Icons.copy),
                      ],
                    ),
                  ),
                ),
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all<double>(0),
                  backgroundColor: MaterialStateProperty.all(Colors.grey),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
