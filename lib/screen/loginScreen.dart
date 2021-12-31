import 'dart:io';
import 'package:desktop_version/provider/darkModeProvider.dart';
import 'package:desktop_version/provider/userProvider.dart';
import 'package:desktop_version/screen/homeScreen.dart';
import 'package:desktop_version/screen/settingsScreen.dart';
import 'package:firedart/firedart.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//0055d4ff main color
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();
  final focus = FocusNode();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    Color color = Colors.blue;
     bool isMobile = Platform.isAndroid || Platform.isIOS;
     double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor:
          Provider.of<DarkModeProvider>(context, listen: false).isDark
              ? SettingsScreen.darkMode1
              : Colors.white,

      // backgroundColor: Colors.blue,
      body:  Directionality(
              textDirection: TextDirection.rtl,
              child: Center(
                child: Container(
                  width: isMobile? width -30:400,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: SvgPicture.asset(
                          Provider.of<DarkModeProvider>(context, listen: false)
                                  .isDark
                              ? 'assets/images/drawingDark.svg'
                              : 'assets/images/drawing.svg',
                          width:isMobile? 160: 300,
                        ),
                      ),
                      TextField(
                        controller: _emailController,
                        onSubmitted: (val) {
                          FocusScope.of(context).requestFocus(focus);
                        },
                        cursorColor: color,
                        style: TextStyle(
                            fontFamily: 'Cairo',
                            color: Provider.of<DarkModeProvider>(context,
                                        listen: false)
                                    .isDark
                                ? Colors.white
                                : Colors.black),
                        decoration: new InputDecoration(
                          prefixIcon: Icon(Icons.email_rounded,
                              color: Provider.of<DarkModeProvider>(context,
                                          listen: false)
                                      .isDark
                                  ? Colors.white
                                  : Colors.black),

                          labelText: "البريد الإلكتروني",

                          labelStyle: TextStyle(
                              color: Provider.of<DarkModeProvider>(context,
                                          listen: false)
                                      .isDark
                                  ? Colors.white
                                  : Colors.black),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(100.0),
                            borderSide: BorderSide(color: color),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(100.0),
                            borderSide: BorderSide(
                                color: Provider.of<DarkModeProvider>(context,
                                            listen: false)
                                        .isDark
                                    ? Colors.white
                                    : color),
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
                        controller: _passwordController,
                        onSubmitted: (val) {
                          print('enter button');
                          setState(() {
                            isLoading = true;
                          });
                          login();
                        },
                        obscureText: true,
                        cursorColor: color,
                        style: TextStyle(
                            fontFamily: 'Cairo',
                            color: Provider.of<DarkModeProvider>(context,
                                        listen: false)
                                    .isDark
                                ? Colors.white
                                : Colors.black),
                        decoration: new InputDecoration(
                          prefixIcon: Icon(Icons.lock,
                              color: Provider.of<DarkModeProvider>(context,
                                          listen: false)
                                      .isDark
                                  ? Colors.white
                                  : Colors.black),
                          labelStyle: TextStyle(
                              fontFamily: 'Cairo',
                              color: Provider.of<DarkModeProvider>(context,
                                          listen: false)
                                      .isDark
                                  ? Colors.white
                                  : Colors.black),
                          labelText: "كلمة المرور",
                          focusedBorder: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(100.0),
                            borderSide: BorderSide(color: color),
                          ),

                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Provider.of<DarkModeProvider>(context,
                                            listen: false)
                                        .isDark
                                    ? Colors.white
                                    : color),
                            borderRadius: new BorderRadius.circular(100.0),
                            // borderSide: BorderSide(color: color),
                          ),
                          //fillColor: Colors.green),
                        ),
                      ),
                      // TextField(
                      //   controller: _passwordController,
                      //   // focusNode: focus,
                      //   style: TextStyle(
                      //       color:  Provider.of<DarkModeProvider>(context,listen: false).isDark
                      //           ? Colors.white
                      //           : Colors.black),
                      //   onSubmitted: (val) {
                      //     print('enter button');
                      //     setState(() {
                      //       isLoading = true;
                      //     });
                      //     login();
                      //   },
                      //   cursorColor: color,
                      //   obscureText: true,
                      //   decoration: new InputDecoration(
                      //     prefixIcon: Icon(Icons.lock,
                      //         color:  Provider.of<DarkModeProvider>(context,listen: false).isDark
                      //             ? Colors.white
                      //             : Colors.black),
                      //     labelStyle: TextStyle(
                      //       fontFamily: 'Cairo',
                      //         color:  Provider.of<DarkModeProvider>(context,listen: false).isDark
                      //             ? Colors.white
                      //             : Colors.black),
                      //     labelText: "كلمة المرور",
                      //     focusedBorder: OutlineInputBorder(
                      //       borderRadius: new BorderRadius.circular(100.0),
                      //       borderSide: BorderSide(color: color),
                      //     ),

                      //     enabledBorder: OutlineInputBorder(
                      //       borderSide: BorderSide(
                      //           color:  Provider.of<DarkModeProvider>(context,listen: false).isDark
                      //               ? Colors.white
                      //               : color),
                      //       borderRadius: new BorderRadius.circular(100.0),
                      //       // borderSide: BorderSide(color: color),
                      //     ),
                      //     //fillColor: Colors.green),
                      //   ),
                      // ),
                      SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (isLoading == false) {
                            setState(() {
                              isLoading = true;
                            });
                            login();
                          }
                        },
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              'تسجيل الدخول',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Cairo',
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
                      ),
                      isLoading
                          ? Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: CircularProgressIndicator(),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
            )
          
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
      print(temp);
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

      print(result);
      print(temp.length);

      return result;
    }
  }

  Future<void> login() async {
    if (isLoading == true) {
      String result = await Provider.of<UserProvier>(context, listen: false)
          .login(email: trim(_emailController.text), pass: _passwordController.text);
      print(result);
      if (result == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Directionality(
                textDirection: TextDirection.rtl,
                child: Text('تم تسجيل الدخول!')),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else if (result == 'fail') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Directionality(
                textDirection: TextDirection.rtl,
                child: Text('البريد الإلكتروني أو كلمة السر غير صحيح')),
            backgroundColor: Colors.red,
          ),
        );
        setState(() {
          isLoading = false;
        });
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
        setState(() {
          isLoading = false;
        });
      }
    }
  }
}
