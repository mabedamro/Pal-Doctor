import 'dart:convert';
import 'dart:io';

import 'package:desktop_version/api/authApi.dart';
import 'package:desktop_version/api/databaseApi.dart';
import 'package:desktop_version/models/appConstants.dart';
import 'package:desktop_version/models/user.dart';
import 'package:desktop_version/screen/homeScreen.dart';
import 'package:desktop_version/screen/loginScreen.dart';
import 'package:desktop_version/screen/splashScreen.dart';
import 'package:firedart/auth/firebase_auth.dart';
import 'package:firedart/firestore/firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
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
        return;
      }
      var ref = Firestore.instance.collection('users').document(user.clincId);
      var data = await ref.get().then((value) {
        clincUser = User.fromJson(value);

        print('Data Are Here');
        notifyListeners();
      }).catchError((e) {
        print('Here Error Man !');
        print(e.toString());
      });
    } catch (e) {
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
                goToUpdateScreen();

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
  void goToUpdateScreen(){

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
