import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DarkModeProvider with ChangeNotifier {
  bool isDark = false;
 Future< void> changeDarkTo(bool b) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDark', b);
    isDark = b;
    notifyListeners();
  }
}
