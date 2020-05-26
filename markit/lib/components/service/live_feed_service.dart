class LiveFeedService {

  static String getTimeString(DateTime submittedDate) {
    Duration difference = DateTime.now().difference(submittedDate.toLocal());
    if (difference.inDays / 365 >= 1) {
      int years = (difference.inDays / 365).round();
      if (years == 1) {
        return '1 year ago';
      }
      return '$years years Ago';
    } else if (difference.inDays / 30 >= 1) {
      int months = (difference.inDays / 30).round();
      if (months == 1) {
        return '1 month ago';
      }
      return '$months months Ago';
    } else if (difference.inDays / 7 >= 1) {
      int weeks = (difference.inDays / 7).round();
      if (weeks == 1) {
        return '1 week ago';
      }
      return '$weeks weeks Ago';
    } else if (difference.inDays >= 1) {
      int days = (difference.inDays).round();
      if (days == 1) {
        return '1 day ago';
      }
      return '$days days Ago';
    } else if (difference.inHours >= 1) {
      int hours = (difference.inHours).round();
      if (hours == 1) {
        return '1 hour ago';
      }
      return '$hours hours Ago';
    }
    int minutes = (difference.inMinutes).round();
    if (minutes == 1) {
      return '1 minute ago';
    }
    return '$minutes minutes Ago';
  }
}