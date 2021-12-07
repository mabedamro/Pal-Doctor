import 'package:desktop_version/provider/userProvider.dart';
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
        title: Text(
          'Add Employee',
          style: TextStyle(color: Colors.blue, fontFamily: 'Ubuntu'),
        ),
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
      body: Container(
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
                              labelText: "Employee Name",
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
                                return 'too short password';
                              }

                              return null;
                            },
                            controller: passCon,
                            decoration: new InputDecoration(
                              prefixIcon: Icon(
                                Icons.email,
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
                                return 'password not equals';
                              }

                              return null;
                            },
                            cursorColor: color,
                            decoration: new InputDecoration(
                              prefixIcon: Icon(
                                Icons.email,
                              ),

                              labelText: "Password Confirmation",
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
                                'Permission: ',
                                style: TextStyle(
                                    fontFamily: 'Ubuntu',
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
                                        'Patients',
                                        style: TextStyle(fontFamily: 'Ubuntu'),
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
                                        'Employees',
                                        style: TextStyle(fontFamily: 'Ubuntu'),
                                      ),
                                      Text(
                                        '  Warning : If you checked this box ,the user will be able to add employees.',
                                        style: TextStyle(
                                            fontFamily: 'Ubuntu',
                                            color: Colors.red,
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
                                        'Dates',
                                        style: TextStyle(fontFamily: 'Ubuntu'),
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
                                        'Financial',
                                        style: TextStyle(fontFamily: 'Ubuntu'),
                                      ),
                                      Text(
                                        '  Warning : If you checked this box ,the user will see Financial Information.',
                                        style: TextStyle(
                                            fontFamily: 'Ubuntu',
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
                        if(!isLoading){
                        setState(() {
                          isLoading = true;
                        });
                        if (_formKey.currentState.validate()) {
                          if (!emp && !pat && !fin && !date) {
                            //you have to choose at least one of the permissions.
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'you have to choose at least one of the permissions.'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          } else {
                            bool result = await Provider.of<UserProvier>(
                                    context,
                                    listen: false)
                                .creatEmp(
                                    email: emailCon.text,
                                    pass: passCon.text,
                                    name: nameCon.text,
                                    permission: permission);
                            if (result) {
                              Navigator.of(context).pop();
                            } else {
                              setState(() {
                                isLoading = false;
                              });
                            }
                          }
                        }
                        setState(() {
                          isLoading = false;
                        });}
                      },
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            'Add Employee',
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
                    ),
                  ),
                ),
                isLoading ? CircularProgressIndicator() : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
