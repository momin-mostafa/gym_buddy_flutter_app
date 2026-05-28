import 'package:intl/intl.dart' show DateFormat;

extension DateFormatterExtension on DateTime {
  String get format => "$day - $monthInCalender $year";

  String get monthInCalender => DateFormat('MMM').format(this);
}
