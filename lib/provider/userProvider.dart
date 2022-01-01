import 'dart:convert';
import 'dart:io';

import 'package:desktop_version/api/authApi.dart';
import 'package:desktop_version/api/databaseApi.dart';
import 'package:desktop_version/models/appConstants.dart';
import 'package:desktop_version/models/user.dart';
import 'package:desktop_version/screen/homeScreen.dart';
import 'package:desktop_version/screen/loginScreen.dart';
import 'package:desktop_version/screen/splashScreen.dart';
import 'package:desktop_version/screen/updateScreen.dart';
import 'package:firedart/auth/firebase_auth.dart';
import 'package:firedart/firestore/firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvier with ChangeNotifier {
  User user;
  User clincUser;
  String updateUrl;
  String appVersion;
  String stopAll;
  Future<void> getClincData() async {
    try {
      if (user.clincId == user.id) {
        clincUser = user;
        return;
      }
      var ref = Firestore.instance.collection('users').document(user.clincId);
      var data = await ref.get().then((value) {
        print(value.toString());
        clincUser = User.fromJson(value);

        print('clicn data got!!');
        notifyListeners();
      }).catchError((e) {
        print('Here Error Man !');
        print(e.toString());
      });
    } catch (e) {

        print('error  !!');
      print(e.toString());
    }
  }

  Future<void> getAppConstants() async {
    try {
      var ref = Firestore.instance
          .collection('appConstants')
          .document('appConstants');
      var data = await ref.get().then((value) {
        appVersion = value['appVersion'];
        updateUrl = value['updateUrl'];
        stopAll = value['stopAll'];
      }).catchError((e) {
        print('Here Error Man !');
        print(e.toString());
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> getUserData(String uid) async {
    try {
      var ref = Firestore.instance.collection('users').document(uid);
      var data = await ref.get().then((value) async {
        user = User.fromJson(value);
        print('Data Are Here');
        await getClincData();
        await getAppConstants();
        notifyListeners();
      }).catchError((e) {
        print('Here Error Man !');
        print(e.toString());
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<String> tryToLogin(BuildContext context) async {
    try {
      String result = 'false';

      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs.getString('email') == '') {
        print('no saved email');
        return 'false';
      }

      var auth = FirebaseAuth.instance;

      String email = prefs.getString('email');
      String pass = prefs.getString('password');

      // Sign in with user credentials
      await auth.signIn(email, pass).then((value) async {
        await getUserData(auth.userId);
        print('object');
        if (clincUser.isActive == '0') {
          signout(context);
          result = 'fail';
        } else {
          if (user.isActive == '0') {
            signout(context);
            result = 'fail';
          } else {
            if (stopAll == '1') {
              signout(context);
              result = 'fail';
            } else {
              if (appVersion != AppConstants.appVersion) {
                //need Update
                print('needUpdate');
                // goToUpdateScreen(context);
                result = 'needUpdate';
              } else {
                result = 'success';
              }
            }
          }
        }
      }).catchError((e) {
        if (e.toString().contains('SocketException')) {
          result = 'internet fail';
        } else {
          prefs.setString('email', '');
          prefs.setString('password', '');
          result = 'fail';
        }
        print(e.toString());
      });

      return result;
    } catch (e) {
      return 'false';
    }
  }

  Future<void> deleteDiag(String d, BuildContext context) async {
    String result = 'fail';
    try {
      var ref = Firestore.instance.collection('users');
      List<String> diagsCopy = List.from(clincUser.clincDiags);
      int x = 0;
      for (var i = 0; i < diagsCopy.length; i++) {
        if (d == diagsCopy[i]) {
          x = i;
          diagsCopy.removeAt(i);
          break;
        }
      }
      Map<String, dynamic> data = {
        'clincDiags': diagsCopy,
      };
      await ref
          .document(clincUser.id)
          .update(data)
          .then((value) {
            result = 'success';
            clincUser.clincDiags.removeAt(x);
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
                addDiag(d, context);
              } else if (result == 'needUpdate') {
                Provider.of<UserProvier>(context, listen: false)
                    .goToUpdateScreen(context);
              } else {
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
      ;
    }
    if (result == 'success') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Directionality(
              textDirection: TextDirection.rtl,
              child: Text('تم حذف التشخيص بنجاح')),
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

  Future<void> deleteTest(String d, BuildContext context) async {
    String result = 'fail';
    try {
      var ref = Firestore.instance.collection('users');
      List<String> testsCopy = List.from(clincUser.clincTests);
      int x = 0;
      for (var i = 0; i < testsCopy.length; i++) {
        if (d == testsCopy[i]) {
          x = i;
          testsCopy.removeAt(i);
          break;
        }
      }
      Map<String, dynamic> data = {
        'clincTests': testsCopy,
      };
      await ref
          .document(clincUser.id)
          .update(data)
          .then((value) {
            result = 'success';
            clincUser.clincTests.removeAt(x);
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
                addDiag(d, context);
              } else if (result == 'needUpdate') {
                Provider.of<UserProvier>(context, listen: false)
                    .goToUpdateScreen(context);
              } else {
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
      ;
    }
    if (result == 'success') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Directionality(
              textDirection: TextDirection.rtl,
              child: Text('تم حذف التشخيص بنجاح')),
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

  Future<void> addDiag(String d, BuildContext context) async {
    String result = 'fail';
    try {
      var ref = Firestore.instance.collection('users');
      List<String> diagsCopy = List.from(clincUser.clincDiags);
      diagsCopy.insert(0, d);
      Map<String, dynamic> data = {
        'clincDiags': diagsCopy,
      };
      await ref
          .document(clincUser.id)
          .update(data)
          .then((value) {
            result = 'success';
            clincUser.clincDiags.insert(0, d);
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
                addDiag(d, context);
              } else if (result == 'needUpdate') {
                Provider.of<UserProvier>(context, listen: false)
                    .goToUpdateScreen(context);
              } else {
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
      ;
    }
    if (result == 'success') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Directionality(
              textDirection: TextDirection.rtl,
              child: Text('تمت إضافة التشخيص بنجاح')),
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

  Future<void> addTest(String d, BuildContext context) async {
    String result = 'fail';
    try {
      var ref = Firestore.instance.collection('users');
      List<String> testCopy = List.from(clincUser.clincTests);
      testCopy.insert(0, d);
      Map<String, dynamic> data = {
        'clincTests': testCopy,
      };
      await ref
          .document(clincUser.id)
          .update(data)
          .then((value) {
            result = 'success';
            clincUser.clincTests.insert(0, d);
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
                addDiag(d, context);
              } else if (result == 'needUpdate') {
                Provider.of<UserProvier>(context, listen: false)
                    .goToUpdateScreen(context);
              } else {
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
      ;
    }
    if (result == 'success') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Directionality(
              textDirection: TextDirection.rtl,
              child: Text('تمت إضافة التشخيص بنجاح')),
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

  void goToUpdateScreen(BuildContext context) {
    print('UUUUUUUUUUUUUUUUUUUUUUUUUUU');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => UpdateScreen(updateUrl)),
    );
  }

  Future<String> login({String email, String pass}) async {
    try {
      String result = 'fail';

      var auth = FirebaseAuth.instance;
      print('Heeee');
      // Sign in with user credentials
      await auth.signIn(email, pass).then((value) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('email', email);
        prefs.setString('password', pass);
        await getUserData(auth.userId);
        if (user.isActive == '0') {
          result = 'fail';
        } else {
          result = 'success';
        }
      }).catchError((e) {
        if (e.toString().contains('SocketException')) {
          result = 'internet fail';
        } else {
          result = 'fail';
        }
        print(e.toString());
      });

      return result;
    } catch (e) {
      return 'fail';
    }
  }

  Future<void> signout(BuildContext context) async {
    // await ApiRequest.saveToken('', '', '');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', '');
    prefs.setString('password', '');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
    user = null;
  }
}
