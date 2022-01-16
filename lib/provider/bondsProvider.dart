import 'package:desktop_version/models/bond.dart';
import 'package:desktop_version/models/patient.dart';
import 'package:desktop_version/models/user.dart';
import 'package:desktop_version/provider/dateTimeProvider.dart';
import 'package:desktop_version/provider/userProvider.dart';
import 'package:desktop_version/screen/finScreen.dart';
import 'package:flutter/material.dart';
import 'package:firedart/firestore/firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
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
        debugPrint(e.toString());
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
      debugPrint('EEEEEEEEEE');
      debugPrint(e.toString());
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
      debugPrint('sSSSSSSSSSss');
      var ref = Firestore.instance.collection('bonds');
      var data = await ref
          .where('clincId', isEqualTo: clincId)
          .get()
          .then((value) {
            allBonds.clear();

            debugPrint('Data Are Here @');
            for (int i = 0; i < value.length; i++) {
              allBonds.insert(0, Bond.fromJson(value[i]));
            }
            debugPrint('LLLLLLL');
            FinScreen.isLoading = false;
            getSelectedBonds(all: true, today: true);
            result = 'success';
            notifyListeners();
          })
          .timeout(Duration(seconds: 5))
          .catchError((e) async {
            debugPrint('FFFFFFFFFFFFFF');
            debugPrint(e.toString());
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
              } else if (result == 'needUpdate') {
              } else {
                Provider.of<UserProvier>(context, listen: false)
                    .signout(context);
              }
            } else {
              result = 'fail';
            }
          });
    } catch (e) {
      debugPrint(e.toString());
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
      debugPrint('sSSSSSSSSSss');
      var ref = Firestore.instance.collection('bonds');
      var data = await ref
          .where('empId', isEqualTo: emp.id)
          .get()
          .then((value) {
            debugPrint('Data Are Here @');
            for (int i = 0; i < value.length; i++) {
              empBonds.insert(0, Bond.fromJson(value[i]));
            }
            debugPrint(empBonds.length.toString());
            debugPrint('LLLLLLL');
            result = 'success';
            notifyListeners();
          })
          .timeout(Duration(seconds: 5))
          .catchError((e) async {
            debugPrint('FFFFFFFFFFFFFF');
            debugPrint(e.toString());
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
              } else if (result == 'needUpdate') {
                Provider.of<UserProvier>(context, listen: false)
                    .goToUpdateScreen(context);
              } else {
                Provider.of<UserProvier>(context, listen: false)
                    .signout(context);
              }
            } else {
              result = 'fail';
            }
          });
    } catch (e) {
      debugPrint(e.toString());
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
      debugPrint('sSSSSSSSSSss');
      var ref = Firestore.instance.collection('bonds');
      var data = await ref
          .where('pid', isEqualTo: p.id)
          .get()
          .then((value) {
            debugPrint('Data Are Here @');
            for (int i = 0; i < value.length; i++) {
              patBonds.insert(0, Bond.fromJson(value[i]));
            }
            debugPrint('LLLLLLL');
            result = 'success';
            notifyListeners();
          })
          .timeout(Duration(seconds: 5))
          .catchError((e) async {
            debugPrint('FFFFFFFFFFFFFF');
            debugPrint(e.toString());
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
              } else if (result == 'needUpdate') {
                Provider.of<UserProvier>(context, listen: false)
                    .goToUpdateScreen(context);
              } else {
                Provider.of<UserProvier>(context, listen: false)
                    .signout(context);
              }
            } else {
              result = 'fail';
            }
          });
    } catch (e) {
      debugPrint(e.toString());
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
      debugPrint('all incraese');
      for (var i = 0; i < allBonds.length; i++) {
        if (allBonds[i].type == 'increase') {
          typeBonds.add(allBonds[i]);
        }
      }
    } else if (AllDecraese) {
      debugPrint('all decrease');
      for (var i = 0; i < allBonds.length; i++) {
        if (allBonds[i].type.contains('decrease')) {
          typeBonds.add(allBonds[i]);
        }
      }
    } else if (decrease) {
      debugPrint('decrease');
      for (var i = 0; i < allBonds.length; i++) {
        if (allBonds[i].type == 'decrease') {
          typeBonds.add(allBonds[i]);
        }
      }
    } else if (decreaseEmp) {
      debugPrint('decrease employee');
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
      debugPrint('last month');
      for (var i = 0; i < typeBonds.length; i++) {
        debugPrint(typeBonds[i].date.month.toString());
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
    if (DateTime.now().month == 1) {
      int year = DateTime.now().year;
      int month = DateTime.now().month;

      month = 12;
      year -= 1;
      debugPrint(date.month.toString());
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

  Future<void> deleteBond(String bondId, BuildContext context) async {
    String result = '';
    try {
      debugPrint('sSSSSSSSSSss');
      var ref = Firestore.instance.collection('bonds');
      var data = await ref
          .document(bondId)
          .delete()
          .then((value) {
            result = 'success';
          })
          .timeout(Duration(seconds: 5))
          .catchError((e) async {
            debugPrint('FFFFFFFFFFFFFF');
            debugPrint(e.toString());
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
                deleteBond(bondId, context);
              } else if (result == 'needUpdate') {
              } else {
                Provider.of<UserProvier>(context, listen: false)
                    .signout(context);
              }
            } else {
              result = 'fail';
            }
          });
    } catch (e) {
      debugPrint(e.toString());
      result = 'fail';
    }
    if (result == 'success') {
      Navigator.of(context).pop();

      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Directionality(
              textDirection: TextDirection.rtl,
              child: Text('تم حذف السند بنجاح')),
          backgroundColor: Colors.green,
        ),
      );
    } else if (result == 'fail') {
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
  //           debugPrint(e.toString());
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
  //     debugPrint('EEEEEEEEEE');
  //     debugPrint(e.toString());
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
  //     debugPrint('all patinets');
  //     searchList = List.from(patients);
  //   } else {
  //     debugPrint(patients[0].name);
  //     for (int i = 0; i < patients.length; i++) {
  //       if ((patients[i].name.toLowerCase() + patients[i].IDNumber)
  //           .contains(text)) {
  //         searchList.add(patients[i]);
  //       }
  //     }
  //   }
  //   debugPrint(searchList.length);
  //   notifyListeners();
  // }
}
