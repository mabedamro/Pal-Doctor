import 'package:desktop_version/provider/employeesProvider.dart';
import 'package:desktop_version/provider/userProvider.dart';
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
    final color = Colors.blue;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // title: Text(
        //   'إضافة موظف',
        //   style: TextStyle(color: Colors.blue, fontFamily: 'Cairo',fontWeight: FontWeight.bold,),
        // ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.blue,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          width: double.infinity,
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Icon(
                    Icons.person,
                    size: 100,
                    color: Colors.blue,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
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
                          //         borderRadius: new BorderRadius.circular(25.0),
                          //         borderSide: BorderSide(color: color),
                          //       ),
                          //       enabledBorder: OutlineInputBorder(
                          //         borderRadius: new BorderRadius.circular(25.0),
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
                              onFieldSubmitted: (val) {
                                FocusScope.of(context).requestFocus(focusEmail);
                              },
                              cursorColor: color,
                              validator: (val) {
                                if (val.length < 5) {
                                  return 'too short name';
                                }
                                return null;
                              },
                              controller: nameCon,
                              decoration: new InputDecoration(
                                prefixIcon: Icon(
                                  Icons.account_circle,
                                ),
                                labelText: "الاسم",
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
                          //         borderRadius: new BorderRadius.circular(25.0),
                          //         borderSide: BorderSide(color: color),
                          //       ),
                          //       enabledBorder: OutlineInputBorder(
                          //         borderRadius: new BorderRadius.circular(25.0),
                          //         // borderSide: BorderSide(color: color),
                          //       ),
                          //       //fillColor: Colors.green),
                          //     ),
                          //   ),
                          // ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              focusNode: focusEmail,
                              onFieldSubmitted: (val) {
                                FocusScope.of(context).requestFocus(focusPass);
                              },
                              controller: emailCon,
                              cursorColor: color,
                              decoration: new InputDecoration(
                                prefixIcon: Icon(
                                  Icons.email,
                                ),

                                labelText: "البريد الإلكتروني",
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
                            child: TextFormField(
                              focusNode: focusPass,
                              onFieldSubmitted: (val) {
                                FocusScope.of(context)
                                    .requestFocus(focusPassConfirm);
                              },
                              obscureText: true,
                              cursorColor: color,
                              validator: (val) {
                                if (val.length < 8) {
                                  return 'كلمة المرور قصيرة جدا';
                                }

                                return null;
                              },
                              controller: passCon,
                              decoration: new InputDecoration(
                                prefixIcon: Icon(
                                  Icons.email,
                                ),
                                labelText: "كلمة المرور",
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
                            child: TextFormField(
                              controller: passConCon,
                              focusNode: focusPassConfirm,
                              obscureText: true,
                              onFieldSubmitted: (val) {
                                // FocusScope.of(context).requestFocus(focus);
                              },
                              validator: (val) {
                                if (passConCon.text != passCon.text) {
                                  return 'كلمة المرور غير متطابقة';
                                }

                                return null;
                              },
                              cursorColor: color,
                              decoration: new InputDecoration(
                                prefixIcon: Icon(
                                  Icons.email,
                                ),

                                labelText: "تأكيد كلمة المرور",
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
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Row(
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
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          ' تحذير : سيكون الموظف قادر على إضافة وحذف موظفين.',
                                          style: TextStyle(
                                              fontFamily: 'Cairo',
                                              color: Colors.red,
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
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
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Row(
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
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          ' تحذير : سيكون الموظف قادر على الوصول للسجل المالي',
                                          style: TextStyle(
                                              fontFamily: 'Cairo',
                                              fontSize: 13,
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
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
                                          clincId: Provider.of<UserProvier>(context,listen: false).user.clincId,
                                            createdById:
                                                FirebaseAuth.instance.userId,
                                            email: emailCon.text,
                                            pass: passCon.text,
                                            name: nameCon.text,
                                            permissions: permission);
                                if (result == 'success') {
                                  Navigator.of(context).pop();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:  Directionality(textDirection: TextDirection.rtl, child:  Text('تمت إضافة الموظف بنجاح !')),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                } else {
                                  if (result == 'INVALID_EMAIL') {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content:  Directionality(textDirection: TextDirection.rtl, child:Text(
                                            'البريد الإلكتروني غير صالح !'),),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                  if (result == 'EMAIL_EXISTS') {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                         content:  Directionality(textDirection: TextDirection.rtl, child: Text(
                                            'البريد الإلكتروني مستخدم بالفعل !'),),
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
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
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
    );
  }
}
