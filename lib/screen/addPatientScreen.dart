import 'package:desktop_version/models/case.dart';
import 'package:desktop_version/models/patient.dart';
import 'package:desktop_version/provider/dateTimeProvider.dart';
import 'package:desktop_version/provider/patinetProvider.dart';
import 'package:desktop_version/provider/userProvider.dart';
import 'package:desktop_version/widgets.dart/caseDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AddPatientScreen extends StatefulWidget {
  @override
  _AddPatientScreenState createState() => _AddPatientScreenState();
}

class _AddPatientScreenState extends State<AddPatientScreen> {
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
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final color = Colors.blue;
    var feildStyle =
        TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold);
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            leading: Container(),
            centerTitle: true,
            title: Text(
              'إضافة مريض',
              style: TextStyle(
                  color: Colors.blue,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.bold),
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
                      width: 200,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
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
                        padding: const EdgeInsets.only(right: 16),
                        child: Row(
                          children: [
                            Text(
                              DateTimeProvider.dateNow(),
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 18),
                            ),
                            Text(
                              '    ' + DateTimeProvider.timeNow(),
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: TextFormField(
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
                            prefixIcon: Icon(Icons.picture_in_picture_outlined),
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
                                  'ذكر',
                                  style: feildStyle,
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
                                  'أنثى',
                                  style: feildStyle,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: TextFormField(
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
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: TextFormField(
                                controller: adressController,
                                onFieldSubmitted: (val) {
                                  FocusScope.of(context).requestFocus(focusAge);
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
                          SizedBox(
                            width: width / 2,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (_) {
                                            return CaseDialog(
                                              onPressed: () {
                                                String diag = '';
                                                for (int i = 0;
                                                    i <
                                                        Provider.of<UserProvier>(
                                                                context,
                                                                listen: false)
                                                            .clincUser
                                                            .clincDiags
                                                            .length;
                                                    i++) {
                                                  if (CaseDialog
                                                      .clincDiagsBools[i]) {
                                                    diag +=
                                                        Provider.of<UserProvier>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .clincUser
                                                                .clincDiags[i] +
                                                            ',';
                                                  }
                                                }
                                                for (int i = 0;
                                                    i <
                                                        Provider.of<UserProvier>(
                                                                context,
                                                                listen: false)
                                                            .clincUser
                                                            .clincTests
                                                            .length;
                                                    i++) {
                                                  if (CaseDialog
                                                      .clincTestsBools[i]) {
                                                    diag +=
                                                        Provider.of<UserProvier>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .clincUser
                                                                .clincTests[i] +
                                                            ',';
                                                  }
                                                }
                                                diagsController.text = diag;
                                                Navigator.of(context).pop();
                                              },
                                            );
                                          },
                                        );
                                      },
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Text(
                                            'إضافة جلسة',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Cairo',
                                                fontSize: 15),
                                          ),
                                        ),
                                      ),
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: TextFormField(
                                      controller: diagsController,
                                      enabled: false,
                                      onFieldSubmitted: (val) {
                                        FocusScope.of(context)
                                            .requestFocus(focusRays);
                                      },
                                      style: feildStyle,
                                      cursorColor: color,
                                      focusNode: focusDiag,
                                      decoration: new InputDecoration(
                                        prefixIcon: Icon(Icons.assignment),
                                        labelText: "التشخيص",
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              new BorderRadius.circular(60.0),
                                          borderSide: BorderSide(color: color),
                                        ),
                                        disabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              new BorderRadius.circular(60.0),
                                          // borderSide: BorderSide(color: color),
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
                          ),

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
                        ],
                      ),
                      SizedBox(
                        width: 500,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: ElevatedButton(
                            onPressed: () async {
                              if (!isLoading) {
                                if (_formKey.currentState.validate()) {
                                  Patient p = Patient(
                                    createdById: Provider.of<UserProvier>(
                                            context,
                                            listen: false)
                                        .user
                                        .id,
                                    id: Provider.of<UserProvier>(context,
                                                listen: false)
                                            .user
                                            .id +
                                        DateTime.now().toString(),
                                    IDNumber: trim(idNumberController.text),
                                    name: trim(nameController.text),
                                    addingDate: DateTime.now(),
                                    address: trim(adressController.text),
                                    age: trim(ageController.text),
                                    city: trim(cityController.text),
                                    clincId: Provider.of<UserProvier>(context,
                                            listen: false)
                                        .user
                                        .clincId,
                                    notes: trim(noteController.text),
                                    phone: trim(phoneController.text),
                                    refferedFrom: trim(refferController.text),
                                    sex: male,
                                    cases: isWithCase()
                                        ? [
                                            Case(
                                              diags: diags,
                                              tests: tests,
                                              id: Provider.of<UserProvier>(
                                                      context,
                                                      listen: false)
                                                  .user
                                                  .id,
                                              notes: '',
                                              userName:
                                                  Provider.of<UserProvier>(
                                                          context,
                                                          listen: false)
                                                      .user
                                                      .name,
                                              uid: Provider.of<UserProvier>(
                                                      context,
                                                      listen: false)
                                                  .user
                                                  .id,
                                            ),
                                          ]
                                        : [],
                                  );
                                  setState(() {
                                    isLoading = true;
                                  });
                                  String result =
                                      await Provider.of<PatientProvider>(
                                              context,
                                              listen: false)
                                          .creatPat(p, context: context);

                                  if (result == 'success') {
                                    diags.clear();
                                    tests.clear();
                                    CaseDialog.clincDiagsBools.clear();
                                    CaseDialog.clincTestsBools.clear();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: Text(
                                                'تمت إضافة المريض بنجاح !')),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                    setState(() {
                                      isLoading = false;
                                    });
                                    Navigator.of(context).pop();
                                  } else if (result == 'fail') {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: Text('حدث خطأ غير متوقع!')),
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
                                          child:
                                              Text('تحقق من الاتصال بالإنترنت'),
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
                            },
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: isLoading
                                    ? SizedBox(
                                        width: 30,
                                        height: 30,
                                        child: CircularProgressIndicator(
                                          backgroundColor: Colors.white,
                                        ),
                                      )
                                    : Text(
                                        'إضافة المريض',
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
        ));
  }

  bool isWithCase() {
    for (var i = 0; i < CaseDialog.clincDiagsBools.length; i++) {
      if (CaseDialog.clincDiagsBools[i]) {
        for (var i = 0; i < CaseDialog.clincDiagsBools.length; i++) {
          if (CaseDialog.clincDiagsBools[i]) {
            diags.add(Provider.of<UserProvier>(context, listen: false)
                .clincUser
                .clincDiags[i]);
          }
        }
        for (var i = 0; i < CaseDialog.clincTestsBools.length; i++) {
          if (CaseDialog.clincTestsBools[i]) {
            tests.add(Provider.of<UserProvier>(context, listen: false)
                .clincUser
                .clincTests[i]);
          }
        }

        return true;
      }
    }
    for (var i = 0; i < CaseDialog.clincTestsBools.length; i++) {
      if (CaseDialog.clincTestsBools[i]) {
        for (var i = 0; i < CaseDialog.clincDiagsBools.length; i++) {
          if (CaseDialog.clincDiagsBools[i]) {
            diags.add(Provider.of<UserProvier>(context, listen: false)
                .clincUser
                .clincDiags[i]);
          }
        }
        for (var i = 0; i < CaseDialog.clincTestsBools.length; i++) {
          if (CaseDialog.clincTestsBools[i]) {
            tests.add(Provider.of<UserProvier>(context, listen: false)
                .clincUser
                .clincTests[i]);
          }
        }
        return true;
      }
    }
    return false;
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
