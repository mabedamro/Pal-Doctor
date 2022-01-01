import 'dart:io';

import 'package:desktop_version/models/patDate.dart';
import 'package:desktop_version/models/user.dart';
import 'package:desktop_version/provider/darkModeProvider.dart';
import 'package:desktop_version/provider/dateTimeProvider.dart';
import 'package:desktop_version/provider/employeesProvider.dart';
import 'package:desktop_version/provider/patDatesProvider.dart';
import 'package:desktop_version/provider/patinetProvider.dart';
import 'package:desktop_version/provider/userProvider.dart';
import 'package:desktop_version/screen/employeeScreen.dart';
import 'package:desktop_version/screen/patientScreen.dart';
import 'package:desktop_version/screen/sessionsScreen.dart';
import 'package:desktop_version/screen/settingsScreen.dart';
import 'package:desktop_version/widgets.dart/addBondDialog.dart';
import 'package:desktop_version/widgets.dart/addDateDialog.dart';
import 'package:desktop_version/widgets.dart/caseDialog.dart';
import 'package:desktop_version/widgets.dart/checkBoxForSideWidget.dart';
import 'package:desktop_version/widgets.dart/employeeBondsDialog.dart';
import 'package:desktop_version/widgets.dart/patientBonds.dart';
import 'package:desktop_version/widgets.dart/patientDatesDialog.dart';
import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PatientInfoScreen extends StatefulWidget {
  PatientInfoScreen();
  @override
  __PatientInfoScreenpertiesState createState() =>
      __PatientInfoScreenpertiesState();
}

class __PatientInfoScreenpertiesState extends State<PatientInfoScreen> {
  List<String> diags = [];

  List<String> tests = [];
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController cityController = TextEditingController(text: 'الخليل');
  TextEditingController diagsController = TextEditingController();

  TextEditingController idNumberController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController adressController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController refferController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  bool male = true;

  bool female = false;

  final focusName = FocusNode();

  final focusPhone = FocusNode();

  final focusAdress = FocusNode();

  final focusCity = FocusNode();

  final focusAge = FocusNode();

  final focusRefferFrom = FocusNode();

  final focusDiag = FocusNode();

  final focusRays = FocusNode();

  final focusNotes = FocusNode();
  bool showSideMenu = false;

