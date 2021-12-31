import 'dart:io';

import 'package:desktop_version/models/bond.dart';
import 'package:desktop_version/models/patient.dart';
import 'package:desktop_version/models/user.dart';
import 'package:desktop_version/provider/bondsProvider.dart';
import 'package:desktop_version/provider/darkModeProvider.dart';
import 'package:desktop_version/provider/dateTimeProvider.dart';
import 'package:desktop_version/provider/userProvider.dart';
import 'package:desktop_version/screen/employeeScreen.dart';
import 'package:desktop_version/screen/patientScreen.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PatientBondsDialog extends StatefulWidget {
  Patient p;
  PatientBondsDialog(this.p);
  @override
  _PatientBondsDialogState createState() => _PatientBondsDialogState();
}

class _PatientBondsDialogState extends State<PatientBondsDialog> {
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBondsForPat();
  }

  Future<void> getBondsForPat() async {
    isLoading = true;
    await Provider.of<BondsProvider>(context, listen: false)
        .getBondsForPatients(widget.p, context);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = Platform.isAndroid || Platform.isIOS;
    double width = MediaQuery.of(context).size.width;

    double height = MediaQuery.of(context).size.height;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.p.name,
              style: TextStyle(
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.bold,
                  fontSize: isMobile ? 20 : 25),
            ),
            IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ],
        ),
        content: SizedBox(
          width: width / 1.5,
          height: height / 1.5,
          child: Column(
            children: [
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
                            'المبلغ',
                            style: TextStyle(
                                color: Colors.blue,
                                fontFamily: 'Cairo',
                                fontSize: isMobile ? 11 : 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            'التاريخ',
                            style: TextStyle(
                                color: Colors.blue,
                                fontFamily: 'Cairo',
                                fontSize: isMobile ? 11 : 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            'التوقيع',
                            style: TextStyle(
                                color: Colors.blue,
                                fontFamily: 'Cairo',
                                fontSize: isMobile ? 11 : 14,
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
                child: Container(
                  height: double.infinity,
                  child: Consumer<BondsProvider>(
                      builder: (_, bondsProvider, child) {
                    return isLoading
                        ? Center(
                            child: SizedBox(
                                height: isMobile ? 30 : 50,
                                width: isMobile ? 30 : 50,
                                child: CircularProgressIndicator()))
                        : bondsProvider.patBonds.length == 0
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
                                          fontFamily: 'Cairo',
                                          color: Provider.of<DarkModeProvider>(
                                                      context,
                                                      listen: false)
                                                  .isDark
                                              ? Colors.white
                                              : Colors.black,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              )
                            : ListView.builder(
                                itemCount: bondsProvider.patBonds.length,
                                itemBuilder: (_, index) {
                                  return Card(
                                    child: InkWell(
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
                                                    bondsProvider
                                                        .patBonds[index].amount
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontFamily: 'Cairo',
                                                        fontSize:
                                                            isMobile ? 11 : 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Center(
                                                  child: Text(
                                                    DateTimeProvider.date(
                                                        bondsProvider
                                                            .patBonds[index]
                                                            .date),
                                                    style: TextStyle(
                                                        fontFamily: 'Cairo',
                                                        fontSize:
                                                            isMobile ? 11 : 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Center(
                                                  child: Text(
                                                    bondsProvider
                                                        .patBonds[index]
                                                        .userName,
                                                    style: TextStyle(
                                                        fontFamily: 'Cairo',
                                                        fontSize:
                                                            isMobile ? 11 : 14,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
