import 'package:desktop_version/provider/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CaseDialog extends StatefulWidget {
  Function onPressed;
  CaseDialog({this.onPressed});
  static List<bool> clincDiagsBools = [];

  static List<bool> clincTestsBools = [];
  @override
  _CaseDialogState createState() => _CaseDialogState();
}

class _CaseDialogState extends State<CaseDialog> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 0;
        i <
            Provider.of<UserProvier>(context, listen: false)
                .clincUser
                .clincDiags
                .length;
        i++) {
      CaseDialog.clincDiagsBools.add(false);
    }
    for (int i = 0;
        i <
            Provider.of<UserProvier>(context, listen: false)
                .clincUser
                .clincTests
                .length;
        i++) {
      CaseDialog.clincTestsBools.add(false);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                            "إضافة تشخيص",
                            style: TextStyle(
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                for (int i = 0;
                                    i < CaseDialog.clincDiagsBools.length;
                                    i++) {
                                  CaseDialog.clincDiagsBools[i] = false;
                                }
                              });
                            },
                            child: SizedBox(
                              width: 100,
                              child: Center(
                                child: Text(
                                  'مسح الكل',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Cairo',
                                      fontSize: 15),
                                ),
                              ),
                            ),
                            style: ButtonStyle(
                              elevation: MaterialStateProperty.all<double>(0),
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
                  width: width / 1.5,
                  height: height / 1.5,
                  child: Column(
                      children: [
                        Expanded(
                         
                          child: GridView.builder(
                            itemCount: userProvider.clincUser.clincDiags.length,
                            itemBuilder: (context, index) {
                              return Row(
                                children: [
                                  Checkbox(
                                      value: CaseDialog.clincDiagsBools[index],
                                      onChanged: (val) {
                                        setState(() {
                                          CaseDialog.clincDiagsBools[index] =
                                              !CaseDialog
                                                  .clincDiagsBools[index];
                                        });
                                      }),
                                  Text(
                                    userProvider.clincUser.clincDiags[index],
                                    style: TextStyle(
                                        fontFamily: 'Cairo',
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              );
                            },
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 5,
                              crossAxisSpacing: 1.0,
                              mainAxisSpacing: 1.0,
                              childAspectRatio: 10,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              'فحوصات \ أشعة',
                              style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  for (int i = 0;
                                      i < CaseDialog.clincTestsBools.length;
                                      i++) {
                                    CaseDialog.clincTestsBools[i] = false;
                                  }
                                });
                              },
                              child: SizedBox(
                                width: 100,
                                child: Center(
                                  child: Text(
                                    'مسح الكل',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Cairo',
                                        fontSize: 15),
                                  ),
                                ),
                              ),
                              style: ButtonStyle(
                                elevation: MaterialStateProperty.all<double>(0),
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
                          ],
                        ),
                        Expanded(
                         
                          child: GridView.builder(
                            itemCount: userProvider.clincUser.clincTests.length,
                            itemBuilder: (context, index) {
                              return Row(
                                children: [
                                  Checkbox(
                                      value: CaseDialog.clincTestsBools[index],
                                      onChanged: (val) {
                                        setState(() {
                                          CaseDialog.clincTestsBools[index] =
                                              !CaseDialog
                                                  .clincTestsBools[index];
                                        });
                                      }),
                                  Text(
                                    userProvider.clincUser.clincTests[index],
                                    style: TextStyle(
                                        fontFamily: 'Cairo',
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              );
                            },
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 5,
                              crossAxisSpacing: 1.0,
                              mainAxisSpacing: 1.0,
                              childAspectRatio: 10,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 500,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: ElevatedButton(
                              onPressed: widget.onPressed,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
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
                  )
            );
          },
        ));
  }
}
