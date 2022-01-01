import 'dart:io';

import 'package:desktop_version/models/patient.dart';
import 'package:desktop_version/provider/bondsProvider.dart';
import 'package:desktop_version/provider/darkModeProvider.dart';
import 'package:desktop_version/provider/dateTimeProvider.dart';
import 'package:desktop_version/provider/userProvider.dart';
import 'package:desktop_version/widgets.dart/addDiagsDialog.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DiagsUserDialog extends StatefulWidget {
  @override
  _DiagsUserDialogState createState() => _DiagsUserDialogState();
}

class _DiagsUserDialogState extends State<DiagsUserDialog> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<void> addDiag(String d) async {
    await Provider.of<UserProvier>(context, listen: false).addDiag(d, context);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
  bool isMobile = Platform.isAndroid || Platform.isIOS;
    double height = MediaQuery.of(context).size.height;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  'تشخيصات العيادة',
                  style: TextStyle(
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.bold,
                      fontSize:isMobile? 15 : 25),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) {
                          return AddDiagDialog();
                        },
                      );
                    },
                    child: Center(
                      child: Padding(
                        padding:isMobile?const EdgeInsets.all(0.0) : const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Icon(Icons.add),
                            Text(
                              'إضافة تشخيص',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontFamily: 'Cairo',
                                  fontSize:isMobile?11 : 15),
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
           isMobile?Container() : IconButton(
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
              Expanded(child: Consumer<UserProvier>(
                  builder: (context, userProvider, child) {
                return Container(
                    height: double.infinity,
                    child: userProvider.clincUser.clincDiags.length == 0
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
                            itemCount: userProvider.clincUser.clincDiags.length,
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
                                                userProvider
                                                    .clincUser.clincDiags[index]
                                                    .toString(),
                                                style: TextStyle(
                                                    fontFamily: 'Cairo',
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Center(
                                              child: IconButton(
                                                icon: Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                ),
                                                onPressed: () {
                                                  Provider.of<UserProvier>(
                                                          context,
                                                          listen: false)
                                                      .deleteDiag(
                                                          userProvider.clincUser
                                                                  .clincDiags[
                                                              index],
                                                          context);
                                                },
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
                          ));
              })),
            ],
          ),
        ),
      ),
    );
  }
}
