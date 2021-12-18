import 'package:desktop_version/models/user.dart';
import 'package:desktop_version/provider/employeesProvider.dart';
import 'package:desktop_version/screen/employeeScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PatientInfoSideContainer extends StatefulWidget {
  static Function setStateForAnimation;
  PatientInfoSideContainer();
  @override
  __PatientInfoSideContainerpertiesState createState() =>
      __PatientInfoSideContainerpertiesState();
}

class __PatientInfoSideContainerpertiesState
    extends State<PatientInfoSideContainer> {
  bool male = true;

  bool female = false;
  bool showSideMenu = false;
  final double _width = 0;
  final double _height = double.infinity;
  final Color _color = Colors.white;
  final BorderRadiusGeometry _borderRadius = BorderRadius.circular(8);

  @override
  Widget build(BuildContext context) {
    print('object');
    final color = Colors.blue;
    PatientInfoSideContainer.setStateForAnimation = setStateToAnimate;

    return AnimatedContainer(
      // Use the properties stored in the State class.
      width: showSideMenu ? MediaQuery.of(context).size.width / 3 : _width,
      height: _height,
      decoration: BoxDecoration(
        color: _color,
        borderRadius: _borderRadius,
      ),
      // Define how long the animation should take.
      duration: const Duration(milliseconds: 300),
      // Provide an optional curve to make the animation feel smoother.
      curve: Curves.fastOutSlowIn,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FittedBox(
                  child: GestureDetector(
                      child: Icon(
                        Icons.close,
                        size: 30,
                      ),
                      onTap: () {
                        setStateToAnimate(false);
                      }),
                ),
              ),
            ],
          ),
          Icon(
            Icons.assignment_ind_rounded,
            size: showSideMenu ? 120 : 0,
            color: Colors.blue,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              onFieldSubmitted: (val) {
                // FocusScope.of(context).requestFocus(focus);
              },
              cursorColor: color,
              decoration: new InputDecoration(
                prefixIcon: Icon(
                  Icons.picture_in_picture_outlined,
                  size: showSideMenu ? 20 : 0,
                ),
                labelText: "ID",
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
              onFieldSubmitted: (val) {
                // FocusScope.of(context).requestFocus(focus);
              },
              cursorColor: color,
              decoration: new InputDecoration(
                prefixIcon: Icon(
                  Icons.account_circle,
                  size: showSideMenu ? 20 : 0,
                ),
                labelText: "Patient Name",
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
                Row(
                  children: [
                    Checkbox(
                        value: male,
                        onChanged: (val) {
                          setState(() {
                            male = val;
                            female = !val;
                          });
                        }),
                    Text(
                      'Male',
                      style: TextStyle(fontFamily: 'Cairo'),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                        value: female,
                        onChanged: (val) {
                          setState(() {
                            female = val;
                            male = !val;
                          });
                        }),
                    Text(
                      'Female',
                      style: TextStyle(fontFamily: 'Cairo'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              onFieldSubmitted: (val) {
                // FocusScope.of(context).requestFocus(focus);
              },
              cursorColor: color,
              decoration: new InputDecoration(
                prefixIcon: Icon(
                  Icons.phone_sharp,
                  size: showSideMenu ? 20 : 0,
                ),
                labelText: "Phone",
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
              onFieldSubmitted: (val) {
                // FocusScope.of(context).requestFocus(focus);
              },
              cursorColor: color,
              decoration: new InputDecoration(
                prefixIcon: Icon(
                  Icons.location_city,
                  size: showSideMenu ? 20 : 0,
                ),
                labelText: "Address",
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
              onFieldSubmitted: (val) {
                // FocusScope.of(context).requestFocus(focus);
              },
              cursorColor: color,
              decoration: new InputDecoration(
                prefixIcon: Icon(
                  Icons.date_range_rounded,
                  size: showSideMenu ? 20 : 0,
                ),
                labelText: "Date Of Birth",
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
              onFieldSubmitted: (val) {
                // FocusScope.of(context).requestFocus(focus);
              },
              cursorColor: color,
              decoration: new InputDecoration(
                prefixIcon: Icon(
                  Icons.medical_services_rounded,
                  size: showSideMenu ? 20 : 0,
                ),
                labelText: "Reffered By",
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
        ],
      ),
    );
  }

  void setStateToAnimate(bool s) {
    setState(() {
      print('object');
      showSideMenu = s;
    });
  }
}

class EmployeeInfoSideContainer extends StatefulWidget {
  EmployeeInfoSideContainer();
  static List<String> permission = [
    '0',
    '0',
    '0',
    '0',
  ];
  static Function setStateForAnimation;
  @override
  __EmployeeInfoSideContainerState createState() =>
      __EmployeeInfoSideContainerState();
}

class __EmployeeInfoSideContainerState
    extends State<EmployeeInfoSideContainer> {
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
    if (EmployeeInfoSideContainer.permission[0] == '1') {
      pat = true;
    } else {
      pat = false;
    }
    if (EmployeeInfoSideContainer.permission[1] == '1') {
      emp = true;
    } else {
      emp = false;
    }
    if (EmployeeInfoSideContainer.permission[2] == '1') {
      date = true;
    } else {
      date = false;
    }
    if (EmployeeInfoSideContainer.permission[3] == '1') {
      fin = true;
    } else {
      fin = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    initPermisions();
    final color = Colors.blue;
    EmployeeInfoSideContainer.setStateForAnimation = setStateToAnimate;
    nameController.text = EmployeeScreen.selectedEmployee.name;
    emailController.text = EmployeeScreen.selectedEmployee.email;
    return AnimatedContainer(
      // Use the properties stored in the State class.
      width: showSideMenu ? MediaQuery.of(context).size.width / 3 : _width,
      height: _height,
      decoration: BoxDecoration(
        color: _color,
        borderRadius: _borderRadius,
      ),
      // Define how long the animation should take.
      duration: const Duration(milliseconds: 300),
      // Provide an optional curve to make the animation feel smoother.
      curve: Curves.fastOutSlowIn,
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
                                        EmployeeInfoSideContainer.permission,
                                        EmployeeScreen.selectedEmployee);
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
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FittedBox(
                  child: GestureDetector(
                      child: Icon(
                        Icons.close,
                        size: 30,
                      ),
                      onTap: () {
                        EmployeeScreen.enableEditing = false;
                        setStateToAnimate(false);
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
              cursorColor: color,
              decoration: new InputDecoration(
                prefixIcon: Icon(
                  Icons.person,
                  size: showSideMenu ? 20 : 0,
                ),
                labelText: "الإسم",
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
              controller: emailController,
              enabled: false,
              onFieldSubmitted: (val) {
                // FocusScope.of(context).requestFocus(focus);
              },
              cursorColor: color,
              decoration: new InputDecoration(
                prefixIcon: Icon(
                  Icons.email,
                  size: showSideMenu ? 20 : 0,
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
                                    EmployeeInfoSideContainer.permission[0] =
                                        '1';
                                  } else {
                                    EmployeeInfoSideContainer.permission[0] =
                                        '0';
                                  }
                                });
                              }
                            }),
                        Text(
                          'الوصول لسجل المرضى',
                          style: TextStyle(
                              fontFamily: 'Cairo', fontWeight: FontWeight.bold),
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
                                  EmployeeInfoSideContainer.permission[1] = '1';
                                } else {
                                  EmployeeInfoSideContainer.permission[1] = '0';
                                }
                              });
                            }
                          },
                        ),
                        Text(
                          'الوصول الى سجل الموظفين',
                          style: TextStyle(
                              fontFamily: 'Cairo', fontWeight: FontWeight.bold),
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
                                    EmployeeInfoSideContainer.permission[2] =
                                        '1';
                                  } else {
                                    EmployeeInfoSideContainer.permission[2] =
                                        '0';
                                  }
                                });
                              }
                            }),
                        Text(
                          'الوصول الى المواعيد',
                          style: TextStyle(
                              fontFamily: 'Cairo', fontWeight: FontWeight.bold),
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
                                    EmployeeInfoSideContainer.permission[3] =
                                        '1';
                                  } else {
                                    EmployeeInfoSideContainer.permission[3] =
                                        '0';
                                  }
                                });
                              }
                            }),
                        Text(
                          'الوصول الى السجل المالي',
                          style: TextStyle(
                              fontFamily: 'Cairo', fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.attach_money,
                          ),
                          Text(
                            'السجل المالي',
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
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Icon(Icons.person_add_disabled),
                          ),
                          Text(
                            'إلغاء تفعيل الموظف',
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
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void setStateToAnimate(bool s) {
    setState(() {
      print('object');
      showSideMenu = s;
    });
  }
}
