import 'package:desktop_version/models/patient.dart';
import 'package:desktop_version/provider/userProvider.dart';
import 'package:desktop_version/screen/patientScreen.dart';
import 'package:flutter/material.dart';
import 'package:firedart/firestore/firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class PatientProvider with ChangeNotifier {
  List<Patient> patients = [];
  List<Patient> searchList = [];

  Future<String> creatPat(Patient p, String empId,{BuildContext context}) async {
    String result = 'fail';
    try {
      var ref = Firestore.instance.collection('patients');

      await ref.document(p.id).set(p.toMap).then((value) {
        result = 'success';
        patients.add(p);
        search('');
        notifyListeners();
      }).catchError((e) async{
        print(e.toString());
        if (e.toString().contains('SocketException')) {
          result = 'internet fail';
        }else if (e.toString().contains('PERMISSION_DENIED') ||
                e.toString().contains('UNAUTHENTICATED')) {
              String result =
                  await Provider.of<UserProvier>(context, listen: false)
                      .tryToLogin();
              if (result == 'success') {
                creatPat( p,  empId,context: context);
              } else {
                Provider.of<UserProvier>(context, listen: false)
                    .signout(context);
              }
            } 
        result = 'fail';
      });

      return result;
    } catch (e) {
      print('EEEEEEEEEE');
      print(e.toString());
      return result;
    }
  }

  Future<void> getPatients(String clincId, BuildContext context) async {
    String result = '';
    try {
      print('sSSSSSSSSSss');
      var ref = Firestore.instance.collection('patients');
      var data = await ref
          .where('clincId', isEqualTo: clincId)
          .get()
          .then((value) {
            patients.clear();

            searchList.clear();
            print('Data Are Here @');
            for (int i = 0; i < value.length; i++) {
              patients.insert(0, Patient.fromJson(value[i]));
              searchList.insert(0, Patient.fromJson(value[i]));
            }
            print(patients.length);

            print('LLLLLLL');
            PatientScreen.isLoading = false;
            notifyListeners();
            result = 'success';
          })
          .timeout(Duration(seconds: 5))
          .catchError((e) async{
            print('FFFFFFFFFFFFFF');
            print(e.toString());
            if (e.toString().contains('TimeoutException')) {
              result = 'internet fail';
            } else if (e.toString().contains('SocketException')) {
              result = 'internet fail';
            }else if (e.toString().contains('PERMISSION_DENIED') ||
                e.toString().contains('UNAUTHENTICATED')) {
              String result =
                  await Provider.of<UserProvier>(context, listen: false)
                      .tryToLogin();
              if (result == 'success') {
                getPatients(clincId,context);
              } else {
                Provider.of<UserProvier>(context, listen: false)
                    .signout(context);
              }
            }  else {
              result = 'fail';
            }
          });
    } catch (e) {
      print(e.toString());
      result = 'fail';
    }

    if (result == 'fail') {
      PatientScreen.isLoading = false;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Directionality(
              textDirection: TextDirection.rtl,
              child: Text('حدث خطأ غير متوقع')),
          backgroundColor: Colors.red,
        ),
      );
    } else if (result == 'internet fail') {
      PatientScreen.isLoading = false;
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

  void search(String text) {
    text = text.toLowerCase();
    searchList.clear();
    if (text == '') {
      print('all patinets');
      searchList = List.from(patients);
    } else {
      print(patients[0].name);
      for (int i = 0; i < patients.length; i++) {
        if ((patients[i].name.toLowerCase() + patients[i].IDNumber).contains(text)) {
          searchList.add(patients[i]);
        }
      }
    }
    print(searchList.length);
    notifyListeners();
  }
}
