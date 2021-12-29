import 'package:desktop_version/provider/userProvider.dart';
import 'package:desktop_version/widgets.dart/diagsUserDialog.dart';
import 'package:desktop_version/widgets.dart/logoutConfirm.dart';
import 'package:desktop_version/widgets.dart/testUserDialog.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDark = false;
  bool isTests = false, isDiags = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
        width: width - 50,
        child: Row(children: [
          Expanded(
            child: Container(
              child: Column(
                children: [
                  Card(
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.brightness_2_rounded,
                                color: Colors.blue,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'الوضع المظلم',
                                style: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Switch(
                            value: isDark,
                            onChanged: (value) {
                              setState(() {
                                isDark = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) {
                            return DiagsUserDialog();
                          },
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.assignment,
                              color: Colors.blue,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'عرض تشخيصات العيادة',
                              style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    child: InkWell(
                      onTap: () {showDialog(
                          context: context,
                          builder: (_) {
                            return TestsUserDialog();
                          },
                        );},
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.biotech_rounded,
                              color: Colors.blue,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'عرض فحوصات العيادة',
                              style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    child: InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) {
                            return LogoutConfirmDialog();
                          },
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.logout,
                              color: Colors.blue,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'تسجيل الخروج',
                              style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Icon(
                  Icons.person,
                  size: 120,
                  color: Colors.blue,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    initialValue:
                        Provider.of<UserProvier>(context, listen: false)
                            .user
                            .name,
                    enabled: false,
                    onFieldSubmitted: (val) {
                      // FocusScope.of(context).requestFocus(focus);
                    },
                    cursorColor: Colors.blue,
                    decoration: new InputDecoration(
                      prefixIcon: Icon(
                        Icons.person,
                        size: 20,
                      ),
                      labelText: "الإسم",
                      focusedBorder: OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide: BorderSide(color: Colors.blue),
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
                  child: TextFormField(
                    initialValue:
                        Provider.of<UserProvier>(context, listen: false)
                            .user
                            .email,
                    enabled: false,
                    onFieldSubmitted: (val) {
                      // FocusScope.of(context).requestFocus(focus);
                    },
                    cursorColor: Colors.blue,
                    decoration: new InputDecoration(
                      prefixIcon: Icon(
                        Icons.email,
                        size: 20,
                      ),
                      labelText: "البريد الألكتروني",
                      focusedBorder: OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide: BorderSide(color: Colors.blue),
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
                            fontWeight: FontWeight.bold),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                  value: Provider.of<UserProvier>(context,
                                              listen: false)
                                          .user
                                          .permission[0] ==
                                      '1',
                                  onChanged: (val) {}),
                              Text(
                                'الوصول لسجل المرضى',
                                style: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                  value: Provider.of<UserProvier>(context,
                                              listen: false)
                                          .user
                                          .permission[1] ==
                                      '1',
                                  onChanged: (val) {}),
                              Text(
                                'الوصول الى سجل الموظفين',
                                style: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                  value: Provider.of<UserProvier>(context,
                                              listen: false)
                                          .user
                                          .permission[2] ==
                                      '1',
                                  onChanged: (val) {}),
                              Text(
                                'الوصول الى المواعيد',
                                style: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                value: Provider.of<UserProvier>(context,
                                            listen: false)
                                        .user
                                        .permission[3] ==
                                    '1',
                                onChanged: (val) {},
                              ),
                              Text(
                                'الوصول الى السجل المالي',
                                style: TextStyle(
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
                //       child: Text(
                //                     'تشخيصات العيادة',
                //                     style: TextStyle(
                //                         fontFamily: 'Cairo',
                //                         fontSize: 20,
                //                         fontWeight: FontWeight.bold),
                //                   ),
                //     ),
                //   ],
                // ),
                // DottedLine(
                //   direction: Axis.horizontal,
                //   lineLength: double.infinity,
                //   lineThickness: 1.0,
                //   dashLength: 4.0,
                //   dashColor: Colors.blue,
                //   dashRadius: 0.0,
                //   dashGapLength: 4.0,
                //   dashGapColor: Colors.transparent,
                //   dashGapRadius: 0.0,
                // ),

                // SizedBox(
                //   height: height - 200,
                //   child:
                //       Consumer<UserProvier>(builder: (_, userProvider, child) {
                //     return ListView.builder(
                //       itemCount: userProvider.clincUser.clincDiags.length,
                //       itemBuilder: (_, index) {
                //         return Card(
                //           child: InkWell(
                //             hoverColor: Colors.grey[300],
                //             // // focusColor: Colors.red,
                //             // overlayColor:
                //             //     MaterialStateProperty.all(Colors.red),
                //             // highlightColor: Colors.red,

                //             onTap: () {},
                //             child: Container(
                //               height: 50,
                //               child: Padding(
                //                 padding: const EdgeInsets.all(8.0),
                //                 child: Row(
                //                   mainAxisAlignment:
                //                       MainAxisAlignment.spaceBetween,
                //                   children: [
                //                     Expanded(
                //                       child: Center(
                //                         child: Text(
                //                           userProvider
                //                               .clincUser.clincDiags[index],
                //                           style: TextStyle(
                //                               fontFamily: 'Cairo',
                //                               fontWeight: FontWeight.bold),
                //                         ),
                //                       ),
                //                     ),
                //                   ],
                //                 ),
                //               ),
                //             ),
                //           ),
                //         );
                //       },
                //     );
                //   }),
                // ),
              ],
            ),
          )
        ]));
  }
}
