import 'package:desktop_version/models/bond.dart';
import 'package:desktop_version/models/patDate.dart';
import 'package:desktop_version/models/patient.dart';
import 'package:desktop_version/models/user.dart';
import 'package:desktop_version/provider/bondsProvider.dart';
import 'package:desktop_version/provider/darkModeProvider.dart';
import 'package:desktop_version/provider/dateTimeProvider.dart';
import 'package:desktop_version/provider/patDatesProvider.dart';
import 'package:desktop_version/provider/userProvider.dart';
import 'package:desktop_version/screen/employeeScreen.dart';
import 'package:desktop_version/screen/patientScreen.dart';
import 'package:desktop_version/screen/settingsScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddDateDialog extends StatefulWidget {
  AddDateDialog();
  @override
  _AddDateDialogState createState() => _AddDateDialogState();
}

class _AddDateDialogState extends State<AddDateDialog> {
  TextEditingController noteController = TextEditingController();
  bool isLoading = false;

  DateTime selectedDate;

  TimeOfDay selectedTime;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null) {
      selectedDate = picked;
      // _selectTime(context);
    }
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 00, minute: 0),
    );
    if (picked != null) {
      selectedTime = picked;
    }
  }

  @override
  Widget build(BuildContext context) {
    var feildStyle = TextStyle(
      fontFamily: 'Cairo',
      fontWeight: FontWeight.bold,
      color: Provider.of<DarkModeProvider>(context, listen: false).isDark
          ? Colors.white
          : Colors.black,
    );
    double width = MediaQuery.of(context).size.width;

    double height = MediaQuery.of(context).size.height;
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Consumer<UserProvier>(
          builder: (_, userProvider, child) {
            return AlertDialog(
                backgroundColor:
                    Provider.of<DarkModeProvider>(context, listen: false).isDark
                        ? SettingsScreen.darkMode2
                        : Colors.white,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Row(
                          children: [
                            new Text(
                              'إضافة موعد',
                              style: TextStyle(
                                  fontFamily: 'Cairo',
                                  color: Provider.of<DarkModeProvider>(context,
                                              listen: false)
                                          .isDark
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25),
                            ),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                        icon: Icon(Icons.close,color: Provider.of<DarkModeProvider>(context,
                                              listen: false)
                                          .isDark
                                      ? Colors.white
                                      : Colors.black,),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ],
                ),
                content: SizedBox(
                  width: width / 2,
                  height: 400,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                await _selectDate(context);
                                setState(() {});
                              },
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    selectedDate == null
                                        ? 'اختيار تاريح'
                                        : DateTimeProvider.date(selectedDate),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontFamily: 'Cairo',
                                        fontSize: 15),
                                  ),
                                ),
                              ),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.grey),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                await _selectTime(context);
                                setState(() {});
                              },
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    selectedTime == null
                                        ? 'اختيار وقت'
                                        : selectedTime.format(context),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontFamily: 'Cairo',
                                        fontSize: 15),
                                  ),
                                ),
                              ),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.grey),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: TextFormField(
                            enabled: false,
                            style: feildStyle,
                            initialValue: PatientScreen.selectedPatient.name,
                            decoration: new InputDecoration(
                              prefixIcon: Icon(
                                Icons.account_circle,
                                color: Provider.of<DarkModeProvider>(context,
                                            listen: false)
                                        .isDark
                                    ? Colors.white
                                    : Colors.black,
                              ),
                              labelStyle: feildStyle,
                              labelText: "إسم المريض",

                              enabledBorder: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(60.0),
                                // borderSide: BorderSide(color: color),
                              ),
                              //fillColor: Colors.green),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: TextFormField(
                            controller: noteController,
                            style: feildStyle,
                            cursorColor: Colors.blue,
                            decoration: new InputDecoration(
                              prefixIcon: Icon(
                                Icons.account_circle,
                                color: Provider.of<DarkModeProvider>(context,
                                            listen: false)
                                        .isDark
                                    ? Colors.white
                                    : Colors.black,
                              ),
                              labelText: "ملاحظات", labelStyle: feildStyle,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(60.0),
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(60.0),
                                borderSide: BorderSide(
                                  color: Provider.of<DarkModeProvider>(context,
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
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "توقيع:  ",
                              style: TextStyle(
                                  fontFamily: 'Cairo',
                                  color: Provider.of<DarkModeProvider>(context,
                                              listen: false)
                                          .isDark
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            Text(
                              Provider.of<UserProvier>(context, listen: false)
                                  .user
                                  .name,
                              style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                  fontSize: 20),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 80,
                          width: 300,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: ElevatedButton(
                              onPressed: () async {
                                if (selectedTime != null &&
                                    selectedDate != null) {
                                  setState(() {
                                    isLoading = true;
                                  });
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
                                      DateTimeProvider.date(selectedDate) +
                                          ' ' +
                                          hour +
                                          ':' +
                                          min +
                                          ':00';
                                  print(s);

                                  var date = DateTime.parse(s);
                                  var d = PatDate(
                                      clincId: Provider.of<UserProvier>(context,
                                              listen: false)
                                          .user
                                          .clincId,
                                      pid: PatientScreen.selectedPatient.id,
                                      date: date,
                                      note: trim(noteController.text),
                                      id: Provider.of<UserProvier>(context,
                                                  listen: false)
                                              .user
                                              .clincId +
                                          DateTimeProvider.date(date),
                                      empId: Provider.of<UserProvier>(context,
                                              listen: false)
                                          .user
                                          .id,
                                      userName: Provider.of<UserProvier>(
                                              context,
                                              listen: false)
                                          .user
                                          .name,
                                      patName:
                                          PatientScreen.selectedPatient.name);
                                  await Provider.of<PatDateProvider>(context,
                                          listen: false)
                                      .createDate(d, context: context);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: Text(
                                              'عليك اختيار تاريخ ووقت أولا!')),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              },
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: isLoading
                                      ? SizedBox(
                                          width: 30,
                                          height: 30,
                                          child: CircularProgressIndicator(
                                            backgroundColor: Colors.white,
                                          ),
                                        )
                                      : Text(
                                          'إضافة',
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
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ));
          },
        ));
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
