import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class Case {
  String userName = '';
  String uid = '';
  DateTime date = DateTime.now();
  List<String> tests = [];
  List<String> diags = [];
  String notes = '';
  String id = '';

  Case.fromJson(dynamic res) {
    date = DateTime.parse(res['date']) ?? DateTime.now();
    id = res['id'] ?? '';
    userName = res['userName'] ?? '';

    userName = res['userName'] ?? '';
    uid = res['uid'] ?? '';
    notes = res['notes'] ?? '';
    for (int i = 0; i < res['tests'].length; i++) {
      tests.add(res['tests'][i]);
    }
    for (int i = 0; i < res['diags'].length; i++) {
      diags.add(res['diags'][i]);
    }
  }
  Case({
    List<String> diags,
    List<String> tests,
    String id,
    this.notes,
    @required this.userName,
    @required this.uid,
  }) {
    this.id = id + date.toString();

    this.tests = List.from(tests);
    this.diags = List.from(diags);
  }
  get toMap {
    Map<String, dynamic> map = {
      'date': DateFormat('yyyy-MM-dd HH:mm:ss').format(date),
      'diags': diags,
      'tests': tests,
      'id': id,
      'notes': notes,
      'userName': userName,
      'uid': uid,
    };
    return map;
  }

  get diagsToString {
    String s = '';
    for (var i = 0; i < diags.length; i++) {
      s += diags[i] + ',';
    }
    return s;
  }
  get testsToString {
    String s = '';
    for (var i = 0; i < tests.length; i++) {
      s += tests[i] + ',';
    }
    return s;
  }
}
