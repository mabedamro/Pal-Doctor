import 'dart:io';
import 'package:desktop_version/provider/userProvider.dart';
import 'package:desktop_version/screen/homeScreen.dart';
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
                      controller: _emailController,
                      onSubmitted: (val) {
                        FocusScope.of(context).requestFocus(focus);
                      },
                      cursorColor: color,
                      decoration: new InputDecoration(
                        prefixIcon: Icon(
                          Icons.email_rounded,
                        ),
                        labelText: "Email",
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
                      controller: _passwordController,
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
                            'Login',
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
            )
          : Container(
              child: Text('its android'),
            ),
    );
  }

  Future<void> login() async {
    String result = await Provider.of<UserProvier>(context, listen: false)
        .login(email: _emailController.text, pass: _passwordController.text);
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