  DateTime selectedDate = DateTime.now();

  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  final double _width = 0;
  final double _height = double.infinity;
  final Color _color = Colors.white;
  final BorderRadiusGeometry _borderRadius = BorderRadius.circular(8);

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null) {
      selectedDate = picked;
      _selectTime(context);
    }
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null) {
      selectedTime = picked;
      String hour = '';
      String min = '';
      if (selectedTime.hour < 10) {
        hour = '0' + selectedTime.hour.toString();
      } else {
        hour = selectedTime.hour.toString();
      }

      if (selectedTime.minute < 10) {
        min = '0' + selectedTime.minute.toString();
      } else {
        min = selectedTime.minute.toString();
      }
      String s =
          DateTimeProvider.date(selectedDate) + ' ' + hour + ':' + min + ':00';
      print(s);

      var date = DateTime.parse(s);
      var d = PatDate(
          clincId:
              Provider.of<UserProvier>(context, listen: false).user.clincId,
          pid: PatientScreen.selectedPatient.id,
          date: date,
          note: '',
          id: Provider.of<UserProvier>(context, listen: false).user.clincId +
              DateTimeProvider.date(date),
          empId: Provider.of<UserProvier>(context, listen: false).user.id);
      await Provider.of<PatDateProvider>(context, listen: false)
          .createDate(d, context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    showSideMenu = true;
    bool isMobile = Platform.isAndroid || Platform.isIOS;
    if (PatientScreen.selectedPatient == null) {
      idNumberController.text = '';
      CheckBoxForSideContainer.male = true;
      CheckBoxForSideContainer.female = false;
      nameController.text = '';
      phoneController.text = '';
      cityController.text = '';
      adressController.text = '';
      refferController.text = '';
      ageController.text = '';

      noteController.text = '';
    } else {
      idNumberController.text = PatientScreen.selectedPatient.IDNumber;

      if (PatientScreen.selectedPatient.sex) {
        male = true;
        female = false;
      } else {
        male = false;
        female = true;
      }
      nameController.text = PatientScreen.selectedPatient.name;
      phoneController.text = PatientScreen.selectedPatient.phone;
      cityController.text = PatientScreen.selectedPatient.city;
      adressController.text = PatientScreen.selectedPatient.address;
      refferController.text = PatientScreen.selectedPatient.refferedFrom;
      ageController.text = PatientScreen.selectedPatient.age;

      CheckBoxForSideContainer.male = PatientScreen.selectedPatient.sex;
      CheckBoxForSideContainer.female = !PatientScreen.selectedPatient.sex;
      noteController.text = PatientScreen.selectedPatient.notes;
    }
    var feildStyle = TextStyle(
      fontFamily: 'Cairo',
      fontWeight: FontWeight.bold,
      color: Provider.of<DarkModeProvider>(context, listen: false).isDark
          ? Colors.white
          : Colors.black,
    );
    print('object');
    final color = Colors.blue;
    double width = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Provider.of<DarkModeProvider>(context,
                                                    listen: false)
                                                .isDark?SettingsScreen.darkMode1:Colors.grey[100],
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (PatientScreen.enableEditing) {
                                      if (_formKey.currentState.validate()) {
                                        if (!isLoading) {
                                          setState(() {
                                            isLoading = true;
                                          });

                                          PatientScreen.selectedPatient.IDNumber =
                                              trim(idNumberController.text);
                                          PatientScreen.selectedPatient.name =
                                              trim(nameController.text);
                                          PatientScreen.selectedPatient.sex = male;
                                          PatientScreen.selectedPatient.phone =
                                              trim(phoneController.text);
                                          PatientScreen.selectedPatient.city =
                                              trim(cityController.text);

                                          PatientScreen.selectedPatient.address =
                                              trim(adressController.text);
                                          PatientScreen.selectedPatient.age =
                                              trim(ageController.text);
                                          PatientScreen
                                                  .selectedPatient.refferedFrom =
                                              trim(refferController.text);
                                          PatientScreen.selectedPatient.notes =
                                              trim(noteController.text);
                                          PatientScreen.selectedPatient.sex =
                                              CheckBoxForSideContainer.male;

                                          String result =
                                              await Provider.of<PatientProvider>(
                                                      context,
                                                      listen: false)
                                                  .updatePat(
                                                      PatientScreen.selectedPatient,
                                                      context: context);
                                          if (result == 'success') {
                                            CheckBoxForSideContainer.male = true;
                                            CheckBoxForSideContainer.female = false;
                                            setState(() {
                                              isLoading = false;
                                              PatientScreen.enableEditing =
                                                  !PatientScreen.enableEditing;
                                            });
                                          } else {
                                            setState(() {
                                              isLoading = false;
                                            });
                                          }
                                        }
                                      }
                                    } else {
                                      setState(() {
                                        isLoading = false;
                                        PatientScreen.enableEditing =
                                            !PatientScreen.enableEditing;
                                      });
                                    }
                                  },
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                        children: [
                                          Icon(
                                            PatientScreen.enableEditing
                                                ? Icons.refresh
                                                : Icons.edit,
                                            size: showSideMenu ? 20 : 0,
                                          ),
                                          Text(
                                            PatientScreen.enableEditing
                                                ? 'تحديث معلومات المريض'
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
                                        PatientScreen.enableEditing
                                            ? Colors.blue
                                            : Colors.grey),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // GestureDetector(

                              //   child: Container(
                              //     child: Row(
                              //       children: [
                              //         Icon(Icons.keyboard_arrow_down_sharp),
                              //         Text('المزيد',style: TextStyle(fontFamily: 'Cairo',fontSize: 15,fontWeight: FontWeight.bold),),
                              //       ],
                              //     ),
                              //   ),
                              // )
                              PatientScreen.enableEditing
                                  ? Container()
                                  : PopupMenuButton(
                                      onSelected: (value) async {
                                        if (value == 2) {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SessionsScreen()),
                                          );
                                        } else if (value == 3) {
                                          showDialog(
                                            context: context,
                                            builder: (_) {
                                              return AddBondDialog('increase');
                                            },
                                          );
                                        } else if (value == 4) {
                                          showDialog(
                                            context: context,
                                            builder: (_) {
                                              return PatientBondsDialog(
                                                  PatientScreen.selectedPatient);
                                            },
                                          );
                                        } else if (value == 1) {
                                          showDialog(
                                            context: context,
                                            builder: (_) {
                                              return AddDateDialog();
                                            },
                                          );
                                        } else if (value == 5) {
                                          showDialog(
                                            context: context,
                                            builder: (_) {
                                              return PatientDatesDialog(
                                                  PatientScreen.selectedPatient);
                                            },
                                          );
                                        }
                                      },
                                      child: Container(
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.keyboard_arrow_down_sharp,
                                              color: Provider.of<DarkModeProvider>(
                                                          context,
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
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(Icons.add),
                                                  Text(
                                                    'إضافة موعد',
                                                    style: TextStyle(
                                                        fontFamily: 'Cairo',
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              value: 1,
                                            ),
                                            PopupMenuItem(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                      Icons.calendar_today_rounded),
                                                  Text(
                                                    'عرض المواعيد',
                                                    style: TextStyle(
                                                        fontFamily: 'Cairo',
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              value: 5,
                                            ),
                                            PopupMenuItem(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(Icons.assignment),
                                                  Text(
                                                    'عرض الجلسات',
                                                    style: TextStyle(
                                                        fontFamily: 'Cairo',
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              value: 2,
                                            ),
                                            PopupMenuItem(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(Icons.add),
                                                  Text(
                                                    'إضافة دفعة',
                                                    style: TextStyle(
                                                        fontFamily: 'Cairo',
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              value: 3,
                                            ),
                                            PopupMenuItem(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(Icons.attach_money),
                                                  Text(
                                                    'عرض السجل المالي',
                                                    style: TextStyle(
                                                        fontFamily: 'Cairo',
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              value: 4,
                                            )
                                          ]),
                            ],
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
                                color: Provider.of<DarkModeProvider>(context,
                                            listen: false)
                                        .isDark
                                    ? Colors.white
                                    : Colors.black,
                                // size:showSideMenu ? 30 : 0,
                              ),
                              onTap: () {
                                PatientScreen.enableEditing = false;
                                // setStateToAnimate(false);
                                Navigator.of(context).pop();
                              }),
                        ),
                      ),
                    ],
                  ),
                  Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.all(15),
                          width:isMobile? width :  width - width / 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.assignment_ind_rounded,
                                size: showSideMenu ? 80 : 0,
                                color: Colors.blue,
                              ),

                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: TextFormField(
                                  enabled: PatientScreen.enableEditing,
                                  controller: idNumberController,
                                  onFieldSubmitted: (val) {
                                    FocusScope.of(context).requestFocus(focusName);
                                  },
                                  validator: (val) {
                                    try {
                                      int id = int.parse(trim(val));

                                      if (trim(val).length != 9) {
                                        return 'الإدخال اللذي قمت به ليس رقم هوية';
                                      } else {
                                        return null;
                                      }
                                    } catch (e) {
                                      return 'الإدخال اللذي قمت به ليس رقم هوية';
                                    }
                                  },
                                  cursorColor: color,
                                  style: feildStyle,
                                  decoration: new InputDecoration(
                                    labelStyle: feildStyle,
                                    prefixIcon: Icon(
                                      Icons.picture_in_picture_outlined,
                                      color: Provider.of<DarkModeProvider>(context,
                                                  listen: false)
                                              .isDark
                                          ? Colors.white
                                          : Colors.black,
                                      size: showSideMenu ? 30 : 0,
                                    ),
                                    labelText: "رقم الهوية",
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: new BorderRadius.circular(60.0),
                                      borderSide: BorderSide(color: color),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: new BorderRadius.circular(60.0),
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
                                padding: const EdgeInsets.only(top: 8.0),
                                child: TextFormField(
                                  enabled: PatientScreen.enableEditing,
                                  controller: nameController,
                                  focusNode: focusName,
                                  style: feildStyle,
                                  onFieldSubmitted: (val) {
                                    FocusScope.of(context).requestFocus(focusPhone);
                                  },
                                  validator: (val) {
                                    if (trim(val).length < 5) {
                                      return 'الاسم قصير جدا';
                                    } else {
                                      return null;
                                    }
                                  },
                                  cursorColor: color,
                                  decoration: new InputDecoration(
                                    labelStyle: feildStyle,
                                    prefixIcon: Icon(
                                      Icons.account_circle,
                                      color: Provider.of<DarkModeProvider>(context,
                                                  listen: false)
                                              .isDark
                                          ? Colors.white
                                          : Colors.black,
                                      size: showSideMenu ? 30 : 0,
                                    ),
                                    labelText: "إسم المريض",
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: new BorderRadius.circular(60.0),
                                      borderSide: BorderSide(color: color),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: new BorderRadius.circular(60.0),
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
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: CheckBoxForSideContainer()),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: TextFormField(
                                  enabled: PatientScreen.enableEditing,
                                  controller: phoneController,
                                  onFieldSubmitted: (val) {
                                    FocusScope.of(context).requestFocus(focusCity);
                                  },
                                  validator: (val) {
                                    try {
                                      int id = int.parse(trim(val));

                                      if (trim(val).length != 10) {
                                        return 'ليس رقم هاتف';
                                      } else {
                                        return null;
                                      }
                                    } catch (e) {
                                      return 'ليس رقم هاتف';
                                    }
                                  },
                                  style: feildStyle,
                                  focusNode: focusPhone,
                                  cursorColor: color,
                                  decoration: new InputDecoration(
                                    labelStyle: feildStyle,
                                    prefixIcon: Icon(
                                      Icons.phone_sharp,
                                      color: Provider.of<DarkModeProvider>(context,
                                                  listen: false)
                                              .isDark
                                          ? Colors.white
                                          : Colors.black,
                                      size: showSideMenu ? 30 : 0,
                                    ),
                                    labelText: "رقم الهاتف",
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: new BorderRadius.circular(60.0),
                                      borderSide: BorderSide(color: color),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: new BorderRadius.circular(60.0),
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
                              Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: TextFormField(
                                        enabled: PatientScreen.enableEditing,
                                        onFieldSubmitted: (val) {
                                          FocusScope.of(context)
                                              .requestFocus(focusAdress);
                                        },
                                        style: feildStyle,
                                        cursorColor: color,
                                        focusNode: focusCity,
                                        validator: (val) {
                                          if (trim(val) == '') {
                                            return 'لا يمكنك ترك هذا الحقل فارغاَ';
                                          } else {
                                            return null;
                                          }
                                        },
                                        controller: cityController,
                                        decoration: new InputDecoration(
                                          labelStyle: feildStyle,
                                          prefixIcon: Icon(
                                            Icons.gps_fixed,
                                            color: Provider.of<DarkModeProvider>(
                                                        context,
                                                        listen: false)
                                                    .isDark
                                                ? Colors.white
                                                : Colors.black,
                                            size: showSideMenu ? 30 : 0,
                                          ),

                                          labelText: "المدينة",
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
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: TextFormField(
                                        enabled: PatientScreen.enableEditing,
                                        controller: adressController,
                                        onFieldSubmitted: (val) {
                                          FocusScope.of(context)
                                              .requestFocus(focusAge);
                                        },
                                        validator: (val) {
                                          if (trim(val) == '') {
                                            return 'لا يمكنك ترك هذا الحقل فارغاَ';
                                          } else {
                                            return null;
                                          }
                                        },
                                        style: feildStyle,
                                        cursorColor: color,
                                        focusNode: focusAdress,
                                        decoration: new InputDecoration(
                                          labelStyle: feildStyle,
                                          prefixIcon: Icon(
                                            Icons.location_city,
                                            color: Provider.of<DarkModeProvider>(
                                                        context,
                                                        listen: false)
                                                    .isDark
                                                ? Colors.white
                                                : Colors.black,
                                            size: showSideMenu ? 30 : 0,
                                          ),
                                          labelText: "العنوان",

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
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: TextFormField(
                                  enabled: PatientScreen.enableEditing,
                                  controller: ageController,
                                  onFieldSubmitted: (val) {
                                    FocusScope.of(context)
                                        .requestFocus(focusRefferFrom);
                                  },
                                  validator: (val) {
                                    try {
                                      int id = int.parse(trim(val));

                                      return null;
                                    } catch (e) {
                                      return 'القيمة المدخلة ليست عمراَ';
                                    }
                                  },
                                  style: feildStyle,
                                  cursorColor: color,
                                  focusNode: focusAge,
                                  decoration: new InputDecoration(
                                    labelStyle: feildStyle,
                                    prefixIcon: Icon(
                                      Icons.date_range_rounded,
                                      color: Provider.of<DarkModeProvider>(context,
                                                  listen: false)
                                              .isDark
                                          ? Colors.white
                                          : Colors.black,
                                      size: showSideMenu ? 30 : 0,
                                    ),
                                    labelText: "العمر (سنة)",
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: new BorderRadius.circular(60.0),
                                      borderSide: BorderSide(color: color),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: new BorderRadius.circular(60.0),
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
                                padding: const EdgeInsets.only(top: 8.0),
                                child: TextFormField(
                                  enabled: PatientScreen.enableEditing,
                                  controller: refferController,
                                  onFieldSubmitted: (val) {
                                    FocusScope.of(context).requestFocus(focusDiag);
                                  },
                                  style: feildStyle,
                                  cursorColor: color,
                                  focusNode: focusRefferFrom,
                                  decoration: new InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.medical_services_rounded,
                                      color: Provider.of<DarkModeProvider>(context,
                                                  listen: false)
                                              .isDark
                                          ? Colors.white
                                          : Colors.black,
                                      size: showSideMenu ? 30 : 0,
                                    ),
                                    labelText: "محول من", labelStyle: feildStyle,
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: new BorderRadius.circular(60.0),
                                      borderSide: BorderSide(color: color),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: new BorderRadius.circular(60.0),
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
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  // SizedBox(
                                  //   width: width / 2,
                                  //   child: Row(
                                  //     children: [
                                  //       Expanded(
                                  //         child: Padding(
                                  //           padding: const EdgeInsets.only(top: 8.0),
                                  //           child: ElevatedButton(
                                  //             onPressed: () {
                                  //               showDialog(
                                  //                 context: context,
                                  //                 builder: (_) {
                                  //                   return CaseDialog(
                                  //                     onPressed: () { },
                                  //                   );
                                  //                 },
                                  //               );
                                  //             },
                                  //             child: Center(
                                  //               child: Padding(
                                  //                 padding: const EdgeInsets.all(16.0),
                                  //                 child: Text(
                                  //                   'إضافة تشخيص',
                                  //                   style: TextStyle(
                                  //                       color: Colors.white,
                                  //                       fontWeight: FontWeight.bold,
                                  //                       fontFamily: 'Cairo',
                                  //                       fontSize: 15),
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //             style: ButtonStyle(
                                  //               shape: MaterialStateProperty.all<
                                  //                   RoundedRectangleBorder>(
                                  //                 RoundedRectangleBorder(
                                  //                   borderRadius:
                                  //                       BorderRadius.circular(50.0),
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //           ),
                                  //         ),
                                  //       ),
                                  //       SizedBox(
                                  //         width: 10,
                                  //       ),
                                  //       Expanded(
                                  //         child: Padding(
                                  //           padding: const EdgeInsets.only(top: 8.0),
                                  //           child: TextFormField(
                                  //             controller: diagsController,
                                  //             enabled: false,
                                  //             onFieldSubmitted: (val) {
                                  //               FocusScope.of(context)
                                  //                   .requestFocus(focusRays);
                                  //             },
                                  //             style: feildStyle,
                                  //             cursorColor: color,
                                  //             focusNode: focusDiag,
                                  //             decoration: new InputDecoration(
                                  //               prefixIcon: Icon(Icons.assignment),
                                  //               labelText: "التشخيص",
                                  //               focusedBorder: OutlineInputBorder(
                                  //                 borderRadius:
                                  //                     new BorderRadius.circular(60.0),
                                  //                 borderSide:
                                  //                     BorderSide(color: color),
                                  //               ),
                                  //               disabledBorder: OutlineInputBorder(
                                  //                 borderRadius:
                                  //                     new BorderRadius.circular(60.0),
                                  //                 // borderSide: BorderSide(color: color),
                                  //               ),
                                  //               enabledBorder: OutlineInputBorder(
                                  //                 borderRadius:
                                  //                     new BorderRadius.circular(60.0),
                                  //                 // borderSide: BorderSide(color: color),
                                  //               ),
                                  //               //fillColor: Colors.green),
                                  //             ),
                                  //           ),
                                  //         ),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),

                                  // Padding(
                                  //   padding: const EdgeInsets.only(top: 8.0),
                                  //   child: TextFormField(
                                  //     onFieldSubmitted: (val) {
                                  //       FocusScope.of(context).requestFocus(focusNotes);
                                  //     },
                                  //     style: feildStyle,
                                  //     cursorColor: color,
                                  //     focusNode: focusRays,
                                  //     decoration: new InputDecoration(
                                  //       prefixIcon: Icon(
                                  //         Icons.account_circle,
                                  //       ),
                                  //       labelText: "فحوصات/ أشعة",
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
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: TextFormField(
                                      enabled: PatientScreen.enableEditing,
                                      controller: noteController,
                                      onFieldSubmitted: (val) {
                                        // FocusScope.of(context).requestFocus(focus);
                                      },
                                      style: feildStyle,
                                      focusNode: focusNotes,
                                      cursorColor: color,
                                      decoration: new InputDecoration(
                                        labelStyle: feildStyle,
                                        prefixIcon: Icon(
                                          Icons.account_circle,
                                          color: Provider.of<DarkModeProvider>(
                                                      context,
                                                      listen: false)
                                                  .isDark
                                              ? Colors.white
                                              : Colors.black,
                                          size: showSideMenu ? 30 : 0,
                                        ),
                                        labelText: "ملاحظات حول المريض",
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
                                ],
                              ),
                              // SizedBox(
                              //   width: 500,
                              //   child: Padding(
                              //     padding: const EdgeInsets.only(top: 8.0),
                              //     child: ElevatedButton(
                              //       onPressed: () async {
                              // if (!isLoading) {
                              //   if (_formKey.currentState.validate()) {
                              //     Patient p = Patient(
                              //       id: Provider.of<UserProvier>(context,
                              //                   listen: false)
                              //               .user
                              //               .id +
                              //           DateTime.now().toString(),
                              //       IDNumber: trim(idNumberController.text),
                              //       name: trim(nameController.text),
                              //       addingDate: DateTime.now(),
                              //       address: trim(adressController.text),
                              //       age: trim(ageController.text),
                              //       city: trim(cityController.text),
                              //       clincId: Provider.of<UserProvier>(context,
                              //               listen: false)
                              //           .user
                              //           .clincId,
                              //       notes: trim(noteController.text),
                              //       phone: trim(phoneController.text),
                              //       refferedFrom: trim(refferController.text),
                              //       sex: male,
                              //       cases: isWithCase()
                              //           ? [
                              //               Case(
                              //                   diags: diags,
                              //                   tests: tests,
                              //                   id: Provider.of<UserProvier>(
                              //                           context,
                              //                           listen: false)
                              //                       .user
                              //                       .id,
                              //                   notes: ''),
                              //             ]
                              //           : [],
                              //     );
                              //     setState(() {
                              //       isLoading = true;
                              //     });
                              //     String result =
                              //         await Provider.of<PatientProvider>(
                              //                 context,
                              //                 listen: false)
                              //             .creatPat(
                              //                 p,
                              //                 Provider.of<UserProvier>(context,
                              //                         listen: false)
                              //                     .user
                              //                     .id);

                              //     if (result == 'success') {
                              //       diags.clear();
                              //       tests.clear();
                              //       CaseDialog.clincDiagsBools.clear();
                              //       CaseDialog.clincTestsBools.clear();
                              //       ScaffoldMessenger.of(context).showSnackBar(
                              //         const SnackBar(
                              //           content: Directionality(
                              //               textDirection: TextDirection.rtl,
                              //               child: Text(
                              //                   'تمت إضافة المريض بنجاح !')),
                              //           backgroundColor: Colors.green,
                              //         ),
                              //       );
                              //       setState(() {
                              //         isLoading = false;
                              //       });
                              //       Navigator.of(context).pop();
                              //     } else if (result == 'fail') {
                              //       ScaffoldMessenger.of(context).showSnackBar(
                              //         const SnackBar(
                              //           content: Directionality(
                              //               textDirection: TextDirection.rtl,
                              //               child: Text('حدث خطأ غير متوقع!')),
                              //           backgroundColor: Colors.red,
                              //         ),
                              //       );
                              //       setState(() {
                              //         isLoading = false;
                              //       });
                              //     } else if (result == 'internet fail') {
                              //       ScaffoldMessenger.of(context).showSnackBar(
                              //         const SnackBar(
                              //           content: Directionality(
                              //             textDirection: TextDirection.rtl,
                              //             child:
                              //                 Text('تحقق من الاتصال بالإنترنت'),
                              //           ),
                              //           backgroundColor: Colors.red,
                              //         ),
                              //       );

                              //     }
                              //   }
                              // }
                              //       },
                              //       child: Center(
                              //         child: Padding(
                              //           padding: const EdgeInsets.all(12.0),
                              //           child:Text(
                              //                   'إضافة المريض',
                              //                   style: TextStyle(
                              //                       color: Colors.white,
                              //                       fontWeight: FontWeight.bold,
                              //                       fontFamily: 'Cairo',
                              //                       fontSize: 15),
                              //                 ),
                              //         ),
                              //       ),
                              //       style: ButtonStyle(
                              //         backgroundColor:
                              //             MaterialStateProperty.all(Colors.green),
                              //         shape: MaterialStateProperty.all<
                              //             RoundedRectangleBorder>(
                              //           RoundedRectangleBorder(
                              //             borderRadius: BorderRadius.circular(50.0),
                              //           ),
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              SizedBox(
                                width: 30,
                              ),
                              SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
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
