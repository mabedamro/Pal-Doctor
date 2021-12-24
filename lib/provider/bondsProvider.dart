import 'package:desktop_version/models/bond.dart';
import 'package:desktop_version/provider/userProvider.dart';
import 'package:desktop_version/screen/finScreen.dart';
import 'package:flutter/material.dart';
import 'package:firedart/firestore/firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class BondsProvider with ChangeNotifier {
  List<Bond> allBonds = [];
  String filterString = '';
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
            filterString = '';

            print('Data Are Here @');
            for (int i = 0; i < value.length; i++) {
              allBonds.insert(0, Bond.fromJson(value[i]));
            }
            print('LLLLLLL');
            FinScreen.isLoading = false;
            notifyListeners();
            result = 'success';
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
