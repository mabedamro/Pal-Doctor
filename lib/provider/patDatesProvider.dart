import 'package:desktop_version/models/patDate.dart';
import 'package:desktop_version/provider/dateTimeProvider.dart';
import 'package:desktop_version/provider/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:firedart/firestore/firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class PatDateProvider with ChangeNotifier {
  List<PatDate> patDates = [];

  List<PatDate> tempDates = [];
  Future<void> createDate(PatDate d, {BuildContext context}) async {
    String result = 'fail';
    try {
      var ref = Firestore.instance.collection('dates');

      await ref.document(d.id+DateTime.now().toString()).set(d.toMap).then((value) {
        result = 'success';

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
            createDate(d, context: context);
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
              child: Text('تمت إضافة الموعد بنجاح!')),
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

  Future<void> getDates(String id, BuildContext context) async { //id =  clincId + date
    String result = '';
    try {
      print('sSSSSSSSSSss');
      tempDates.clear();
      var ref = Firestore.instance.collection('dates');
      print(id);
      var data = await ref
          .where('id', isEqualTo: id)
          .get()
          .then((value) {
            print('Data Are Here @');
            for (int i = 0; i < value.length; i++) {
              tempDates.insert(0, PatDate.fromJson(value[i]));
            }
            print('LLLLLLL');
            print(tempDates.length);

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
                getDates(id, context);
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
  Future<void> getDatesPatient(String pid, BuildContext context) async { //id =  clincId + date
    String result = '';
    try {
      print('sSSSSSSSSSss');
      patDates.clear();
      var ref = Firestore.instance.collection('dates');
      print(pid);
      var data = await ref
          .where('pid', isEqualTo: pid)
          .get()
          .then((value) {
            print('Data Are Here @');
            for (int i = 0; i < value.length; i++) {
              patDates.insert(0, PatDate.fromJson(value[i]));
            }
            print('LLLLLLL');
            print(patDates.length);

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
                getDatesPatient(pid, context);
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
}
