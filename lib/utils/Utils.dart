import 'package:intl/intl.dart';

class Utils {
  static String formatDateTime(int timestamp) {
    var dateTime = DateTime.fromMicrosecondsSinceEpoch(timestamp);
    return DateFormat('dd-MMM-yyyy HH:ss').format(dateTime);
  }
}
