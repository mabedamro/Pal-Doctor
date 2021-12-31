
import 'dart:io';

import 'package:desktop_version/provider/darkModeProvider.dart';
import 'package:desktop_version/provider/userProvider.dart';
import 'package:desktop_version/screen/homeScreen.dart';
import 'package:desktop_version/screen/loginScreen.dart';
import 'package:desktop_version/screen/settingsScreen.dart';
import 'package:firedart/auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isNoInterNet = false;

  @override
  Widget build(BuildContext context) {
    bool isMobile = Platform.isAndroid || Platform.isIOS;
    tryToLogin(context);
    return Scaffold(
      backgroundColor:
          Provider.of<DarkModeProvider>(context, listen: false).isDark
              ? SettingsScreen.darkMode1
              : Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: SvgPicture.asset(
                Provider.of<DarkModeProvider>(context, listen: false).isDark
                    ? 'assets/images/drawingDark.svg'
                    : 'assets/images/drawing.svg',
                width: isMobile? 160: 300,
              ),
            ),
            isNoInterNet
                ? Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isNoInterNet = false;
                        });
                      },
                      child: SizedBox(
                        width: 200,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'إعادة المحاولة',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Cairo',
                                    fontSize: 15),
                              ),
                              Icon(Icons.refresh),
                            ],
                          ),
                        ),
                      ),
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all<double>(0),
                        backgroundColor: MaterialStateProperty.all(Colors.grey),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                        ),
                      ),
                    ),
                  )
                : SizedBox(
                    width: isMobile?20:30, height: isMobile?20:30, child: CircularProgressIndicator())
          ],
        ),
      ),
    );
  }

  Future<void> tryToLogin(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('isDark') == null) {
      await Provider.of<DarkModeProvider>(context, listen: false)
          .changeDarkTo(false);
      prefs.setBool('isDark', false);
    } else {
      print('isDark exist');
      await Provider.of<DarkModeProvider>(context, listen: false)
          .changeDarkTo(prefs.getBool('isDark'));
    }
    String result = await Provider.of<UserProvier>(context, listen: false)
        .tryToLogin(context);
    if (result == 'success') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else if (result == 'needUpdate') {
      Provider.of<UserProvier>(context, listen: false)
          .goToUpdateScreen(context);
    } else if (result == 'internet fail') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Directionality(
            textDirection: TextDirection.rtl,
            child: Text('تحقق من الاتصال بالإنترنت'),
          ),
          backgroundColor: Colors.red,
        ),
      );
      if (isNoInterNet == false) {
        setState(() {
          isNoInterNet = true;
        });
      }
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }
}
