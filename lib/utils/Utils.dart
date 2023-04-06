import 'package:intl/intl.dart';

class Utils {
  static double setAverageRating(List<int> ratings) {
    var avgRating = 0;
    for (int i = 0; i < ratings.length; i++) {
      avgRating = avgRating + ratings[i];
    }
    return double.parse((avgRating / ratings.length).toStringAsFixed(1));
  }

  static String formatDateTime(int timestamp) {
    var dateTime = DateTime.fromMicrosecondsSinceEpoch(timestamp);
    return DateFormat('dd-MMM-yyyy HH:ss').format(dateTime);
  }
}
