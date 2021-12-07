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
            print(e.toString());
        
      });
      List list = jsonDecode(response.body);
      print(list.toString());
      Map res = jsonDecode(response.body);
      print('zz');
      if (res['error'] != null) {
        print(res.toString()); 
        if (res['error']['code'] == '401') {
           print('ll');
          //un auth
          bool result = await updateToken();
          if (result) {
            token = prefs.getString('token');
            headers['Authorization']='Bearer $token';
            // String uid = prefs.getString('uid');
            var response = await http.post(
              url,
              headers: headers,body: body,
            ).catchError((e) {
              result = false;
            });
            if (result == false) {
               print('ff');
              return false;
            }
            res = jsonDecode(response.body);
          } else {
             print(',,');
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
      print('error is post :');
      print(e);
      return false;
    }
  }

  static Future<dynamic> getRequest(Uri url, {dynamic headers}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      print('ss');
      var response = await http
          .get(
        url,
        headers: headers,
      )
          .catchError((e) {
        return false;
      });
      print('ee');
      Map res = jsonDecode(response.body);
      print(res.toString());
      if (res['error'] != null) {
        print(res['error']['code']);
        if (res['error']['code'] == 401) {
          print('sss');
          //un auth
          bool result = await updateToken();
          if (result) {
            String token = prefs.getString('token');
            // String uid = prefs.getString('uid');
            headers['Authorization']='Bearer $token';
            var response = await http.get(
              url,
              headers:headers,
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

        print('SSS');
    try {
      
      SharedPreferences prefs = await SharedPreferences.getInstance();

        print('SS');
      // Sting bodyString = json.encode(body.toString());
      // String uid = prefs.getString('uid');
      var response = await http
          .patch(
        url,
        headers: headers,
        body: body.toString(),
      )
          .catchError((e) {
        print('error is :');
        print(e);
      });
      print(response.toString());

        print('AAAAAAAAAAAAAAa');
      Map res = jsonDecode(response.body);

      print(res.toString());

        print('AAAAAAAAAAAAAAa');
      if (res['error'] != null) {
        if (res['error']['code'] == '401') {
          //un auth
          bool result = await updateToken();
          if (result) {
            String token = prefs.getString('token');
            // String uid = prefs.getString('uid');
            headers['Authorization']='Bearer $token';
            var response = await http.get(
              url,
              headers: headers,
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
      if (refreshToken == '') {
        result = false;
      }
      var url = Uri.parse(AuthApi.refreshToken);
      var res = await ApiRequest.postRequest(url, body: {
        'grant_type': 'refresh_token',
        'refresh_token': refreshToken,
      });

      print(res.toString());
      if (res['error'] == null) {
        saveToken(res['id_token'], res['user_id'], res['refresh_token']);
        result = true;
      } else {
        result = false;
      }

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
