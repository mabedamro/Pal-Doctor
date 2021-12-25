import 'package:desktop_version/models/bond.dart';
import 'package:desktop_version/models/patient.dart';
import 'package:desktop_version/models/user.dart';
import 'package:desktop_version/provider/dateTimeProvider.dart';
import 'package:desktop_version/provider/userProvider.dart';
import 'package:desktop_version/screen/finScreen.dart';
import 'package:flutter/material.dart';
import 'package:firedart/firestore/firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class BondsProvider with ChangeNotifier {
  List<Bond> allBonds = [];

  List<Bond> empBonds = [];
  List<Bond> patBonds = [];

  double bondsSum = 0;
  List<Bond> tempBonds = [];
  Future<void> creatBond(Bond b, {BuildContext context}) async {
    String result = 'fail';
    try {
      var ref = Firestore.instance.collection('bonds');

      await ref.document(b.id).set(b.toMap).then((value) {
        result = 'success';
        allBonds.insert(0, b);

        // search('');
        notifyListeners();
      }).catchError((e) async {
        print(e.toString());
        if (e.toString().contains('SocketException')) {
          result = 'internet fail';
          return;
        } else if (e.toString().contains('PERMISSION_DENIED') ||
            e.toString().contains('UNAUTHENTICATED')) {
          String result = await Provider.of<UserProvier>(context, listen: false)
              .tryToLogin(context);
          if (result == 'success') {
            creatBond(b, context: context);
          } else {
            Provider.of<UserProvier>(context, listen: false).signout(context);
          }
        }
        result = 'fail';
      });
    } catch (e) {
      print('EEEEEEEEEE');
      print(e.toString());
    }
    if (result == 'success') {
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Directionality(
              textDirection: TextDirection.rtl,
              child: Text('تمت إضافة السند بنجاح!')),
          backgroundColor: Colors.green,
        ),
      );
    } else if (result == 'fail') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Directionality(
              textDirection: TextDirection.rtl,
              child: Text('حدث خطأ غير متوقع')),
          backgroundColor: Colors.red,
        ),
      );
    } else if (result == 'internet fail') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Directionality(
            textDirection: TextDirection.rtl,
            child: Text('تحقق من الاتصال بالإنترنت'),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> getBonds(String clincId, BuildContext context) async {
    String result = '';
    try {
      print('sSSSSSSSSSss');
      var ref = Firestore.instance.collection('bonds');
      var data = await ref
          .where('clincId', isEqualTo: clincId)
          .get()
          .then((value) {
            allBonds.clear();

            print('Data Are Here @');
            for (int i = 0; i < value.length; i++) {
              allBonds.insert(0, Bond.fromJson(value[i]));
            }
            print('LLLLLLL');
            FinScreen.isLoading = false;
            getSelectedBonds(all: true, today: true);
            result = 'success';
            notifyListeners();
          })
          .timeout(Duration(seconds: 5))
          .catchError((e) async {
            print('FFFFFFFFFFFFFF');
            print(e.toString());
            if (e.toString().contains('TimeoutException')) {
              result = 'internet fail';
            } else if (e.toString().contains('SocketException')) {
              result = 'internet fail';
            } else if (e.toString().contains('PERMISSION_DENIED') ||
                e.toString().contains('UNAUTHENTICATED')) {
              String result =
                  await Provider.of<UserProvier>(context, listen: false)
                      .tryToLogin(context);
              if (result == 'success') {
                getBonds(clincId, context);
              } else {
                Provider.of<UserProvier>(context, listen: false)
                    .signout(context);
              }
            } else {
              result = 'fail';
            }
          });
    } catch (e) {
      print(e.toString());
      result = 'fail';
    }

    if (result == 'fail') {
      FinScreen.isLoading = false;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Directionality(
              textDirection: TextDirection.rtl,
              child: Text('حدث خطأ غير متوقع')),
          backgroundColor: Colors.red,
        ),
      );
    } else if (result == 'internet fail') {
      FinScreen.isLoading = false;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Directionality(
            textDirection: TextDirection.rtl,
            child: Text('تحقق من الاتصال بالإنترنت'),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> getBondsForEmp(User emp, BuildContext context) async {
    String result = '';
    try {
      empBonds.clear();
      print('sSSSSSSSSSss');
      var ref = Firestore.instance.collection('bonds');
      var data = await ref
          .where('empId', isEqualTo: emp.id)
          .get()
          .then((value) {
            print('Data Are Here @');
            for (int i = 0; i < value.length; i++) {
              empBonds.insert(0, Bond.fromJson(value[i]));
            }
            print(empBonds.length);
            print('LLLLLLL');
            result = 'success';
            notifyListeners();
          })
          .timeout(Duration(seconds: 5))
          .catchError((e) async {
            print('FFFFFFFFFFFFFF');
            print(e.toString());
            if (e.toString().contains('TimeoutException')) {
              result = 'internet fail';
            } else if (e.toString().contains('SocketException')) {
              result = 'internet fail';
            } else if (e.toString().contains('PERMISSION_DENIED') ||
                e.toString().contains('UNAUTHENTICATED')) {
              String result =
                  await Provider.of<UserProvier>(context, listen: false)
                      .tryToLogin(context);
              if (result == 'success') {
                getBondsForEmp(emp, context);
              } else {
                Provider.of<UserProvier>(context, listen: false)
                    .signout(context);
              }
            } else {
              result = 'fail';
            }
          });
    } catch (e) {
      print(e.toString());
      result = 'fail';
    }

    if (result == 'fail') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Directionality(
              textDirection: TextDirection.rtl,
              child: Text('حدث خطأ غير متوقع')),
          backgroundColor: Colors.red,
        ),
      );
    } else if (result == 'internet fail') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Directionality(
            textDirection: TextDirection.rtl,
            child: Text('تحقق من الاتصال بالإنترنت'),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> getBondsForPatients(Patient p, BuildContext context) async {
    String result = '';
    try {
      patBonds.clear();
      print('sSSSSSSSSSss');
      var ref = Firestore.instance.collection('bonds');
      var data = await ref
          .where('pid', isEqualTo: p.id)
          .get()
          .then((value) {
            print('Data Are Here @');
            for (int i = 0; i < value.length; i++) {
              patBonds.insert(0, Bond.fromJson(value[i]));
            }
            print('LLLLLLL');
            result = 'success';
            notifyListeners();
          })
          .timeout(Duration(seconds: 5))
          .catchError((e) async {
            print('FFFFFFFFFFFFFF');
            print(e.toString());
            if (e.toString().contains('TimeoutException')) {
              result = 'internet fail';
            } else if (e.toString().contains('SocketException')) {
              result = 'internet fail';
            } else if (e.toString().contains('PERMISSION_DENIED') ||
                e.toString().contains('UNAUTHENTICATED')) {
              String result =
                  await Provider.of<UserProvier>(context, listen: false)
                      .tryToLogin(context);
              if (result == 'success') {
                getBondsForPatients(p, context);
              } else {
                Provider.of<UserProvier>(context, listen: false)
                    .signout(context);
              }
            } else {
              result = 'fail';
            }
          });
    } catch (e) {
      print(e.toString());
      result = 'fail';
    }

    if (result == 'fail') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Directionality(
              textDirection: TextDirection.rtl,
              child: Text('حدث خطأ غير متوقع')),
          backgroundColor: Colors.red,
        ),
      );
    } else if (result == 'internet fail') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Directionality(
            textDirection: TextDirection.rtl,
            child: Text('تحقق من الاتصال بالإنترنت'),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void getSelectedBonds({
    bool all,
    bool AllIncrease,
    bool AllDecraese,
    bool decreaseEmp,
    bool decrease,
    bool today,
    bool calculateWithDate,
    bool yesterday,
    bool thisMonth,
    bool lastMonth,
    bool thisYear,
    DateTime fromDate,
    DateTime toDate,
  }) {
    tempBonds.clear();
    List<Bond> typeBonds = [];
    if (all) {
      // bonds = List.from(Provider.of<BondsProvider>(context,listen: false).allBonds);
      typeBonds = allBonds;
    } else if (AllIncrease) {
      print('all incraese');
      for (var i = 0; i < allBonds.length; i++) {
        if (allBonds[i].type == 'increase') {
          typeBonds.add(allBonds[i]);
        }
      }
    } else if (AllDecraese) {
      print('all decrease');
      for (var i = 0; i < allBonds.length; i++) {
        if (allBonds[i].type.contains('decrease')) {
          typeBonds.add(allBonds[i]);
        }
      }
    } else if (decrease) {
      print('decrease');
      for (var i = 0; i < allBonds.length; i++) {
        if (allBonds[i].type == 'decrease') {
          typeBonds.add(allBonds[i]);
        }
      }
    } else if (decreaseEmp) {
      print('decrease employee');
      for (var i = 0; i < allBonds.length; i++) {
        if (allBonds[i].type == 'decrease emp') {
          typeBonds.add(allBonds[i]);
        }
      }
    }

    if (today) {
      for (var i = 0; i < typeBonds.length; i++) {
        if (DateTimeProvider.date(typeBonds[i].date) ==
            DateTimeProvider.date(DateTime.now())) {
          tempBonds.add(typeBonds[i]);
        }
      }
    } else if (yesterday) {
      for (var i = 0; i < typeBonds.length; i++) {
        if (daysBetween(typeBonds[i].date, DateTime.now()) == 1) {
          tempBonds.add(typeBonds[i]);
        }
      }
    } else if (thisMonth) {
      for (var i = 0; i < typeBonds.length; i++) {
        if (isInThisMonth(typeBonds[i].date, DateTime.now())) {
          tempBonds.add(typeBonds[i]);
        }
      }
    } else if (lastMonth) {
      for (var i = 0; i < typeBonds.length; i++) {
        if (isInLastMonth(typeBonds[i].date)) {
          tempBonds.add(typeBonds[i]);
        }
      }
    } else if (thisYear) {
      for (var i = 0; i < typeBonds.length; i++) {
        if (typeBonds[i].date.year == DateTime.now().year) {
          tempBonds.add(typeBonds[i]);
        }
      }
    } else if (calculateWithDate) {
      for (var i = 0; i < typeBonds.length; i++) {
        if (DateTime(typeBonds[i].date.year, typeBonds[i].date.month,
                        typeBonds[i].date.day)
                    .difference(fromDate)
                    .inDays >=
                0 &&
            DateTime(typeBonds[i].date.year, typeBonds[i].date.month,
                        typeBonds[i].date.day)
                    .difference(toDate)
                    .inDays <=
                0) {
          tempBonds.add(typeBonds[i]);
        }
      }
    }
    calculateAmount();
  }

  bool isInThisMonth(DateTime to, DateTime from) {
    if (to.year == from.year && to.month == from.month) {
      return true;
    }
    return false;
  }

  bool isInLastMonth(DateTime date) {
    if (date.month == 1) {
      int year = DateTime.now().year;
      int month = DateTime.now().month;

      month -= 1;
      year -= 1;
      if (date.year == year && date.month == month) {
        return true;
      } else {
        return false;
      }
    } else {
      int year = DateTime.now().year;
      int month = DateTime.now().month;

      month -= 1;
      if (date.year == year && date.month == month) {
        return true;
      } else {
        return false;
      }
    }
  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  void calculateAmount() {
    bondsSum = 0;
    for (var i = 0; i < tempBonds.length; i++) {
      if (tempBonds[i].type == 'increase') {
        bondsSum += tempBonds[i].amount;
      } else {
        bondsSum -= tempBonds[i].amount;
      }
    }
  }

  // Future<String> updatePat(Patient p, {BuildContext context}) async {
  //   String result = 'fail';
  //   try {
  //     var ref = Firestore.instance.collection('patients');
  //     await ref
  //         .document(p.id)
  //         .update(p.toMap)
  //         .then((value) {
  //           result = 'success';

  //           notifyListeners();
  //         })
  //         .timeout(Duration(seconds: 5))
  //         .catchError((e) async {
  //           print(e.toString());
  //           if (e.toString().contains('TimeoutException')) {
  //             result = 'internet fail';
  //             return;
  //           } else if (e.toString().contains('SocketException')) {
  //             result = 'internet fail';
  //             return;
  //           } else if (e.toString().contains('PERMISSION_DENIED') ||
  //               e.toString().contains('UNAUTHENTICATED')) {
  //             String result =
  //                 await Provider.of<UserProvier>(context, listen: false)
  //                     .tryToLogin(context);
  //             if (result == 'success') {
  //               updatePat(p, context: context);
  //             } else {
  //               Provider.of<UserProvier>(context, listen: false)
  //                   .signout(context);
  //             }
  //           }
  //           result = 'fail';
  //         });
  //   } catch (e) {
  //     print('EEEEEEEEEE');
  //     print(e.toString());
  //     result = 'fail';
  //   }
  //   if (result == 'success') {
  //     CaseDialog.noteController.text = '';
  //     for (int i = 0; i < CaseDialog.clincDiagsBools.length; i++) {
  //       CaseDialog.clincDiagsBools[i] = false;
  //     }
  //     for (int i = 0; i < CaseDialog.clincTestsBools.length; i++) {
  //       CaseDialog.clincTestsBools[i] = false;
  //     }
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Directionality(
  //             textDirection: TextDirection.rtl,
  //             child: Text('تم تحديث معلومات المريض!')),
  //         backgroundColor: Colors.green,
  //       ),
  //     );
  //   } else if (result == 'fail') {
  //     PatientScreen.isLoading = false;
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Directionality(
  //             textDirection: TextDirection.rtl,
  //             child: Text('حدث خطأ غير متوقع')),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //   } else if (result == 'internet fail') {
  //     PatientScreen.isLoading = false;
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Directionality(
  //           textDirection: TextDirection.rtl,
  //           child: Text('تحقق من الاتصال بالإنترنت'),
  //         ),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //   }
  //   return result;
  // }

  // void search(String text) {
  //   text = text.toLowerCase();
  //   searchList.clear();
  //   if (text == '') {
  //     print('all patinets');
  //     searchList = List.from(patients);
  //   } else {
  //     print(patients[0].name);
  //     for (int i = 0; i < patients.length; i++) {
  //       if ((patients[i].name.toLowerCase() + patients[i].IDNumber)
  //           .contains(text)) {
  //         searchList.add(patients[i]);
  //       }
  //     }
  //   }
  //   print(searchList.length);
  //   notifyListeners();
  // }
}
