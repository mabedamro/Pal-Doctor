import 'dart:convert';

import 'package:desktop_version/api/authApi.dart';
import 'package:desktop_version/api/databaseApi.dart';
import 'package:desktop_version/models/user.dart';
import 'package:desktop_version/provider/apiRequest.dart';
import 'package:desktop_version/screen/homeScreen.dart';
import 'package:desktop_version/screen/splashScreen.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserProvier with ChangeNotifier {
  User user;
  String userToken;

  Future<bool> getUserData(bool isSplashScreen) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String uid = prefs.getString('uid');

      String token = prefs.getString('token');

      var url = Uri.parse(DataApi.usersApi + '/$uid');
      var res = await ApiRequest.getRequest(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      if (res == false) {
        print('errorOccured');
        if (isSplashScreen) {
          SplashScreen.goTo(false);
        }
        return false;
      } else {
        print(res.toString());
        if (res['error'] == null) {
          if (res['fields']['isActive']['stringValue'] == '0') {
            print('notActive');
            await ApiRequest.saveToken('', '', '');
            user = null;
            if (isSplashScreen) {
              SplashScreen.goTo(false);
            }
            return false;
          }
          user = User.fromJson(res['fields']);
          if (isSplashScreen) {
            SplashScreen.goTo(true);
          }
          return true;
        } else {
          print('no');
          user = null;
        }
      }

      if (isSplashScreen) {
        SplashScreen.goTo(false);
      }
      return false;
    } catch (e) {
      print(e);
      user = null;
      if (isSplashScreen) {
        SplashScreen.goTo(false);
      }
      return false;
    }
  }

  Future<bool> login({String email, String pass}) async {
    try {
      var url = Uri.parse(AuthApi.login);
      bool result = false;
      var response = await http.post(url, body: {
        'email': email,
        'password': pass,
        'returnSecureToken': 'true',
      }).then((value) async {
        Map res = jsonDecode(value.body);
        print(res.toString());
        if (res['error'] == null) {
          await ApiRequest.saveToken(
              res['idToken'], res['localId'], res['refreshToken']);
          result = await getUserData(false);
        } else {
          user = null;
        }
        return result;
      }).catchError((e) {
        print(e);
        user = null;
        return false;
      });

      return result;
    } catch (e) {
      return false;
    }
  }

  Future<bool> creatUser(String uid, String body) async {
    bool result = false;
    try {
      print('AAAAA');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token');
      var url = Uri.parse(DataApi.usersApi + '/$uid');

      print('FFFF');
      var response = await ApiRequest.patchRequest(url,
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: body);

      print('FFFFAAAA');
      print(response.toString());
      if (response == false) {
        return false;
      } else {
        print(response.toString());
        result = true;
      }
      return result;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> creatEmp(
      {String email, String pass, String name, List<String> permission}) async {
    try {
      print('object');
      var url = Uri.parse(AuthApi.signUp);
      bool result = false;
      var res = await ApiRequest.postRequest(url, body: {
        'email': email,
        'password': pass,
      });
      if (res != false) {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        List<Map> per = [];
        for (int i = 0; i < permission.length; i++) {
          per.add({'stringValue': permission[i]});
        }
        String permissionsList = jsonEncode(per);
        print(prefs.getString('uid'));
        Map userInfo = {
          'fields': {

            'id': {
              'string_value': res['localId'],
            },
            'createdBy': {
              'string_value': prefs.getString('uid'),
            },
            'email': {
              'string_value': email,
            },
            'isActive': {
              'string_value': '1',
            },
            'level': {
              'string_value': '0',
            },
            'name': {
              'string_value': name,
            },
            'permission': {
              'arrayValue': {
                'values': per
              }
            }
          }
        };
        String data = json.encode(userInfo);
        print('SSSS');
        await creatUser(res['localId'], data);

        result = true;
      } else {
        result = false;
      }

      if (user != null) {
        return true;
      }
      return false;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<void> signout() async {
    await ApiRequest.saveToken('', '', '');
    user = null;
    HomeScreen.goTo(false);
  }
}
