import 'dart:io';

import 'package:desktop_version/provider/darkModeProvider.dart';
import 'package:desktop_version/provider/employeesProvider.dart';
import 'package:desktop_version/provider/userProvider.dart';
import 'package:desktop_version/screen/settingsScreen.dart';
import 'package:firedart/auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddEmployee extends StatefulWidget {
  @override
  _AddEmployeeState createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool pat = false, emp = false, date = false, fin = false;
  List<String> permission = [
    '0',
    '0',
    '0',
    '0',
  ];

  final focusName = FocusNode();

  final focusPhone = FocusNode();

  final focusEmail = FocusNode();

  final focusPass = FocusNode();

  final focusPassConfirm = FocusNode();
  TextEditingController nameCon = TextEditingController();
  TextEditingController emailCon = TextEditingController();
  TextEditingController passCon = TextEditingController();
  TextEditingController passConCon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    bool isMobile = Platform.isAndroid || Platform.isIOS;
    var feildStyle = TextStyle(
      fontFamily: 'Cairo',
      fontWeight: FontWeight.bold,
      fontSize: isMobile ? 13 : 16,
      color: Provider.of<DarkModeProvider>(context, listen: false).isDark
          ? Colors.white
          : Colors.black,
    );
    double width = MediaQuery.of(context).size.width;
    final color = Colors.blue;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor:
            Provider.of<DarkModeProvider>(context, listen: false).isDark
                ? SettingsScreen.darkMode1
                : Colors.white,
        appBar: AppBar(
          leading: Container(),
          centerTitle: true,
          title: Text(
            'إضافة موظف',
            style: TextStyle(color: Colors.blue, fontFamily: 'Cairo',fontWeight: FontWeight.bold,),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            Directionality(
              textDirection: TextDirection.rtl,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: SizedBox(
                    width: isMobile ? 30 : 200,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          isMobile
                              ? Container()
                              : Text(
                                  'رجوع',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Cairo',
                                      fontSize: 15),
                                ),
                          Icon(Icons.arrow_forward_ios_outlined)
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
              ),
            ),
          ],
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                color:
                    Provider.of<DarkModeProvider>(context, listen: false).isDark
                        ? SettingsScreen.darkMode2
                        : Colors.white,
                padding: EdgeInsets.all(15),
                width: isMobile ? width : width - width / 2,
                child: Column(
                  children: [
                    Icon(
                      Icons.person,
                      size: isMobile ? 80 : 100,
                      color: Colors.blue,
                    ),
                    Container(
                      width: isMobile
                          ? width
                          : MediaQuery.of(context).size.width / 2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: TextFormField(
                            //     onFieldSubmitted: (val) {
                            //       FocusScope.of(context).requestFocus(focusName);
                            //     },
                            //     cursorColor: color,
                            //     decoration: new InputDecoration(
                            //       prefixIcon:
                            //           Icon(Icons.picture_in_picture_outlined),
                            //       labelText: "ID Number",
                            //       focusedBorder: OutlineInputBorder(
                            //         borderRadius: new BorderRadius.circular(60.0),
                            //         borderSide: BorderSide(color: color),
                            //       ),
                            //       enabledBorder: OutlineInputBorder(
                            //         borderRadius: new BorderRadius.circular(60.0),
                            //         // borderSide: BorderSide(color: color),
                            //       ),
                            //       //fillColor: Colors.green),
                            //     ),
                            //   ),
                            // ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                focusNode: focusName,
                                style: feildStyle,
                                onFieldSubmitted: (val) {
                                  FocusScope.of(context)
                                      .requestFocus(focusEmail);
                                },
                                cursorColor: color,
                                validator: (val) {
                                  if (trim(val).length < 5) {
                                    return 'too short name';
                                  }
                                  return null;
                                },
                                controller: nameCon,
                                decoration: new InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.account_circle,
                                    color: Provider.of<DarkModeProvider>(
                                                context,
                                                listen: false)
                                            .isDark
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                  labelStyle: feildStyle,
                                  labelText: "الاسم",
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(60.0),
                                    borderSide: BorderSide(color: color),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(60.0),
                                    borderSide: BorderSide(
                                      color: Provider.of<DarkModeProvider>(
                                                  context,
                                                  listen: false)
                                              .isDark
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                  //fillColor: Colors.green),
                                ),
                              ),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: TextFormField(
                            //     focusNode: focusPhone,
                            //     onFieldSubmitted: (val) {
                            //       FocusScope.of(context).requestFocus(focusEmail);
                            //     },
                            //     cursorColor: color,
                            //     decoration: new InputDecoration(
                            //       prefixIcon: Icon(
                            //         Icons.phone_sharp,
                            //       ),
                            //       labelText: "Phone",
                            //       focusedBorder: OutlineInputBorder(
                            //         borderRadius: new BorderRadius.circular(60.0),
                            //         borderSide: BorderSide(color: color),
                            //       ),
                            //       enabledBorder: OutlineInputBorder(
                            //         borderRadius: new BorderRadius.circular(60.0),
                            //         // borderSide: BorderSide(color: color),
                            //       ),
                            //       //fillColor: Colors.green),
                            //     ),
                            //   ),
                            // ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                style: feildStyle,
                                focusNode: focusEmail,
                                onFieldSubmitted: (val) {
                                  FocusScope.of(context)
                                      .requestFocus(focusPass);
                                },
                                controller: emailCon,
                                cursorColor: color,
                                decoration: new InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: Provider.of<DarkModeProvider>(
                                                context,
                                                listen: false)
                                            .isDark
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                  labelStyle: feildStyle,
                                  labelText: "البريد الإلكتروني",
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(60.0),
                                    borderSide: BorderSide(color: color),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(60.0),
                                    borderSide: BorderSide(
                                      color: Provider.of<DarkModeProvider>(
                                                  context,
                                                  listen: false)
                                              .isDark
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                  //fillColor: Colors.green),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                focusNode: focusPass,
                                style: feildStyle,
                                onFieldSubmitted: (val) {
                                  FocusScope.of(context)
                                      .requestFocus(focusPassConfirm);
                                },
                                obscureText: true,
                                cursorColor: color,
                                validator: (val) {
                                  if (trim(val).length < 8) {
                                    return 'كلمة المرور قصيرة جدا';
                                  }

                                  return null;
                                },
                                controller: passCon,
                                decoration: new InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: Provider.of<DarkModeProvider>(
                                                context,
                                                listen: false)
                                            .isDark
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                  labelStyle: feildStyle,
                                  labelText: "كلمة المرور",
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(60.0),
                                    borderSide: BorderSide(color: color),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(60.0),
                                    borderSide: BorderSide(
                                      color: Provider.of<DarkModeProvider>(
                                                  context,
                                                  listen: false)
                                              .isDark
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                  //fillColor: Colors.green),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                style: feildStyle,
                                controller: passConCon,
                                focusNode: focusPassConfirm,
                                obscureText: true,
                                onFieldSubmitted: (val) {
                                  // FocusScope.of(context).requestFocus(focus);
                                },
                                validator: (val) {
                                  if (passConCon.text.trim() !=
                                      passCon.text.trim()) {
                                    return 'كلمة المرور غير متطابقة';
                                  }

                                  return null;
                                },
                                cursorColor: color,
                                decoration: new InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: Provider.of<DarkModeProvider>(
                                                context,
                                                listen: false)
                                            .isDark
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                  labelStyle: feildStyle,
                                  labelText: "تأكيد كلمة المرور",
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(60.0),
                                    borderSide: BorderSide(color: color),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(60.0),
                                    borderSide: BorderSide(
                                      color: Provider.of<DarkModeProvider>(
                                                  context,
                                                  listen: false)
                                              .isDark
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                  //fillColor: Colors.green),
                                ),
                              ),
                            ),
                            !isMobile
                                ? Container()
                                : Row(
                                    children: [
                                      Text(
                                        'الصلاحيات: ',
                                        style: TextStyle(
                                            fontFamily: 'Cairo',
                                            fontSize: isMobile ? 11 : 15,
                                            color:
                                                Provider.of<DarkModeProvider>(
                                                            context,
                                                            listen: false)
                                                        .isDark
                                                    ? Colors.white
                                                    : Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  isMobile
                                      ? Container()
                                      : Text(
                                          'الصلاحيات: ',
                                          style: TextStyle(
                                              fontFamily: 'Cairo',
                                              fontSize: isMobile ? 11 : 15,
                                              color:
                                                  Provider.of<DarkModeProvider>(
                                                              context,
                                                              listen: false)
                                                          .isDark
                                                      ? Colors.white
                                                      : Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Checkbox(
                                              value: pat,
                                              onChanged: (val) {
                                                setState(() {
                                                  pat = val;
                                                  if (pat) {
                                                    permission[0] = '1';
                                                  } else {
                                                    permission[0] = '0';
                                                  }
                                                });
                                              }),
                                          Text(
                                            'الوصول لسجل المرضى',
                                            style: TextStyle(
                                                fontFamily: 'Cairo',
                                                color:
                                                    Provider.of<DarkModeProvider>(
                                                                context,
                                                                listen: false)
                                                            .isDark
                                                        ? Colors.white
                                                        : Colors.black,
                                                fontSize: isMobile ? 11 : 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      isMobile
                                          ? Container()
                                          : Row(
                                              children: [
                                                Checkbox(
                                                    value: emp,
                                                    onChanged: (val) {
                                                      setState(() {
                                                        emp = val;
                                                        if (emp) {
                                                          permission[1] = '1';
                                                        } else {
                                                          permission[1] = '0';
                                                        }
                                                      });
                                                    }),
                                                Text(
                                                  'الوصول الى سجل الموظفين',
                                                  style: TextStyle(
                                                      fontFamily: 'Cairo',
                                                      color:
                                                          Provider.of<DarkModeProvider>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .isDark
                                                              ? Colors.white
                                                              : Colors.black,
                                                      fontSize:
                                                          isMobile ? 11 : 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  ' تحذير : سيكون الموظف قادر على إضافة وحذف موظفين.',
                                                  style: TextStyle(
                                                      fontFamily: 'Cairo',
                                                      color: Colors.red,
                                                      fontSize:
                                                          isMobile ? 10 : 13,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                      isMobile
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Checkbox(
                                                        value: emp,
                                                        onChanged: (val) {
                                                          setState(() {
                                                            emp = val;
                                                            if (emp) {
                                                              permission[1] =
                                                                  '1';
                                                            } else {
                                                              permission[1] =
                                                                  '0';
                                                            }
                                                          });
                                                        }),
                                                    Text(
                                                      'الوصول الى سجل الموظفين',
                                                      style: TextStyle(
                                                          fontFamily: 'Cairo',
                                                          color: Provider.of<
                                                                          DarkModeProvider>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .isDark
                                                              ? Colors.white
                                                              : Colors.black,
                                                          fontSize: isMobile
                                                              ? 11
                                                              : 15,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  ' تحذير : سيكون الموظف قادر على إضافة وحذف موظفين.',
                                                  style: TextStyle(
                                                      fontFamily: 'Cairo',
                                                      color: Colors.red,
                                                      fontSize:
                                                          isMobile ? 10 : 13,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            )
                                          : Container(),
                                      Row(
                                        children: [
                                          Checkbox(
                                              value: date,
                                              onChanged: (val) {
                                                setState(() {
                                                  date = val;
                                                  if (date) {
                                                    permission[2] = '1';
                                                  } else {
                                                    permission[2] = '0';
                                                  }
                                                });
                                              }),
                                          Text(
                                            'الوصول الى المواعيد',
                                            style: TextStyle(
                                                fontFamily: 'Cairo',
                                                color:
                                                    Provider.of<DarkModeProvider>(
                                                                context,
                                                                listen: false)
                                                            .isDark
                                                        ? Colors.white
                                                        : Colors.black,
                                                fontSize: isMobile ? 11 : 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      isMobile
                                          ? Container()
                                          : Row(
                                              children: [
                                                Checkbox(
                                                    value: fin,
                                                    onChanged: (val) {
                                                      setState(() {
                                                        fin = val;
                                                        if (fin) {
                                                          permission[3] = '1';
                                                        } else {
                                                          permission[3] = '0';
                                                        }
                                                      });
                                                    }),
                                                Text(
                                                  'الوصول الى السجل المالي',
                                                  style: TextStyle(
                                                      fontFamily: 'Cairo',
                                                      color:
                                                          Provider.of<DarkModeProvider>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .isDark
                                                              ? Colors.white
                                                              : Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  ' تحذير : سيكون الموظف قادر على الوصول للسجل المالي',
                                                  style: TextStyle(
                                                      fontFamily: 'Cairo',
                                                      fontSize:
                                                          isMobile ? 10 : 13,
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                      isMobile
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Checkbox(
                                                        value: fin,
                                                        onChanged: (val) {
                                                          setState(() {
                                                            fin = val;
                                                            if (fin) {
                                                              permission[3] =
                                                                  '1';
                                                            } else {
                                                              permission[3] =
                                                                  '0';
                                                            }
                                                          });
                                                        }),
                                                    Text(
                                                      'الوصول الى السجل المالي',
                                                      style: TextStyle(
                                                          fontFamily: 'Cairo',
                                                          color: Provider.of<
                                                                          DarkModeProvider>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .isDark
                                                              ? Colors.white
                                                              : Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  ' تحذير : سيكون الموظف قادر على الوصول للسجل المالي',
                                                  style: TextStyle(
                                                      fontFamily: 'Cairo',
                                                      fontSize:
                                                          isMobile ? 10 : 13,
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            )
                                          : Container(),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 500,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (!isLoading) {
                              setState(() {
                                isLoading = true;
                              });
                              if (_formKey.currentState.validate()) {
                                if (!emp && !pat && !fin && !date) {
                                  //you have to choose at least one of the permissions.
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'عليك أن تختار على الأقل واحدة من الصلاحيات.'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                } else {
                                  String result =
                                      await Provider.of<EmployeesProvider>(
                                              context,
                                              listen: false)
                                          .creatEmp(
                                              clincId: Provider.of<UserProvier>(
                                                      context,
                                                      listen: false)
                                                  .user
                                                  .clincId,
                                              createdById:
                                                  FirebaseAuth.instance.userId,
                                              email: emailCon.text,
                                              pass: passCon.text,
                                              name: nameCon.text,
                                              permissions: permission,
                                              context: context);
                                  if (result == 'success') {
                                    Navigator.of(context).pop();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: Text(
                                                'تمت إضافة الموظف بنجاح !')),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                  } else {
                                    if (result == 'INVALID_EMAIL') {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: Text(
                                                'البريد الإلكتروني غير صالح !'),
                                          ),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
                                    if (result == 'EMAIL_EXISTS') {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: Text(
                                                'البريد الإلكتروني مستخدم بالفعل !'),
                                          ),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }

                                    if (result == 'internet fail') {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: Text(
                                                '!تحقق من الاتصال بالانترنت'),
                                          ),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }

                                    setState(() {
                                      isLoading = false;
                                    });
                                  }
                                }
                              }
                              setState(() {
                                isLoading = false;
                              });
                            }
                          },
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                'إضافة موظف',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Cairo',
                                    fontSize: 15),
                              ),
                            ),
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.green),
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
                    isLoading ? CircularProgressIndicator() : Container(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
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
}
