import 'dart:convert';

import 'package:desktop_version/api/authApi.dart';
import 'package:desktop_version/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firedart/firestore/firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:table_calendar/table_calendar.dart';

class EmployeesProvider with ChangeNotifier {
  List<User> employees = [];
  List<User> searchList = [];

  Future<String> creatEmp(
      {String createdById,
      String name,
      String pass,
      String email,
      String clincId,
      List<String> permissions}) async {
    String result = 'fail';
    try {
      var url = Uri.parse(AuthApi.signUp);
      var response = await http.post(url, body: {
        'email': email,
        'password': pass,
        'returnSecureToken': 'false',
      }).catchError((e) {
        if (e.toString().contains('SocketException')) {
          result = 'internet fail';
        }
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
          result = 'success';
          employees.add(User.fromJson({
            'clincId': clincId,
            'createdBy': createdById,
            'email': email,
            'id': res['localId'].toString(),
            'isActive': '1',
            'name': name,
            'permission': permissions,
          }));
          search('');
          notifyListeners();
        }).catchError((e) {
          print(e.toString());
          if (e.toString().contains('SocketException')) {
            result = 'internet fail';
          }
          result = 'fail';
        });
      } else {
        print('error here');
        print(res['error'].toString());

        return res['error']['message'];
      }

      return result;
    } catch (e) {
      print('EEEEEEEEEE');
      print(e.toString());
      return result;
    }
  }

  Future<String> updateEmployee(
      String name, List<String> permissions, User emp) async {
    try {
      var ref = Firestore.instance.collection('users');
      String result = 'false';
      Map<String, dynamic> empData = {
        'name': name,
        'permission': permissions,
      };
      await ref
          .document(emp.id)
          .update(empData)
          .then((value) {
            result = 'success';
            emp.name = name;
            emp.permission = List.from(permissions);
            notifyListeners();
          })
          .timeout(Duration(seconds: 5))
          .catchError((e) {
            print('HOOOOOOOn');
            print(e.toString());

            if (e.toString().contains('TimeoutException')) {
              result = 'internet fail';
            } else if (e.toString().contains('SocketException')) {
              result = 'internet fail';
            } else {
              result = 'fail';
            }
          });

      return result;
    } catch (e) {
      print('EEEEEEEEEE');
      print(e.toString());
      return 'false';
    }
  }

  Future<void> getEmployee(String clincId, BuildContext context) async {
    String result = '';
    try {
      print('sSSSSSSSSSss');
      var ref = Firestore.instance.collection('users');
      var data = await ref
          .where('clincId', isEqualTo: clincId)
          .get()
          .then((value) {
            employees.clear();

            searchList.clear();
            print('Data Are Here @');
            for (int i = 0; i < value.length; i++) {
              employees.insert(0, User.fromJson(value[i]));
              searchList.insert(0, User.fromJson(value[i]));
            }
            print(employees.length);

            print('LLLLLLL');
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

  void search(String text) {
    searchList.clear();
    if (text == '') {
      print('all employees');
      searchList = List.from(employees);
    } else {
      print(employees[0].name);
      for (int i = 0; i < employees.length; i++) {
        if (employees[i].name.contains(text)) {
          searchList.add(employees[i]);
        }
      }
    }
    print(searchList.length);
    notifyListeners();
  }
}
