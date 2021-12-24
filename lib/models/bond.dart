import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class Bond {
  String id = '';
  String type = '';
  double amount = 0;
  String clincId = '';

  String userName = '';
  String uid = '';

  String description = ''; //صرف
  String empId = '';
  String empName = '';

  String patName = ''; //قبض
  String pid = '';

  DateTime date = DateTime.now();

  String note = '';

  Bond({
    @required this.date,
    @required this.uid,
    @required this.userName,
    @required this.amount,
    @required this.clincId,
    this.description,
    @required this.note,
    this.patName,
    this.pid,
    @required this.type,
    @required this.id,
    this.empId,
    this.empName,
  });

  Bond.fromJson(dynamic res) {
    type = res['type'] ?? '';
    clincId = res['clincId'];
    id = res['id'] ?? '';
    empId = res['empId'] ?? '';
    empName = res['empName'] ?? '';
    uid = res['uid'] ?? '';
    userName = res['userName'] ?? '';
    amount = res['amount'] ?? 0;
    description = res['description'] ?? '';
    note = res['note'] ?? '';
    patName = res['patName'] ?? '';
    pid = res['pid'] ?? '';
    date = DateTime.parse(res['date']) ?? DateTime.now();
  }

  get toMap {
    Map<String, dynamic> map = {
      'id': id,
      'uid': uid,
      'empId': empId,
      'empName': empName,
      'userName': userName,
      'amount': amount,
      'description': description,
      'note': note,
      'clincId': clincId,
      'patName': patName,
      'pid': pid,
      'type': type,
      'date': DateFormat('yyyy-MM-dd HH:mm:ss').format(date)
    };
    return map;
  }
}
