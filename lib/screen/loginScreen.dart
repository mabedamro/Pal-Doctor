import 'dart:io';
import 'package:desktop_version/screen/homeScreen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

//0055d4ff main color
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final focus = FocusNode();
  @override
  Widget build(BuildContext context) {
    Color color = Colors.blue;
    return Scaffold(
      // backgroundColor: Colors.blue,
      body: !Platform.isAndroid && !Platform.isIOS
          ? Center(
              child: Container(
                width: 400,
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
                    TextField(
                      onSubmitted: (val) {
                        FocusScope.of(context).requestFocus(focus);
                      },
                      cursorColor: color,
                      decoration: new InputDecoration(
                        prefixIcon: Icon(
                          Icons.phone_sharp,
                        ),
                        labelText: "Phone Number",
                        focusedBorder: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: BorderSide(color: color),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          // borderSide: BorderSide(color: color),
                        ),
                        //fillColor: Colors.green),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextField(
                      focusNode: focus,
                      onSubmitted: (val) {
                        print('enter button');
                        login();
                      },
                      cursorColor: color,
                      obscureText: true,
                      decoration: new InputDecoration(
                        prefixIcon: Icon(
                          Icons.lock,
                        ),
                        labelText: "Password",
                        focusedBorder: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: BorderSide(color: color),
                        ),

                        enabledBorder: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          // borderSide: BorderSide(color: color),
                        ),
                        //fillColor: Colors.green),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        login();
                      },
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            'Login',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Ubuntu',
                                fontSize: 15),
                          ),
                        ),
                      ),
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          : Container(
              child: Text('its android'),
            ),
    );
  }

  void login() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }
}
