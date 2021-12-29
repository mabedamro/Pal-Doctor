import 'dart:convert';

import 'package:desktop_version/api/authApi.dart';
import 'package:desktop_version/models/user.dart';
import 'package:desktop_version/provider/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firedart/firestore/firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
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
      List<String> permissions,
      @required BuildContext context}) async {
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

      if (res['error'] == null) {
        var ref = Firestore.instance.collection('users');

        Map<String, dynamic> empData = {
          'clincId': clincId,
          'createdBy': createdById,
          'email': email,
          'id': res['localId'].toString(),
          'isActive': '1',
          'name': name,
          'pass': pass,
          'createdDate': DateTime.now().toString(),
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
        }).catchError((e) async {
          print(e.toString());
          if (e.toString().contains('SocketException')) {
            result = 'internet fail';
          }

          if (e.toString().contains('PERMISSION_DENIED') ||
              e.toString().contains('UNAUTHENTICATED')) {
            String result =
                await Provider.of<UserProvier>(context, listen: false)
                    .tryToLogin(context);
            if (result == 'success') {
              creatEmp(
                  clincId: clincId,
                  name: name,
                  pass: pass,
                  email: email,
                  permissions: permissions,
                  createdById: createdById,
                  context: context);
            } else {
              Provider.of<UserProvier>(context, listen: false).signout(context);
            }
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

  Future<String> updateEmployee(String name, List<String> permissions, User emp,
      {@required BuildContext context}) async {
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
          .catchError((e) async {
            print('HOOOOOOOn');
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
                updateEmployee(name, permissions, emp, context: context);
              }else if(result == 'needUpdate'){Provider.of<UserProvier>(context, listen: false)
                    .goToUpdateScreen(context);} else {
                Provider.of<UserProvier>(context, listen: false)
                    .signout(context);
              }
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

  Future<void> changeActive(User emp, String isActive,
      {@required BuildContext context}) async {
    String result = 'fail';
    try {
      var ref = Firestore.instance.collection('users');
      Map<String, dynamic> empData = {
        'isActive': isActive,
      };
      await ref
          .document(emp.id)
          .update(empData)
          .then((value) async {
            result = 'success';
            emp.isActive = isActive;
            //login to user to expire the id token for the user
            var url = Uri.parse(AuthApi.signUp);
            var response = await http.post(url, body: {
              'email': emp.email,
              'password': emp.pass,
              'returnSecureToken': 'false',
            }).catchError((e) {
              if (e.toString().contains('SocketException')) {
                result = 'internet fail';
              }
            });

            notifyListeners();
          })
          .timeout(Duration(seconds: 5))
          .catchError((e) async {
            print('HOOOOOOOn');
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
                changeActive(emp, isActive, context: context);
              }else if(result == 'needUpdate'){Provider.of<UserProvier>(context, listen: false)
                    .goToUpdateScreen(context);} else {
                Provider.of<UserProvier>(context, listen: false)
                    .signout(context);
              }
            } else {
              result = 'fail';
            }
          });
    } catch (e) {
      print('EEEEEEEEEE');
      print(e.toString());
      result = 'fail';
    }
    if (result == 'success') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Directionality(
              textDirection: TextDirection.rtl,
              child: Text('تم تغيير حالة النشاط بنجاح')),
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
                getEmployee(clincId, context);
              }else if(result == 'needUpdate'){Provider.of<UserProvier>(context, listen: false)
                    .goToUpdateScreen(context);} else {
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

  void search(String text) {
    text = text.toLowerCase();
    searchList.clear();
    if (text == '') {
      print('all employees');
      searchList = List.from(employees);
    } else {
      print(employees[0].name);
      for (int i = 0; i < employees.length; i++) {
        if (employees[i].name.toLowerCase().contains(text)) {
          searchList.add(employees[i]);
        }
      }
    }
    print(searchList.length);
    notifyListeners();
  }
}
