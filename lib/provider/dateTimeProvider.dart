import 'package:intl/intl.dart';

class DateTimeProvider {
  static String date(DateTime date) {
    String s = DateFormat('yyyy-MM-dd').format(date);
    return s;
  }
  

  static String time(DateTime date) {
    String s = DateFormat().add_jm().format(date);
    return s;
  }

  static String dateAndTime(DateTime date) {
    String s = DateFormat('yyyy-MM-dd HH:mm').format(date);
    return s;
  }
}
