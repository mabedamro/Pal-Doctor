import 'dart:convert';

import 'package:desktop_version/api/authApi.dart';
import 'package:desktop_version/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:firedart/firestore/firestore.dart';
import 'package:flutter/widgets.dart';

class EmployeesProvider with ChangeNotifier {
  List<User> employees = [];

  Future<String> creatEmp(
      {String createdById,
      String name,
      String pass,
      String email,
      String clincId,
      List<String> permissions}) async {
    try {
      var url = Uri.parse(AuthApi.signUp);
      bool result = false;
      var response = await http.post(url, body: {
        'email': email,
        'password': pass,
        'returnSecureToken': 'false',
      });
      Map res = jsonDecode(response.body);

      print(res.toString());
      if (res['error'] == null) {
        var ref = Firestore.instance.collection('users');

        Map<String, dynamic> empData = {
          'clincId': clincId,
          'createdBy': createdById,
          'email': email,
          'id': res['localId'].toString(),
          'isActive': '1',
          'name': name,
          'permission': permissions,
        };
        await ref
            .document(res['localId'].toString())
            .set(empData)
            .then((value) {
          result = true;
          employees.add(User.fromJson({
          'clincId': clincId,
          'createdBy': createdById,
          'email': email,
          'id': res['localId'].toString(),
          'isActive': '1',
          'name': name,
          'permission': permissions,
        }));
          notifyListeners();
        }).catchError((e) {
          print(e.toString());
          result = false;
        });
      } else {
        print('error here');
        print(res['error'].toString());
        return res['error']['message'];
      }
      if (result) return 'success';

      print('heFFFFFFFFFFFFfred');
      return 'false';
    } catch (e) {
      print('EEEEEEEEEE');
      print(e.toString());
      return 'false';
    }
  }

  Future<void> getEmployee(String clincId) async {
    try {
      var ref = Firestore.instance.collection('users');
      var data =
          await ref.where('clincId', isEqualTo: clincId).get().then((value) {
        employees.clear();
        print('Data Are Here @');
        for (int i = 0; i < value.length; i++) {
          employees.insert(0,User.fromJson(value[i]));
        }
        print(employees.length);

         print('LLLLLLL'); 
        notifyListeners();
      }).catchError((e) {
         print('FFFFFFFFFFFFFF'); 
        print(e.toString());


      });
    } catch (e) {
      print(e.toString());
    }
  }
}
