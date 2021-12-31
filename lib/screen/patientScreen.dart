import 'dart:io';

import 'package:desktop_version/models/patient.dart';
import 'package:desktop_version/provider/darkModeProvider.dart';
import 'package:desktop_version/provider/patinetProvider.dart';
import 'package:desktop_version/provider/userProvider.dart';
import 'package:desktop_version/screen/addPatientScreen.dart';
import 'package:desktop_version/screen/patientInformationScreen.dart';
import 'package:desktop_version/screen/settingsScreen.dart';
import 'package:desktop_version/widgets.dart/patinetInfoSideContainer.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PatientScreen extends StatefulWidget {
  static bool isLoading = false;
  static Patient selectedPatient;
  static bool enableEditing = false;
  @override
  _PatientScreenState createState() => _PatientScreenState();
}

class _PatientScreenState extends State<PatientScreen>
    with AutomaticKeepAliveClientMixin {
  bool showSideInfo = false;
  int counter = 0;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    PatientScreen.isLoading = true;
    Provider.of<PatientProvider>(context, listen: false).getPatients(
        Provider.of<UserProvier>(context, listen: false).user.clincId, context);
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = Platform.isAndroid || Platform.isIOS;
    double width = MediaQuery.of(context).size.width;
    final tableHeadersStyle =
        TextStyle(color: Colors.blue, fontWeight: FontWeight.bold);
    // return ElevatedButton(onPressed: (){
    //   setState(() {
    //           counter++;
    //         });
    // }, child: Text(counter.toString()));
    return Consumer<DarkModeProvider>(builder: (_, darkModeProvider, child) {
      return Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: isMobile ? width - 42 : 400,
                              height: 50,
                              child: TextField(
                                style: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontWeight: FontWeight.bold,
                                    color: Provider.of<DarkModeProvider>(
                                                context,
                                                listen: false)
                                            .isDark
                                        ? Colors.white
                                        : Colors.black),
                                onSubmitted: (val) {
                                  print('enter button');
                                },
                                onChanged: (val) {
                                  Provider.of<PatientProvider>(context,
                                          listen: false)
                                      .search(val);
                                },
                                controller: searchController,
                                cursorColor: Colors.blue,
                                decoration: new InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: Provider.of<DarkModeProvider>(
                                                context,
                                                listen: false)
                                            .isDark
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                  labelText: "بحث...",
                                  labelStyle: TextStyle(
                                      fontFamily: 'Cairo',
                                      fontWeight: FontWeight.bold,
                                      color: Provider.of<DarkModeProvider>(
                                                  context,
                                                  listen: false)
                                              .isDark
                                          ? Colors.white
                                          : Colors.black),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(100.0),
                                    borderSide: BorderSide(color: Colors.blue),
                                  ),

                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Provider.of<DarkModeProvider>(
                                                    context,
                                                    listen: false)
                                                .isDark
                                            ? Colors.white
                                            : Colors.black),
                                    borderRadius:
                                        new BorderRadius.circular(100.0),
                                    // borderSide: BorderSide(color: color),
                                  ),
                                  //fillColor: Colors.green),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            isMobile
                                ? Container()
                                : ElevatedButton(
                                    onPressed: () {
                                      Provider.of<PatientProvider>(context,
                                              listen: false)
                                          .search(searchController.text);
                                    },
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Row(
                                          children: [
                                            Icon(Icons.search),
                                            Text(
                                              'بحث',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontFamily: 'Cairo',
                                                  fontSize: 15),
                                            ),
                                          ],
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
                                  )
                          ],
                        ),
                        isMobile
                            ? Container()
                            : Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          PatientScreen.isLoading = true;
                                        });
                                        Provider.of<PatientProvider>(context,
                                                listen: false)
                                            .getPatients(
                                                Provider.of<UserProvier>(
                                                        context,
                                                        listen: false)
                                                    .user
                                                    .clincId,
                                                context);
                                        PatientInfoSideContainer
                                            .setStateForAnimation(false);
                                      },
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Row(
                                            children: [
                                              Icon(Icons.refresh),
                                              Text(
                                                'تحد يث',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontFamily: 'Cairo',
                                                    fontSize: 15),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.grey),
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
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AddPatientScreen()),
                                        );
                                      },
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Row(
                                            children: [
                                              Icon(Icons.add),
                                              Text(
                                                'إضافة مريض',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontFamily: 'Cairo',
                                                    fontSize: 15),
                                              ),
                                            ],
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
                                ],
                              )
                      ],
                    ),
                  ),
                ),
                !isMobile
                    ? Container()
                    : Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    PatientScreen.isLoading = true;
                                  });
                                  Provider.of<PatientProvider>(context,
                                          listen: false)
                                      .getPatients(
                                          Provider.of<UserProvier>(context,
                                                  listen: false)
                                              .user
                                              .clincId,
                                          context);
                                  PatientInfoSideContainer.setStateForAnimation(
                                      false);
                                },
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.refresh),
                                        Text(
                                          'تحد يث',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontFamily: 'Cairo',
                                              fontSize: 13),
                                        ),
                                      ],
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
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AddPatientScreen()),
                                  );
                                },
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Row(
                                      children: [
                                        Icon(Icons.add),
                                        Flexible(
                                          child: Text(
                                            'إضافة مريض',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontFamily: 'Cairo',
                                                fontSize: 13),
                                          ),
                                        ),
                                      ],
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
                DottedLine(
                  direction: Axis.horizontal,
                  lineLength: double.infinity,
                  lineThickness: 1.0,
                  dashLength: 4.0,
                  dashColor: Colors.blue,
                  dashRadius: 0.0,
                  dashGapLength: 4.0,
                  dashGapColor: Colors.transparent,
                  dashGapRadius: 0.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Center(
                            child: Text(
                              'الإسم',
                              style: TextStyle(
                                  fontSize: isMobile ? 12 : 14,
                                  color: Colors.blue,
                                  fontFamily: 'Cairo',
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              'رقم الهوية',
                              style: TextStyle(
                                  fontSize: isMobile ? 12 : 14,
                                  color: Colors.blue,
                                  fontFamily: 'Cairo',
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              'تاريخ الإضافة',
                              style: TextStyle(
                                  fontSize: isMobile ? 12 : 14,
                                  color: Colors.blue,
                                  fontFamily: 'Cairo',
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                DottedLine(
                  direction: Axis.horizontal,
                  lineLength: double.infinity,
                  lineThickness: 1.0,
                  dashLength: 4.0,
                  dashColor: Colors.blue,
                  dashRadius: 0.0,
                  dashGapLength: 4.0,
                  dashGapColor: Colors.transparent,
                  dashGapRadius: 0.0,
                ),
                Expanded(
                  child: Consumer<PatientProvider>(
                      builder: (_, patProvider, child) {
                    return PatientScreen.isLoading
                        ? Center(
                            child: SizedBox(
                                height: 50,
                                width: 50,
                                child: CircularProgressIndicator()))
                        : patProvider.searchList.length == 0
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.search,
                                      size: 60,
                                      color: Colors.blue,
                                    ),
                                    Text(
                                      'لا توجد بيانات لعرضها',
                                      style: TextStyle(
                                          color: Provider.of<DarkModeProvider>(
                                                      context,
                                                      listen: false)
                                                  .isDark
                                              ? Colors.white
                                              : Colors.black,
                                          fontFamily: 'Cairo',
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              )
                            : ListView.builder(
                                itemCount: patProvider.searchList.length,
                                itemBuilder: (_, index) {
                                  return Card(
                                    color: Provider.of<DarkModeProvider>(
                                                context,
                                                listen: false)
                                            .isDark
                                        ? SettingsScreen.darkMode2
                                        : Colors.grey[100],
                                    child: InkWell(
                                      hoverColor: Provider.of<DarkModeProvider>(
                                                  context,
                                                  listen: false)
                                              .isDark
                                          ? Colors.grey[700]
                                          : Colors.grey[300],
                                      // // focusColor: Colors.red,
                                      // overlayColor:
                                      //     MaterialStateProperty.all(Colors.red),
                                      // highlightColor: Colors.red,

                                      onTap: () {
                                        PatientScreen.selectedPatient =
                                            patProvider.searchList[index];
                                        if (isMobile) {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PatientInfoScreen()),
                                          );
                                        } else {
                                          PatientInfoSideContainer
                                              .setStateForAnimation(true);
                                        }
                                      },
                                      child: Container(
                                        height: 50,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Center(
                                                  child: Text(
                                                    patProvider
                                                        .searchList[index].name,
                                                    style: TextStyle(
                                                        color: Provider.of<
                                                                        DarkModeProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .isDark
                                                            ? Colors.white
                                                            : Colors.black,
                                                        fontFamily: 'Cairo',
                                                        fontSize:
                                                            isMobile ? 12 : 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Center(
                                                  child: Text(
                                                    patProvider
                                                        .searchList[index]
                                                        .IDNumber,
                                                    style: TextStyle(
                                                        color: Provider.of<
                                                                        DarkModeProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .isDark
                                                            ? Colors.white
                                                            : Colors.black,
                                                        fontSize:
                                                            isMobile ? 12 : 14,
                                                        fontFamily: 'Cairo',
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Center(
                                                  child: Text(
                                                    DateFormat('yyyy-MM-dd')
                                                        .format(patProvider
                                                            .searchList[index]
                                                            .addingDate),
                                                    style: TextStyle(
                                                        color: Provider.of<
                                                                        DarkModeProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .isDark
                                                            ? Colors.white
                                                            : Colors.black,
                                                        fontSize:
                                                            isMobile ? 12 : 14,
                                                        fontFamily: 'Cairo',
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                  }),
                ),
              ],
            ),
          ),
          PatientInfoSideContainer(),
        ],
      );
    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
