import 'package:intl/intl.dart';

class PatDate {
  String id;
  String pid = '';
  String empId = '';
  String clincId = '';
  DateTime date;
  String userName = '';
  String patName = '';
  String note = '';

  PatDate({
    this.date,
    this.note,
    this.pid,
    this.clincId,
    this.id,
    this.empId,
    this.userName,
    this.patName,
  });

  PatDate.fromJson(dynamic res) {
    pid = res['pid'] ?? '';
    id = res['id'] ?? '';
    note = res['note'] ?? '';
    userName = res['userName'] ?? '';
    empId = res['empId'] ?? '';
    patName = res['patName'] ?? '';
    clincId = res['clincId'];
    date = DateTime.parse(res['date']) ?? DateTime.now();
  }
  get toMap {
    Map<String, dynamic> map = {
      'clincId': clincId,
      'date': DateFormat('yyyy-MM-dd HH:mm:ss').format(date),
      'note': note,
      'pid': pid,
      'id': id,
      'userName': userName,
      'patName': patName,
      'empId': empId,
    };
    return map;
  }
}
