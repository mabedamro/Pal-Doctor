import 'dart:convert';

import 'package:desktop_version/api/authApi.dart';
import 'package:desktop_version/screen/splashScreen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiRequest {
  static Future<dynamic> postRequest(Uri url,
      {dynamic headers, dynamic body}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token');

      // String uid = prefs.getString('uid');
      var response =
          await http.post(url, headers: headers, body: body).catchError((e) {
        return false;
      });
      Map res = jsonDecode(response.body);
      if (res['error'] != null) {
        if (res['error']['code'] == '401') {
          //un auth
          bool result = await updateToken();
          if (result) {
            token = prefs.getString('token');
            // String uid = prefs.getString('uid');
            var response = await http.get(
              url,
              headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
                'Authorization': 'Bearer $token',
                'refreshToken': 'test',
              },
            ).catchError((e) {
              result = false;
            });
            if (result == false) {
              return false;
            }
            res = jsonDecode(response.body);
          } else {
            await saveToken('', '', '');
            print('goToLogin again');
            SplashScreen.goTo(false);
            return false;
          }
        } else {
          return false;
        }
      }
      return res;
    } catch (e) {
      print('error is :');
      print(e);
      return false;
    }
  }

  static Future<dynamic> getRequest(Uri url, {dynamic headers}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // String uid = prefs.getString('uid');
      var response = await http
          .get(
        url,
        headers: headers,
      )
          .catchError((e) {
        return false;
      });
      Map res = jsonDecode(response.body);
      if (res['error'] != null) {
        if (res['error']['code'] == '401') {
          //un auth
          bool result = await updateToken();
          if (result) {
            String token = prefs.getString('token');
            // String uid = prefs.getString('uid');
            var response = await http.get(
              url,
              headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
                'Authorization': 'Bearer $token',
                'refreshToken': 'test',
              },
            ).catchError((e) {
              result = false;
            });
            if (result == false) {
              return false;
            }
            res = jsonDecode(response.body);
          } else {
            await saveToken('', '', '');
            print('goToLogin again');
            SplashScreen.goTo(false);
            return false;
          }
        } else {
          return false;
        }
      }
      return res;
    } catch (e) {
      print('error is :');
      print(e);
      return false;
    }
  }

  static Future<dynamic> patchRequest(Uri url,
      {dynamic headers, dynamic body}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // String uid = prefs.getString('uid');
      var response = await http
          .patch(
        url,
        headers: headers,
        body: body,
      )
          .catchError((e) {
        print('error is :');
        print(e);
      });
      Map res = jsonDecode(response.body);
      if (res['error'] != null) {
        if (res['error']['code'] == '401') {
          //un auth
          bool result = await updateToken();
          if (result) {
            String token = prefs.getString('token');
            // String uid = prefs.getString('uid');
            var response = await http.get(
              url,
              headers: {
                'Accept': 'application/json',
                'Authorization': 'Bearer $token'
              },
            ).catchError((e) {
              result = false;
            });
            if (result == false) {
              return false;
            }
            res = jsonDecode(response.body);
          } else {
            await saveToken('', '', '');
            print('goToLogin again');
            SplashScreen.goTo(false);
            return false;
          }
        } else {
          return false;
        }
      }
      return res;
    } catch (e) {
      print('error is :');
      print(e);
      return false;
    }
  }

  static Future<bool> updateToken() async {
    bool result = false;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String refreshToken = prefs.getString('refreshToken');

      print(refreshToken);
      if(refreshToken==''){
         result = false;
      }
      var url = Uri.parse(AuthApi.refreshToken);
      var response = await ApiRequest.postRequest(url, body: {
        'grant_type': 'refresh_token',
        'refresh_token': refreshToken,
      }).then((value) {
        Map res = jsonDecode(value.body);
        print(res.toString());
        if (res['error'] == null) {
          saveToken(res['id_token'], res['user_id'], res['refresh_token']);
          result = true;
        } else {
          result = false;
        }
      }).catchError((e) {
        result = false;
      });
      return result;
    } catch (e) {
      return false;
    }
  }

  static Future<void> saveToken(
      String token, String uid, String refreshToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setString('uid', uid);
    await prefs.setString('refreshToken', refreshToken);
  }
}
