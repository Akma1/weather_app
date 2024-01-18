import 'package:intl/intl.dart';

String formatDate(DateTime date, [bool wTime = false, bool compact = false]) {
  final formatter = wTime
      ? compact
          ? DateFormat("d MMM y, HH:mm")
          : DateFormat("d MMMM y, HH:mm")
      : compact
          ? DateFormat.yMMMd()
          : DateFormat.yMMMMEEEEd();
  return formatter.format(date);
}

String formatTime(DateTime date) {
  final formatter = DateFormat.Hm();
  return formatter.format(date);
}
