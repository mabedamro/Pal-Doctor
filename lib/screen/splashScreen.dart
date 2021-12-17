import 'package:desktop_version/provider/userProvider.dart';
import 'package:desktop_version/screen/homeScreen.dart';
import 'package:desktop_version/screen/loginScreen.dart';
import 'package:firedart/auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    tryToLogin();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: SvgPicture.asset(
                'assets/images/drawing.svg',
                width: 300,
              ),
            ),
            SizedBox(width: 30, height: 30, child: CircularProgressIndicator())
          ],
        ),
      ),
    );
  }

  Future<void> tryToLogin() async {
    String result =
        await Provider.of<UserProvier>(context, listen: false).tryToLogin();
    if (result == 'success') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
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
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }
}
