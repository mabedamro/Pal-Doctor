import 'package:desktop_version/models/case.dart';
import 'package:desktop_version/models/patient.dart';
import 'package:desktop_version/provider/dateTimeProvider.dart';
import 'package:desktop_version/provider/patinetProvider.dart';
import 'package:desktop_version/provider/userProvider.dart';
import 'package:desktop_version/widgets.dart/caseDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SessionsScreen extends StatefulWidget {
  @override
  _SessionsScreenState createState() => _SessionsScreenState();
}

class _SessionsScreenState extends State<SessionsScreen> {
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
              'جلسات المريض',
              style: TextStyle(
                  color: Colors.blue,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 8),
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
                                    Provider.of<UserProvier>(context,
                                            listen: false)
                                        .clincUser
                                        .clincDiags
                                        .length;
                                i++) {
                              if (CaseDialog.clincDiagsBools[i]) {
                                diag += Provider.of<UserProvier>(context,
                                            listen: false)
                                        .clincUser
                                        .clincDiags[i] +
                                    ',';
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
                                diag += Provider.of<UserProvier>(context,
                                            listen: false)
                                        .clincUser
                                        .clincTests[i] +
                                    ',';
                              }
                            }
                          },
                        );
                      },
                    );
                  },
                  child: SizedBox(
                    width: 200,
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
            ],
          ),
          body: Container(
            child:ListView.builder(
              itemCount: 10,
              itemBuilder: (context,index){
              return Card(child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('التشخيص:',style: TextStyle(fontFamily: 'Cairo',fontWeight: FontWeight.bold,fontSize: 18),),

                      Text('elbo,head,',style: TextStyle(fontFamily: 'Cairo',fontWeight: FontWeight.bold,fontSize: 15),),

                      Text('الفحوصات \ أشعة:',style: TextStyle(fontFamily: 'Cairo',fontWeight: FontWeight.bold,fontSize: 18),),

                      Text('elbo,head,',style: TextStyle(fontFamily: 'Cairo',fontWeight: FontWeight.bold,fontSize: 15),),
                    ],
                  ),
                  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [

                          Text(' Doctor Name  ',style: TextStyle(fontFamily: 'Cairo',fontWeight: FontWeight.bold,fontSize: 15),),

                          Text(' by  ',style: TextStyle(fontFamily: 'Cairo',fontWeight: FontWeight.bold,fontSize: 15),),

                          Text('10-10-2000',style: TextStyle(fontFamily: 'Cairo',fontWeight: FontWeight.bold,fontSize: 15),),

                        ],
                      ),


                    ],
                  ),
                ],
              ),);
            })
          ),
        ));
  }
}
