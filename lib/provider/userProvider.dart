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
        'refreshToken': 'test',
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

  Future<bool> creatUser(String uid) async {
    bool result = false;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token');
      var url = Uri.parse(DataApi.usersApi + '/$uid');
      Map body = {
        "fields": {
          'test': {'stringValue': 'test data'},
        }
      };

      var response = await http
          .patch(url,
              headers: {
                'Accept': 'application/json',
                'Authorization': 'Bearer $token'
              },
              body: json.encode(body))
          .then((value) async {
        Map res = jsonDecode(value.body);
        print(res.toString());
        result = true;
      }).catchError((e) {
        result = false;
      });

      return result;
    } catch (e) {
      return false;
    }
  }

  Future<bool> creatEmp(
      {String email, String pass, String name, List<String> permission}) async {
    try {
      var url = Uri.parse(AuthApi.signUp);
      bool result = false;
      var response = await http.post(url, body: {
        'email': email,
        'password': pass,
      }).then((value) async {
        Map res = jsonDecode(value.body);

        if (res['error'] == null) {
          creatUser(res['localId']);

          result = true;
        } else {
          result = false;
        }
      }).catchError((e) {
        user = null;
        return false;
      });
      if (user != null) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<void> signout() async {
    await ApiRequest.saveToken('', '', '');
    user = null;
    HomeScreen.goTo(false);
  }
}
