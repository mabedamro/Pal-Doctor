
import 'package:desktop_version/provider/darkModeProvider.dart';
import 'package:desktop_version/provider/employeesProvider.dart';
import 'package:desktop_version/screen/employeeScreen.dart';
import 'package:desktop_version/screen/settingsScreen.dart';
import 'package:desktop_version/widgets.dart/addBondDialog.dart';
import 'package:desktop_version/widgets.dart/employeeBondsDialog.dart';
import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EmployeeInformationScreen extends StatefulWidget {
  static List<String> permission = [
    '0',
    '0',
    '0',
    '0',
  ];
  EmployeeInformationScreen();
  @override
  __EmployeeInformationScreenpertiesState createState() =>
      __EmployeeInformationScreenpertiesState();
}

class __EmployeeInformationScreenpertiesState extends State<EmployeeInformationScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();
  bool showSideMenu = false;
  final double _width = 0;
  bool pat = false, emp = false, date = false, fin = false;

  final double _height = double.infinity;
  final Color _color = Colors.white;
  final BorderRadiusGeometry _borderRadius = BorderRadius.circular(8);
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void initPermisions() {
    if (EmployeeInformationScreen.permission[0] == '1') {
      pat = true;
    } else {
      pat = false;
    }
    if (EmployeeInformationScreen.permission[1] == '1') {
      emp = true;
    } else {
      emp = false;
    }
    if (EmployeeInformationScreen.permission[2] == '1') {
      date = true;
    } else {
      date = false;
    }
    if (EmployeeInformationScreen.permission[3] == '1') {
      fin = true;
    } else {
      fin = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    showSideMenu=true;
    initPermisions();
    final color = Colors.blue;
    nameController.text = EmployeeScreen.selectedEmployee.name;
    emailController.text = EmployeeScreen.selectedEmployee.email;
    return Scaffold(
      backgroundColor: Provider.of<DarkModeProvider>(context,
                                                    listen: false)
                                                .isDark?SettingsScreen.darkMode1:Colors.grey[100],
      body: Directionality(textDirection: TextDirection.rtl,
        child: SafeArea(
          child: SizedBox(
            width: 600,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () async {
                              if (EmployeeScreen.enableEditing) {
                                if (EmployeeScreen.selectedEmployee.createdBy ==
                                    'me') {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: Text(
                                              'لا يمكنك التعديل على هذا الموظف !')),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                } else {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  String result =
                                      await Provider.of<EmployeesProvider>(context,
                                              listen: false)
                                          .updateEmployee(
                                              nameController.text,
                                              EmployeeInformationScreen.permission,
                                              EmployeeScreen.selectedEmployee,
                                              context: context);
                                  if (result == 'success') {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: Text(
                                                'تم التعديل على الموظف بنجاح !')),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                  } else if (result == 'internet fail') {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: Text('!تحقق من الاتصال بالانترنت'),
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
                              if (EmployeeScreen.selectedEmployee.createdBy == 'me') {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: Text(
                                            'لا يمكنك التعديل على هذا الموظف !')),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              } else {
                                setState(() {
                                  EmployeeScreen.enableEditing =
                                      !EmployeeScreen.enableEditing;
                                });
                              }
                            },
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      EmployeeScreen.enableEditing
                                          ? Icons.refresh
                                          : Icons.edit,
                                      size: showSideMenu ? 20 : 0,
                                    ),
                                    Text(
                                      EmployeeScreen.enableEditing
                                          ? 'تحديث معلومات الموظف'
                                          : 'تعديل',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Cairo',
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  EmployeeScreen.enableEditing
                                      ? Colors.blue
                                      : Colors.grey),
                              shape:
                                  MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                        isLoading
                            ? SizedBox(
                                width: 30,
                                height: 30,
                                child: CircularProgressIndicator(),
                              )
                            : Container(),
                        EmployeeScreen.enableEditing
                            ? Container()
                            : PopupMenuButton(
                                onSelected: (value) {
                                  if (value == 2) {
                                    showDialog(
                                      context: context,
                                      builder: (_) {
                                        return EmployeeBondsDialog(
                                            EmployeeScreen.selectedEmployee);
                                      },
                                    );
                                  } else if (value == 3) {
                                    showDialog(
                                      context: context,
                                      builder: (_) {
                                        return AddBondDialog('decrease emp');
                                      },
                                    );
                                  } else if (value == 4) {
                                    if (EmployeeScreen.selectedEmployee.createdBy ==
                                        'me') {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Directionality(
                                              textDirection: TextDirection.rtl,
                                              child: Text(
                                                  'لا يمكنك إلغاء تفعيل هذا الموظف !')),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    } else {
                                      if (EmployeeScreen.selectedEmployee.isActive ==
                                          '0') {
                                        Provider.of<EmployeesProvider>(context,
                                                listen: false)
                                            .changeActive(
                                                EmployeeScreen.selectedEmployee, '1',
                                                context: context);
                                      } else {
                                        Provider.of<EmployeesProvider>(context,
                                                listen: false)
                                            .changeActive(
                                                EmployeeScreen.selectedEmployee, '0',
                                                context: context);
                                      }
                                    }
                                  }
                                },
                                child: Container(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.keyboard_arrow_down_sharp,
                                        color: Provider.of<DarkModeProvider>(context,
                                                    listen: false)
                                                .isDark
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                      Text(
                                        'المزيد',
                                        style: TextStyle(
                                            fontFamily: 'Cairo',
                                            fontSize: 15,
                                            color: Provider.of<DarkModeProvider>(
                                                        context,
                                                        listen: false)
                                                    .isDark
                                                ? Colors.white
                                                : Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                itemBuilder: (context) => [
                                      // PopupMenuItem(
                                      //   child: Row(
                                      //     mainAxisAlignment:
                                      //         MainAxisAlignment.center,
                                      //     children: [
                                      //       Icon(Icons.add),
                                      //       Text(
                                      //         'إضافة تشخيص',
                                      //         style: TextStyle(
                                      //             fontFamily: 'Cairo',
                                      //             fontSize: 15,
                                      //             fontWeight: FontWeight.bold),
                                      //       ),
                                      //     ],
                                      //   ),
                                      //   value: 1,
                                      // ),
                                      PopupMenuItem(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.attach_money),
                                            Text(
                                              'السجل المالي للموظف',
                                              style: TextStyle(
                                                  fontFamily: 'Cairo',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        value: 2,
                                      ),
                                      PopupMenuItem(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.add),
                                            Text(
                                              'إضافة مسحوبات للموظف',
                                              style: TextStyle(
                                                  fontFamily: 'Cairo',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        value: 3,
                                      ),
                                      PopupMenuItem(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.power_settings_new_outlined),
                                            Text(
                                              EmployeeScreen.selectedEmployee
                                                          .isActive ==
                                                      '1'
                                                  ? 'إلغاء تفعيل الموظف'
                                                  : 'تفعيل الموظف',
                                              style: TextStyle(
                                                  fontFamily: 'Cairo',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        value: 4,
                                      )
                                    ]),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FittedBox(
                        child: GestureDetector(
                            child: Icon(
                              Icons.close,
                              color: Provider.of<DarkModeProvider>(context,
                                          listen: false)
                                      .isDark
                                  ? Colors.white
                                  : Colors.black,
                              size: 30,
                            ),
                            onTap: () {
                              Navigator.of(context).pop();
                            }),
                      ),
                    ),
                  ],
                ),
                Icon(
                  Icons.person,
                  size: showSideMenu ? 120 : 0,
                  color: Colors.blue,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: nameController,
                    enabled: EmployeeScreen.enableEditing,
                    onFieldSubmitted: (val) {
                      // FocusScope.of(context).requestFocus(focus);
                    },
                    style: TextStyle(
                      color:
                          Provider.of<DarkModeProvider>(context, listen: false).isDark
                              ? Colors.white
                              : Colors.black,
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.bold,
                    ),
                    cursorColor: color,
                    decoration: new InputDecoration(
                      prefixIcon: Icon(
                        Icons.person,
                        color: Provider.of<DarkModeProvider>(context, listen: false)
                                .isDark
                            ? Colors.white
                            : Colors.black,
                        size: showSideMenu ? 20 : 0,
                      ),
                      labelText: "الإسم",
                      labelStyle: TextStyle(
                        color: Provider.of<DarkModeProvider>(context, listen: false)
                                .isDark
                            ? Colors.white
                            : Colors.black,
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.bold,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(50.0),
                        borderSide: BorderSide(color: color),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(50.0),
                        borderSide: BorderSide(
                          color: Provider.of<DarkModeProvider>(context, listen: false)
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
                    controller: emailController,
                    enabled: false,
                    onFieldSubmitted: (val) {
                      // FocusScope.of(context).requestFocus(focus);
                    },
                    style: TextStyle(
                      color:
                          Provider.of<DarkModeProvider>(context, listen: false).isDark
                              ? Colors.white
                              : Colors.black,
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.bold,
                    ),
                    cursorColor: color,
                    decoration: new InputDecoration(
                      prefixIcon: Icon(
                        Icons.email,
                        color: Provider.of<DarkModeProvider>(context, listen: false)
                                .isDark
                            ? Colors.white
                            : Colors.black,
                        size: showSideMenu ? 20 : 0,
                      ),
                      labelStyle: TextStyle(
                        color: Provider.of<DarkModeProvider>(context, listen: false)
                                .isDark
                            ? Colors.white
                            : Colors.black,
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.bold,
                      ),
                      labelText: "البريد الألكتروني",
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
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        'الصلاحيات: ',
                        style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 15,
                            color:
                                Provider.of<DarkModeProvider>(context, listen: false)
                                        .isDark
                                    ? Colors.white
                                    : Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                  value: pat,
                                  onChanged: (val) {
                                    if (EmployeeScreen.enableEditing) {
                                      setState(() {
                                        pat = val;
                                        if (pat) {
                                          EmployeeInformationScreen.permission[0] =
                                              '1';
                                        } else {
                                          EmployeeInformationScreen.permission[0] =
                                              '0';
                                        }
                                      });
                                    }
                                  }),
                              Text(
                                'الوصول لسجل المرضى',
                                style: TextStyle(
                                    color: Provider.of<DarkModeProvider>(context,
                                                listen: false)
                                            .isDark
                                        ? Colors.white
                                        : Colors.black,
                                    fontFamily: 'Cairo',
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                value: emp,
                                onChanged: (val) {
                                  if (EmployeeScreen.enableEditing) {
                                    setState(() {
                                      emp = val;
                                      if (emp) {
                                        EmployeeInformationScreen.permission[1] = '1';
                                      } else {
                                        EmployeeInformationScreen.permission[1] = '0';
                                      }
                                    });
                                  }
                                },
                              ),
                              Text(
                                'الوصول الى سجل الموظفين',
                                style: TextStyle(
                                    color: Provider.of<DarkModeProvider>(context,
                                                listen: false)
                                            .isDark
                                        ? Colors.white
                                        : Colors.black,
                                    fontFamily: 'Cairo',
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                  value: date,
                                  onChanged: (val) {
                                    if (EmployeeScreen.enableEditing) {
                                      setState(() {
                                        date = val;
                                        if (date) {
                                          EmployeeInformationScreen.permission[2] =
                                              '1';
                                        } else {
                                          EmployeeInformationScreen.permission[2] =
                                              '0';
                                        }
                                      });
                                    }
                                  }),
                              Text(
                                'الوصول الى المواعيد',
                                style: TextStyle(
                                    color: Provider.of<DarkModeProvider>(context,
                                                listen: false)
                                            .isDark
                                        ? Colors.white
                                        : Colors.black,
                                    fontFamily: 'Cairo',
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                  value: fin,
                                  onChanged: (val) {
                                    if (EmployeeScreen.enableEditing) {
                                      setState(() {
                                        fin = val;
                                        if (fin) {
                                          EmployeeInformationScreen.permission[3] =
                                              '1';
                                        } else {
                                          EmployeeInformationScreen.permission[3] =
                                              '0';
                                        }
                                      });
                                    }
                                  }),
                              Text(
                                'الوصول الى السجل المالي',
                                style: TextStyle(
                                    color: Provider.of<DarkModeProvider>(context,
                                                listen: false)
                                            .isDark
                                        ? Colors.white
                                        : Colors.black,
                                    fontFamily: 'Cairo',
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Row(
                //   children: [
                //     Padding(
                //       padding: const EdgeInsets.all(8.0),
                //       child: ElevatedButton(
                //         onPressed: () {},
                //         child: Center(
                //           child: Padding(
                //             padding: const EdgeInsets.all(12.0),
                //             child: Row(
                //               children: [
                //                 Icon(
                //                   Icons.attach_money,
                //                 ),
                //                 Text(
                //                   'السجل المالي',
                //                   style: TextStyle(
                //                       color: Colors.white,
                //                       fontFamily: 'Cairo',
                //                       fontSize: 15),
                //                 ),
                //               ],
                //             ),
                //           ),
                //         ),
                //         style: ButtonStyle(
                //           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                //             RoundedRectangleBorder(
                //               borderRadius: BorderRadius.circular(50.0),
                //             ),
                //           ),
                //         ),
                //       ),
                //     ),
                //     Padding(
                //       padding: const EdgeInsets.all(8.0),
                //       child: ElevatedButton(
                //         onPressed: () {},
                //         child: Center(
                //           child: Padding(
                //             padding: const EdgeInsets.all(12.0),
                //             child: Row(
                //               children: [
                //                 Padding(
                //                   padding: const EdgeInsets.only(left: 8),
                //                   child: Icon(Icons.person_add_disabled),
                //                 ),
                //                 Text(
                //                   'إلغاء تفعيل الموظف',
                //                   style: TextStyle(
                //                       color: Colors.white,
                //                       fontFamily: 'Cairo',
                //                       fontSize: 15),
                //                 ),
                //               ],
                //             ),
                //           ),
                //         ),
                //         style: ButtonStyle(
                //           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                //             RoundedRectangleBorder(
                //               borderRadius: BorderRadius.circular(50.0),
                //             ),
                //           ),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
              ],
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
