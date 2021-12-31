import 'dart:io';

import 'package:desktop_version/models/case.dart';
import 'package:desktop_version/provider/darkModeProvider.dart';
import 'package:desktop_version/provider/dateTimeProvider.dart';
import 'package:desktop_version/provider/patinetProvider.dart';
import 'package:desktop_version/provider/userProvider.dart';
import 'package:desktop_version/screen/patientScreen.dart';
import 'package:desktop_version/screen/settingsScreen.dart';
import 'package:desktop_version/widgets.dart/caseDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SessionsScreen extends StatefulWidget {
  @override
  _SessionsScreenState createState() => _SessionsScreenState();
}

class _SessionsScreenState extends State<SessionsScreen> {
  List<Case> cases = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    cases = List.from(PatientScreen.selectedPatient.cases);
    double width = MediaQuery.of(context).size.width;
    bool isMobile = Platform.isAndroid || Platform.isIOS;
    final color = Colors.blue;
    var feildStyle =
        TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold);
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          floatingActionButton: isMobile?  FloatingActionButton(onPressed: (){
 showDialog(
                      context: context,
                      builder: (_) {
                        return CaseDialog(
                          onPressed: () async {
                            List<String> diags = [];
                            List<String> tests = [];
                            for (int i = 0;
                                i <
                                    Provider.of<UserProvier>(context,
                                            listen: false)
                                        .clincUser
                                        .clincDiags
                                        .length;
                                i++) {
                              if (CaseDialog.clincDiagsBools[i]) {
                                diags.add(Provider.of<UserProvier>(context,
                                        listen: false)
                                    .clincUser
                                    .clincDiags[i]);
                              }
                            }
                            for (int i = 0;
                                i <
                                    Provider.of<UserProvier>(context,
                                            listen: false)
                                        .clincUser
                                        .clincTests
                                        .length;
                                i++) {
                              if (CaseDialog.clincTestsBools[i]) {
                                tests.add(Provider.of<UserProvier>(context,
                                        listen: false)
                                    .clincUser
                                    .clincTests[i]);
                              }
                            }
                            Case newCase = Case(
                              diags: diags,
                              tests: tests,
                              id: Provider.of<UserProvier>(context,
                                      listen: false)
                                  .user
                                  .id,
                              notes: CaseDialog.noteController.text,
                              userName: Provider.of<UserProvier>(context,
                                      listen: false)
                                  .user
                                  .name,
                              uid: Provider.of<UserProvier>(context,
                                      listen: false)
                                  .user
                                  .id,
                            );
                            PatientScreen.selectedPatient.cases
                                .insert(0, newCase);
                            String result = await Provider.of<PatientProvider>(
                                    context,
                                    listen: false)
                                .updatePat(PatientScreen.selectedPatient,
                                    context: context);
                            if (result == 'success') {
                              Navigator.of(context).pop();
                              setState(() {});
                            }
                          },
                        );
                      },
                    );
          },child: Icon(Icons.add),) : Container(),
          backgroundColor:
              Provider.of<DarkModeProvider>(context, listen: false).isDark
                  ? SettingsScreen.darkMode1
                  : Colors.white,
          appBar: AppBar(
            leading: Container(),
            centerTitle: true,
            title: Text(
                    'جلسات المريض',
                    style: TextStyle(
                        color: Colors.blue,
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.bold),
                  ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
             isMobile? Container() : Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 8),
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) {
                        return CaseDialog(
                          onPressed: () async {
                            List<String> diags = [];
                            List<String> tests = [];
                            for (int i = 0;
                                i <
                                    Provider.of<UserProvier>(context,
                                            listen: false)
                                        .clincUser
                                        .clincDiags
                                        .length;
                                i++) {
                              if (CaseDialog.clincDiagsBools[i]) {
                                diags.add(Provider.of<UserProvier>(context,
                                        listen: false)
                                    .clincUser
                                    .clincDiags[i]);
                              }
                            }
                            for (int i = 0;
                                i <
                                    Provider.of<UserProvier>(context,
                                            listen: false)
                                        .clincUser
                                        .clincTests
                                        .length;
                                i++) {
                              if (CaseDialog.clincTestsBools[i]) {
                                tests.add(Provider.of<UserProvier>(context,
                                        listen: false)
                                    .clincUser
                                    .clincTests[i]);
                              }
                            }
                            Case newCase = Case(
                              diags: diags,
                              tests: tests,
                              id: Provider.of<UserProvier>(context,
                                      listen: false)
                                  .user
                                  .id,
                              notes: CaseDialog.noteController.text,
                              userName: Provider.of<UserProvier>(context,
                                      listen: false)
                                  .user
                                  .name,
                              uid: Provider.of<UserProvier>(context,
                                      listen: false)
                                  .user
                                  .id,
                            );
                            PatientScreen.selectedPatient.cases
                                .insert(0, newCase);
                            String result = await Provider.of<PatientProvider>(
                                    context,
                                    listen: false)
                                .updatePat(PatientScreen.selectedPatient,
                                    context: context);
                            if (result == 'success') {
                              Navigator.of(context).pop();
                              setState(() {});
                            }
                          },
                        );
                      },
                    );
                  },
                  child: SizedBox(
                    width: isMobile ? width / 2 - 35 : 200,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'إضافة جلسة',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Cairo',
                                fontSize: 15),
                          ),
                          Icon(Icons.add)
                        ],
                      ),
                    ),
                  ),
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all<double>(0),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: SizedBox(
                    width: isMobile ? 40 : 200,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                         isMobile?Container() :  Text(
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
            ],
          ),
          body: Center(
            child: Container(
                width:isMobile? MediaQuery.of(context).size.width:  MediaQuery.of(context).size.width / 1.5,
                child: ListView.builder(
                    itemCount: cases.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Provider.of<DarkModeProvider>(context,
                                    listen: false)
                                .isDark
                            ? SettingsScreen.darkMode2
                            : Colors.grey[100],
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'التشخيص: ',
                                        style: TextStyle(
                                            fontFamily: 'Cairo',
                                            fontWeight: FontWeight.bold,
                                            fontSize:isMobile?15 : 18,
                                            color: Colors.red),
                                      ),
                                      Text(
                                        cases[index].diagsToString,
                                        style: TextStyle(
                                            fontFamily: 'Cairo',
                                            color:
                                                Provider.of<DarkModeProvider>(
                                                            context,
                                                            listen: false)
                                                        .isDark
                                                    ? Colors.white
                                                    : Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: isMobile? 12:15),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'الفحوصات / أشعة: ',
                                        style: TextStyle(
                                          fontFamily: 'Cairo',
                                          fontWeight: FontWeight.bold,
                                          fontSize: isMobile?15 :18,
                                          color: Colors.red,
                                        ),
                                      ),
                                      Text(
                                        cases[index].testsToString,
                                        style: TextStyle(
                                            fontFamily: 'Cairo',
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Provider.of<DarkModeProvider>(
                                                            context,
                                                            listen: false)
                                                        .isDark
                                                    ? Colors.white
                                                    : Colors.black,
                                            fontSize: isMobile? 12:15),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'ملاحظات: ',
                                        style: TextStyle(
                                          fontFamily: 'Cairo',
                                          fontWeight: FontWeight.bold,
                                          fontSize:isMobile?12 : 15,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Text(
                                        cases[index].notes,
                                        style: TextStyle(
                                            fontFamily: 'Cairo',
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Provider.of<DarkModeProvider>(
                                                            context,
                                                            listen: false)
                                                        .isDark
                                                    ? Colors.white
                                                    : Colors.black,
                                            fontSize:isMobile? 12: 15),
                                      ),
                                    ],
                                  ),
                                   Row(
                                    children: [
                                        Text(
                                        ' توقيع  ',
                                        style: TextStyle(
                                            fontFamily: 'Cairo',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                      Text(
                                        cases[index].userName+'   ',
                                        style: TextStyle(
                                            fontFamily: 'Cairo',
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue,
                                            fontSize: 15),
                                      ),
                                    
                                      Text(
                                        DateTimeProvider.dateAndTime(
                                            cases[index].date),
                                        style: TextStyle(
                                            fontFamily: 'Cairo',
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Provider.of<DarkModeProvider>(
                                                            context,
                                                            listen: false)
                                                        .isDark
                                                    ? Colors.white
                                                    : Colors.black,
                                            fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                 
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    })),
          ),
        ));
  }
}
