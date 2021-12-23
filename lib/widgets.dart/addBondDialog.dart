import 'package:desktop_version/models/bond.dart';
import 'package:desktop_version/models/patient.dart';
import 'package:desktop_version/models/user.dart';
import 'package:desktop_version/provider/bondsProvider.dart';
import 'package:desktop_version/provider/dateTimeProvider.dart';
import 'package:desktop_version/provider/userProvider.dart';
import 'package:desktop_version/screen/employeeScreen.dart';
import 'package:desktop_version/screen/patientScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddBondDialog extends StatefulWidget {
  String type;
  AddBondDialog(this.type);
  @override
  _AddBondDialogState createState() => _AddBondDialogState();
}

class _AddBondDialogState extends State<AddBondDialog> {
  TextEditingController noteController = TextEditingController();
  bool isLoading = false;
  TextEditingController amountController = TextEditingController();
  List<String> kinds = [
    'فاتورة كهرباء',
    'فاتورة مياه',
    'فاتورة إنترنت',
    'إرجاع مرضى',
    'مستلزمات طبية',
    'غير ذلك'
  ];
  String selectedKind = 'لم يتم اختيار نوع الصرف';
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var feildStyle =
        TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold);
    double width = MediaQuery.of(context).size.width;

    double height = MediaQuery.of(context).size.height;
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Consumer<UserProvier>(
          builder: (_, userProvider, child) {
            return AlertDialog(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Row(
                          children: [
                            new Text(
                              widget.type == 'increase' ? "سند قبض" : 'سند صرف',
                              style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25),
                            ),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ],
                ),
                content: SizedBox(
                  width: width / 2,
                  height: 400,
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "التاريخ:  ",
                                style: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              Text(
                                DateTimeProvider.dateAndTime(DateTime.now()),
                                style: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                    fontSize: 20),
                              ),
                            ],
                          ),
                          widget.type == 'increase'
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: TextFormField(
                                    enabled: false,
                                    style: feildStyle,
                                    initialValue:
                                        PatientScreen.selectedPatient.name,
                                    decoration: new InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.account_circle,
                                      ),
                                      labelText: "إسم المريض",

                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(60.0),
                                        // borderSide: BorderSide(color: color),
                                      ),
                                      //fillColor: Colors.green),
                                    ),
                                  ),
                                )
                              : widget.type == 'decrease emp'
                                  ? Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: TextFormField(
                                        enabled: false,
                                        style: feildStyle,
                                        initialValue: EmployeeScreen
                                            .selectedEmployee.name,
                                        decoration: new InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.account_circle,
                                          ),
                                          labelText: "إسم الموظف",

                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                new BorderRadius.circular(60.0),
                                            // borderSide: BorderSide(color: color),
                                          ),
                                          //fillColor: Colors.green),
                                        ),
                                      ),
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 130,
                                          child: PopupMenuButton(
                                              onSelected: (value) {
                                                setState(() {
                                                  selectedKind = kinds[value];
                                                });
                                              },
                                              child: Container(
                                                child: Row(
                                                  children: [
                                                    Icon(Icons
                                                        .keyboard_arrow_down_sharp),
                                                    Text(
                                                      'اختر نوع الصرف',
                                                      style: TextStyle(
                                                          fontFamily: 'Cairo',
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold),
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
                                                    // PopupMenuItem(
                                                    //   child: Center(
                                                    //     child: Text(
                                                    //       'مسحوبات موظفين',
                                                    //       style: TextStyle(
                                                    //           fontFamily: 'Cairo',
                                                    //           fontSize: 15,
                                                    //           fontWeight:
                                                    //               FontWeight.bold),
                                                    //     ),
                                                    //   ),
                                                    //   value: 1,
                                                    // ),
                                                    PopupMenuItem(
                                                      child: Center(
                                                        child: Text(
                                                          kinds[0],
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Cairo',
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                      value: 0,
                                                    ),
                                                    PopupMenuItem(
                                                      child: Center(
                                                        child: Text(
                                                          kinds[1],
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Cairo',
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                      value: 1,
                                                    ),
                                                    PopupMenuItem(
                                                      child: Center(
                                                        child: Text(
                                                          kinds[2],
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Cairo',
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                      value: 2,
                                                    ),
                                                    PopupMenuItem(
                                                      child: Center(
                                                        child: Text(
                                                          kinds[3],
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Cairo',
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                      value: 3,
                                                    ),
                                                    PopupMenuItem(
                                                      child: Center(
                                                        child: Text(
                                                          kinds[4],
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Cairo',
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                      value: 4,
                                                    ),
                                                    PopupMenuItem(
                                                      child: Center(
                                                        child: Text(
                                                          kinds[5],
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Cairo',
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                      value: 5,
                                                    ),
                                                  ]),
                                        ),
                                        Text(
                                          selectedKind,
                                          style: TextStyle(
                                              fontFamily: 'Cairo',
                                              color: Colors.red,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: TextFormField(
                              controller: amountController,
                              style: feildStyle,
                              validator: (val) {
                                try {
                                  double amount = double.parse(trim(val));

                                  return null;
                                } catch (e) {
                                  return 'الإدخال اللذي قمت به غير صالح';
                                }
                              },
                              cursorColor: Colors.blue,
                              decoration: new InputDecoration(
                                prefixIcon: Icon(
                                  Icons.account_circle,
                                ),
                                labelText: "المبلغ",
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(60.0),
                                  borderSide: BorderSide(color: Colors.blue),
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
                            padding: const EdgeInsets.only(top: 15.0),
                            child: TextFormField(
                              controller: noteController,
                              style: feildStyle,
                              cursorColor: Colors.blue,
                              decoration: new InputDecoration(
                                prefixIcon: Icon(
                                  Icons.account_circle,
                                ),
                                labelText: "ملاحظات",
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(60.0),
                                  borderSide: BorderSide(color: Colors.blue),
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
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "توقيع:  ",
                                style: TextStyle(
                                    fontFamily: 'Cairo',
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
                                  if (!isLoading) {
                                    if (_formKey.currentState.validate()) {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      User user = Provider.of<UserProvier>(
                                              context,
                                              listen: false)
                                          .user;

                                      if (widget.type == 'increase') {
                                        Bond b = Bond(
                                            date: DateTime.now(),
                                            uid: user.id,
                                            userName: user.name,
                                            amount: double.parse(
                                                amountController.text),
                                            note: trim(noteController.text),
                                            type: 'increase',
                                            patName: PatientScreen
                                                .selectedPatient.name,
                                            pid: PatientScreen
                                                .selectedPatient.id,
                                            id: user.id +
                                                PatientScreen
                                                    .selectedPatient.id +
                                                DateTime.now().toString());

                                        await Provider.of<BondsProvider>(
                                                context,
                                                listen: false)
                                            .creatBond(b, context: context);
                                      } else if (widget.type ==
                                          'decrease emp') {
                                        Bond b = Bond(
                                            date: DateTime.now(),
                                            uid: user.id,
                                            userName: user.name,
                                            amount: double.parse(
                                                amountController.text),
                                            note: trim(noteController.text),
                                            type: widget.type,
                                            empName: EmployeeScreen
                                                .selectedEmployee.name,
                                            empId: EmployeeScreen
                                                .selectedEmployee.id,
                                            id: user.id +
                                                EmployeeScreen
                                                    .selectedEmployee.id +
                                                DateTime.now().toString());

                                        await Provider.of<BondsProvider>(
                                                context,
                                                listen: false)
                                            .creatBond(b, context: context);
                                      } else if (widget.type == 'decrease') {
                                        if (selectedKind !=
                                            'لم يتم اختيار نوع الصرف') {
                                          Bond b = Bond(
                                              date: DateTime.now(),
                                              uid: user.id,
                                              userName: user.name,
                                              amount: double.parse(
                                                  amountController.text),
                                              note: trim(noteController.text),
                                              type: widget.type,
                                              description: selectedKind,
                                              id: user.id +
                                                  DateTime.now().toString());

                                          await Provider.of<BondsProvider>(
                                                  context,
                                                  listen: false)
                                              .creatBond(b, context: context);
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Directionality(
                                                textDirection:
                                                    TextDirection.rtl,
                                                child: Text(
                                                    'الرجاء اختيار نوع الصرف'),
                                              ),
                                              backgroundColor: Colors.red,
                                            ),
                                          );
                                        }
                                      }
                                      setState(() {
                                        isLoading = false;
                                      });
                                    }
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
