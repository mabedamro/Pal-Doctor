import 'package:flutter/widgets.dart';

class ListProvider with ChangeNotifier{
  int whichList = 0;

  void chnageList(int i){
    whichList=i;
    notifyListeners();
  }

}