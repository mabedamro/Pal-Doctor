import 'package:desktop_version/models/patient.dart';
import 'package:desktop_version/screen/patientScreen.dart';
import 'package:flutter/material.dart';
import 'package:firedart/firestore/firestore.dart';
import 'package:flutter/widgets.dart';

class PatientProvider with ChangeNotifier {
  List<Patient> patients = [];
  List<Patient> searchList = [];

  Future<String> creatPat(Patient p, String empId) async {
    String result = 'fail';
    try {
      var ref = Firestore.instance.collection('patients');

      await ref.document(p.id).set(p.toMap).then((value) {
        result = 'success';
        patients.add(p);
        search('');
        notifyListeners();
      }).catchError((e) {
        print(e.toString());
        if (e.toString().contains('SocketException')) {
          result = 'internet fail';
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

  // Future<String> updateEmployee(
  //     String name, List<String> permissions, User emp) async {
  //   try {
  //     var ref = Firestore.instance.collection('patients');
  //     String result = 'false';
  //     Map<String, dynamic> empData = {
  //       'name': name,
  //       'permission': permissions,
  //     };
  //     await ref
  //         .document(emp.id)
  //         .update(empData)
  //         .then((value) {
  //           result = 'success';
  //           emp.name = name;
  //           emp.permission = List.from(permissions);
  //           notifyListeners();
  //         })
  //         .timeout(Duration(seconds: 5))
  //         .catchError((e) {
  //           print('HOOOOOOOn');
  //           print(e.toString());

  //           if (e.toString().contains('TimeoutException')) {
  //             result = 'internet fail';
  //           } else if (e.toString().contains('SocketException')) {
  //             result = 'internet fail';
  //           } else {
  //             result = 'fail';
  //           }
  //         });

  //     return result;
  //   } catch (e) {
  //     print('EEEEEEEEEE');
  //     print(e.toString());
  //     return 'false';
  //   }
  // }

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
          .catchError((e) {
            print('FFFFFFFFFFFFFF');
            print(e.toString());
            if (e.toString().contains('TimeoutException')) {
              result = 'internet fail';
            } else if (e.toString().contains('SocketException')) {
              result = 'internet fail';
            } else {
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
