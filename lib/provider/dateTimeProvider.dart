import 'package:intl/intl.dart';

class DateTimeProvider {
  static String dateNow() {
    String s = DateFormat('yyyy-MM-dd').format(DateTime.now());
    return s;
  }
  static String timeNow() {
    String s =DateFormat().add_jm().format(DateTime.now());
    return s;
  }
}
