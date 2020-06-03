import 'package:tuple/tuple.dart';

class DateService {

  static Tuple2<String, bool>  getTimeString(DateTime submittedDate) {
    Duration difference = DateTime.now().difference(submittedDate.toLocal());
    if (difference.inDays / 365 >= 1) {
      int years = (difference.inDays / 365).round();
      if (years == 1) {
        return Tuple2('1 year ago', true);
      }
      return Tuple2('$years years ago', true);
    } else if (difference.inDays / 30 >= 1) {
      int months = (difference.inDays / 30).round();
      if (months == 1) {
        return Tuple2('1 month ago', true);
      }
      return Tuple2('$months months ago', true);
    } else if (difference.inDays / 7 >= 1) {
      int weeks = (difference.inDays / 7).round();
      if (weeks == 1) {
        return Tuple2('1 week ago', false);
      }
      return Tuple2('$weeks weeks ago', false);
    } else if (difference.inDays >= 1) {
      int days = (difference.inDays).round();
      if (days == 1) {
        return Tuple2('1 day ago', false);
      }
      return Tuple2('$days days ago', false);
    } else if (difference.inHours >= 1) {
      int hours = (difference.inHours).round();
      if (hours == 1) {
        return Tuple2('1 hour ago', false);
      }
      return Tuple2('$hours hours ago', false);
    }
    int minutes = (difference.inMinutes).round();
    if (minutes == 1) {
      return Tuple2('1 minute ago', false);
    }
    return Tuple2('$minutes minutes ago', false);
  }
}