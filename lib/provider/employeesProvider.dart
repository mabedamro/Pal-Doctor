import 'dart:convert';

import 'package:desktop_version/api/databaseApi.dart';
import 'package:desktop_version/models/user.dart';
import 'package:desktop_version/provider/apiRequest.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmployeesProvider with ChangeNotifier {
  List<User> employees = [];

  Future<bool> getEmployee() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String uid = prefs.getString('uid');

      String token = prefs.getString('token');

      var url = Uri.parse(DataApi.empApi(uid));
      var res = await ApiRequest.postRequest(url,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode(
            {
              "structuredQuery": {
                "from": [
                  {"collectionId": "users", "allDescendants": true}
                ],
                "where": {
                  "fieldFilter": {
                    "field": {"fieldPath": "createdBy"},
                    "op": "EQUAL",
                    "value": {
                      "stringValue": "uid",
                    }
                  }
                }
              },
            },
          ));
      if (res == false) {
        print('errorOccured');

        return false;
      } else {
        if (res['error'] == null) {
          if (res['fields']['isActive']['stringValue'] == '0') {
            print('notActive');
            await ApiRequest.saveToken('', '', '');
            employees.clear();
            return false;
          }
          //true

//
          return true;
        } else {
          print('no');
          employees.clear();
        }
      }

      employees.clear();
      return false;
    } catch (e) {
      print(e);
      employees.clear();
      return false;
    }
  }
}
