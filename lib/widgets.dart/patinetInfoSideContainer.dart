import 'package:desktop_version/models/patDate.dart';
import 'package:desktop_version/models/user.dart';
import 'package:desktop_version/provider/dateTimeProvider.dart';
import 'package:desktop_version/provider/employeesProvider.dart';
import 'package:desktop_version/provider/patDatesProvider.dart';
import 'package:desktop_version/provider/patinetProvider.dart';
import 'package:desktop_version/provider/userProvider.dart';
import 'package:desktop_version/screen/employeeScreen.dart';
import 'package:desktop_version/screen/patientScreen.dart';
import 'package:desktop_version/screen/sessionsScreen.dart';
import 'package:desktop_version/widgets.dart/addBondDialog.dart';
import 'package:desktop_version/widgets.dart/addDateDialog.dart';
import 'package:desktop_version/widgets.dart/caseDialog.dart';
import 'package:desktop_version/widgets.dart/checkBoxForSideWidget.dart';
import 'package:desktop_version/widgets.dart/employeeBondsDialog.dart';
import 'package:desktop_version/widgets.dart/patientBonds.dart';
import 'package:desktop_version/widgets.dart/patientDatesDialog.dart';
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
    var feildStyle =
        TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold);
    print('object');
    final color = Colors.blue;
    PatientInfoSideContainer.setStateForAnimation = setStateToAnimate;
    double width = MediaQuery.of(context).size.width;
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
      child: SingleChildScrollView(
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
                                    PatientScreen.selectedPatient.refferedFrom =
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
                                  }else if (value == 5) {
                                    showDialog(
                                      context: context,
                                      builder: (_) {
                                        return PatientDatesDialog(PatientScreen.selectedPatient);
                                      },
                                    );
                                  }
                                },
                                child: Container(
                                  child: Row(
                                    children: [
                                      Icon(Icons.keyboard_arrow_down_sharp),
                                      Text(
                                        'المزيد',
                                        style: TextStyle(
                                            fontFamily: 'Cairo',
                                            fontSize: 15,
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
                                                  fontWeight: FontWeight.bold),
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
                                            Icon(Icons.calendar_today_rounded),
                                            Text(
                                              'عرض المواعيد',
                                              style: TextStyle(
                                                  fontFamily: 'Cairo',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
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
                                                  fontWeight: FontWeight.bold),
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
                                                  fontWeight: FontWeight.bold),
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
                                                  fontWeight: FontWeight.bold),
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
                          size: 30,
                        ),
                        onTap: () {
                          PatientScreen.enableEditing = false;
                          setStateToAnimate(false);
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
                    color: Colors.white,
                    padding: EdgeInsets.all(15),
                    width: width - width / 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.assignment_ind_rounded,
                          size: 120,
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
                              prefixIcon:
                                  Icon(Icons.picture_in_picture_outlined),
                              labelText: "رقم الهوية",
                              focusedBorder: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(60.0),
                                borderSide: BorderSide(color: color),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(60.0),
                                // borderSide: BorderSide(color: color),
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
                              prefixIcon: Icon(
                                Icons.account_circle,
                              ),
                              labelText: "إسم المريض",
                              focusedBorder: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(60.0),
                                borderSide: BorderSide(color: color),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(60.0),
                                // borderSide: BorderSide(color: color),
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
                              prefixIcon: Icon(
                                Icons.phone_sharp,
                              ),
                              labelText: "رقم الهاتف",
                              focusedBorder: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(60.0),
                                borderSide: BorderSide(color: color),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(60.0),
                                // borderSide: BorderSide(color: color),
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
                                    prefixIcon: Icon(
                                      Icons.gps_fixed,
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
                                      // borderSide: BorderSide(color: color),
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
                                    prefixIcon: Icon(
                                      Icons.location_city,
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
                                      // borderSide: BorderSide(color: color),
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
                              prefixIcon: Icon(
                                Icons.date_range_rounded,
                              ),
                              labelText: "العمر (سنة)",
                              focusedBorder: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(60.0),
                                borderSide: BorderSide(color: color),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(60.0),
                                // borderSide: BorderSide(color: color),
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
                              prefixIcon: Icon(Icons.medical_services_rounded),
                              labelText: "محول من",
                              focusedBorder: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(60.0),
                                borderSide: BorderSide(color: color),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(60.0),
                                // borderSide: BorderSide(color: color),
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
                                  prefixIcon: Icon(
                                    Icons.account_circle,
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
                                    // borderSide: BorderSide(color: color),
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
                  PatientScreen.enableEditing
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
                            }
                          },
                          child: Container(
                            child: Row(
                              children: [
                                Icon(Icons.keyboard_arrow_down_sharp),
                                Text(
                                  'المزيد',
                                  style: TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 15,
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
                                        'إلغاء تفعيل الموظف',
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
    );
  }

  void setStateToAnimate(bool s) {
    setState(() {
      print('object');
      showSideMenu = s;
    });
  }
}
