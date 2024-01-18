import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

enum NameType { full, abbreviated, narrow }

enum DateFilterMode { day, month, year }

enum DurationUnit { year, month, day, hour, minute, second }

class Number {
  static NumberFormat currencyFormat = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp. ',
    decimalDigits: 0,
  );
  static NumberFormat simpleCurrency = NumberFormat.simpleCurrency(
    locale: 'id_ID',
    decimalDigits: 0,
  );
  static NumberFormat compactCurrency = NumberFormat.compactCurrency(
    locale: 'id_ID',
    symbol: 'Rp. ',
    decimalDigits: 0,
  );
  static NumberFormat compactSimpleCurrency = NumberFormat.compactSimpleCurrency();

  static NumberFormat decimalFormat = NumberFormat.decimalPattern('id_ID');
  static NumberFormat compact = NumberFormat.compact(locale: 'id_ID');
  static NumberFormat compactLong = NumberFormat.compactLong(locale: 'id_ID');
}

DateTime get now => DateTime.now().copyWith();

int weekOfYear({DateTime? date}) {
  date ??= now;
  int dayOfYear = int.parse(DateFormat("D", "id").format(date));
  var weekNumber = ((dayOfYear - now.weekday + 10) / 7).floor();
  return weekNumber;
}

extension DateTimeUtils on DateTime {
  String formatDate({bool compact = false}) {
    if (compact) {
      return DateFormat.yMMMd().format(this);
    } else {
      return DateFormat.yMMMMd().format(this);
    }
  }

  String formatDateTime() {
    return DateFormat.yMMMd().add_Hm().format(this);
  }

  String formatTime() {
    return DateFormat.Hm().format(this);
  }

  List<DateTime> getDaysBetween({int dayExclude = -1, int count = 3}) {
    final dateRange = <DateTime>[];
    DateTime currentDate = this;

    // Add the date itself
    dateRange.add(currentDate);
    // Add days before
    int daysBefore = 0;
    currentDate = this;
    while (daysBefore < count) {
      currentDate = currentDate.subtract(const Duration(days: 1));
      log(currentDate.weekday.toString());
      if (currentDate.weekday != dayExclude) {
        dateRange.insert(0, currentDate);
        daysBefore++;
      }
    }

    // Add days after
    int daysAfter = 0;
    currentDate = this;
    while (daysAfter < (count * 3)) {
      currentDate = currentDate.add(const Duration(days: 1));
      if (currentDate.weekday != dayExclude) {
        dateRange.add(currentDate);
        daysAfter++;
      }
    }

    return dateRange;
  }

  bool get isWeekOfYearEven {
    return weekOfYear(date: this).isEven;
  }

  String fromNow({
    int maxLength = 2,
    bool short = false,
    DurationUnit minUnit = DurationUnit.day,
    DurationUnit maxUnit = DurationUnit.year,
    DateTime? other,
  }) {
    assert(minUnit.index >= maxUnit.index, 'minUnit index must be greater than or equal to maxUnit index');

    DateTime now = other ?? DateTime.now();
    DateTime exist = this;
    if (minUnit == DurationUnit.day) {
      now = now.startOfDay;
      exist = exist.startOfDay;
    }
    final difference = now.difference(exist);
    final units = <String>[];

    if (isToday && minUnit == DurationUnit.day) {
      return 'Hari ini';
    }

    void addUnit(int value, String unit) {
      if (value > 0) {
        if (short == true) {
          units.add('${Number.decimalFormat.format(value)}$unit');
        } else {
          units.add('${Number.decimalFormat.format(value)} $unit');
        }
      }
    }

    int year = difference.inDays ~/ 365;
    int month = difference.inDays % 365 ~/ 30;
    int day = difference.inDays % 30;
    int hour = difference.inHours % 24;
    int minute = difference.inMinutes % 60;
    int second = difference.inSeconds % 60;

    String yearText = short ? 'thn' : 'tahun';
    String monthText = short ? 'bln' : 'bulan';
    String dayText = short ? 'h' : 'hari';
    String hourText = short ? 'j' : 'jam';
    String minuteText = short ? 'm' : 'menit';
    String secondText = short ? 'd' : 'detik';

    if (minUnit.index >= DurationUnit.year.index && maxUnit.index <= DurationUnit.year.index) {
      addUnit(year, yearText);
    }
    if (minUnit.index >= DurationUnit.month.index && maxUnit.index <= DurationUnit.month.index) {
      bool hasMore = (difference.inDays / 30) > month && maxUnit.index == DurationUnit.month.index;
      addUnit(hasMore ? difference.inDays ~/ 30 : month, monthText);
    }
    if (minUnit.index >= DurationUnit.day.index && maxUnit.index <= DurationUnit.day.index) {
      bool hasMore = difference.inDays > day && maxUnit.index == DurationUnit.day.index;
      addUnit(hasMore ? difference.inDays : day, dayText);
    }
    if (minUnit.index >= DurationUnit.hour.index && maxUnit.index <= DurationUnit.hour.index) {
      bool hasMore = difference.inHours > hour && maxUnit.index == DurationUnit.hour.index;
      addUnit(hasMore ? difference.inHours : hour, hourText);
    }
    if (minUnit.index >= DurationUnit.minute.index && maxUnit.index <= DurationUnit.minute.index) {
      bool hasMore = difference.inMinutes > minute && maxUnit.index == DurationUnit.minute.index;
      addUnit(hasMore ? difference.inMinutes : minute, minuteText);
    }
    if (minUnit.index >= DurationUnit.second.index && maxUnit.index <= DurationUnit.second.index) {
      bool hasMore = difference.inSeconds > second && maxUnit.index == DurationUnit.second.index;
      addUnit(hasMore ? difference.inSeconds : second, secondText);
    }

    if (units.isEmpty) {
      return 'baru saja';
    }

    if (maxLength > 0 && units.length > maxLength) {
      units.length = maxLength;
    }

    return units.join(' ');
  }

  TimeOfDay get toTimeOfDay {
    return TimeOfDay(hour: hour, minute: minute);
  }

  String nameOfYear({NameType type = NameType.full, String? locale}) {
    final format = DateFormat(getDateFormatString(type, isYear: true), locale ?? Get.locale.toString());
    return format.format(this);
  }

  String nameOfMonth({NameType type = NameType.full, String? locale}) {
    final format = DateFormat(getDateFormatString(type, isMonth: true), locale ?? Get.locale.toString());
    return format.format(this);
  }

  String nameOfDay({NameType type = NameType.full, String? locale}) {
    final format = DateFormat(getDateFormatString(type), locale ?? Get.locale?.toString());
    return format.format(this);
  }

  String formatOfDate({NameType type = NameType.full, String? locale}) {
    final format = DateFormat(getDateFormatString(type, isDate: true), locale ?? Get.locale?.toString());
    return format.format(this);
  }

  String getDateFormatString(NameType type, {bool isMonth = false, bool isYear = false, bool isDate = false}) {
    if (isDate) {
      switch (type) {
        case NameType.full:
          return 'yMMMMd';
        case NameType.abbreviated:
          return 'yMMMd';
        case NameType.narrow:
          return 'yMd';
      }
    } else if (isYear) {
      switch (type) {
        case NameType.full:
          return 'yyyy';
        case NameType.abbreviated:
          return 'yy';
        case NameType.narrow:
          return 'y';
      }
    } else if (isMonth) {
      switch (type) {
        case NameType.full:
          return 'MMMM';
        case NameType.abbreviated:
          return 'MMM';
        case NameType.narrow:
          return 'MMMMM';
      }
    } else {
      switch (type) {
        case NameType.full:
          return 'EEEE';
        case NameType.abbreviated:
          return 'E';
        case NameType.narrow:
          return 'EEEEEE';
      }
    }
  }

  DateTime toFormattedDateTime() {
    String formattedString = DateFormat("yyyy-MM-dd HH:mm:ss.000").format(this);
    return DateTime.parse(formattedString);
  }

  static DateTime parseYMD(String ymd) {
    var parts = ymd.split('-');
    return DateTime(
      int.parse(parts[0]),
      int.parse(parts[1]),
      int.parse(parts[2]),
    );
  }

  DateTimeRange toDateTimeRange([DateTime? other]) {
    other ??= DateTime.now();
    return DateTimeRange(start: this, end: other);
  }

  bool get isFutureDay {
    return startOfDay.isAfter(now.startOfDay);
  }

  bool get isBeforeAMonth {
    Duration difference = DateTime.now().difference(this);
    int days = difference.inDays;
    return days <= 30;
  }

  bool get isBeforeToday {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return isBefore(today);
  }

  bool get isDay {
    return hour > 5 && hour < 18;
  }

  DateTime get toToday {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, hour, minute, second, millisecond, microsecond);
  }

  String get toDateString => DateFormat('yyyy-MM-dd', 'id').format(this);
  String get toTimeString => DateFormat('HH:mm', 'id').format(this);

  DateTime get nextDay {
    return add(const Duration(days: 1));
  }

  DateTime get prevDay {
    return subtract(const Duration(days: 1));
  }

  DateTime get nextYear {
    int year = this.year + 1;
    int month = this.month;
    int day = this.day;

    if (month == 2 && day == 29) {
      if (!DateTime(year, 2, 29).isValid) {
        day = 28;
      }
    }

    return DateTime(year, month, day);
  }

  DateTime get prevYear {
    int year = this.year - 1;
    int month = this.month;
    int day = this.day;

    if (month == 2 && day == 29) {
      if (!DateTime(year, 2, 29).isValid) {
        day = 28;
      }
    }

    return DateTime(year, month, day);
  }

  DateTime prevYears([int years = 1]) {
    final newYear = year - years;
    final newDay = day <= DateTime(newYear, month + 1, 0).day ? day : DateTime(newYear, month + 1, 0).day;
    return DateTime(newYear, month, newDay, hour, minute, second, millisecond, microsecond);
  }

  DateTime get nextMonth {
    int year = this.year;
    int month = this.month + 1;
    int day = this.day;

    if (month > 12) {
      year += 1;
      month = 1;
    }

    int maxDay = daysInMonth(year, month);
    if (day > maxDay) {
      day = maxDay;
    }

    return DateTime(year, month, day);
  }

  DateTime get prevMonth {
    int year = this.year;
    int month = this.month - 1;
    int day = this.day;

    if (month < 1) {
      year -= 1;
      month = 12;
    }

    int maxDay = daysInMonth(year, month);
    if (day > maxDay) {
      day = maxDay;
    }

    return DateTime(year, month, day);
  }

  DateTime addSeconds({int seconds = 1}) {
    return add(Duration(seconds: seconds));
  }

  DateTime subSeconds([seconds = 1]) {
    return subtract(Duration(seconds: seconds));
  }

  DateTime addMinutes({int minutes = 1}) {
    return add(Duration(minutes: minutes));
  }

  DateTime subMinutes({int minutes = 1}) {
    return subtract(Duration(minutes: minutes));
  }

  DateTime addHours({int hours = 1}) {
    return add(Duration(hours: hours));
  }

  DateTime subHours({int hours = 1}) {
    return subtract(Duration(hours: hours));
  }

  DateTime addDays(int day) {
    return add(Duration(days: day));
  }

  DateTime subDays(int day) {
    return subtract(Duration(days: day));
  }

  DateTime addMonths([double months = 1]) {
    final intMonths = months.toInt();
    final intDays = ((months - intMonths) * 30.4375).round();
    return DateTime(year, month + intMonths, day).add(Duration(days: intDays));
  }

  DateTime subMonths([double months = 1]) {
    return addMonths(-months);
  }

  DateTime get startOfDay {
    return DateTime(year, month, day);
  }

  DateTime get endOfDay {
    return DateTime(year, month, day, 23, 59, 59, 999, 0);
  }

  DateTime get startOfWeek {
    var dayOfWeek = weekday;
    return subtract(Duration(days: dayOfWeek - 1)).startOfDay;
  }

  DateTime get endOfWeek {
    var dayOfWeek = weekday;
    return add(Duration(days: 7 - dayOfWeek)).endOfDay;
  }

  DateTime get startOfMonth {
    return DateTime(year, month);
  }

  DateTime get endOfMonth {
    var endOfMonth = add(Duration(days: 32 - day));
    endOfMonth = endOfMonth.subtract(Duration(days: endOfMonth.day));
    return endOfMonth.endOfDay;
  }

  DateTime get endOfMonthOrToday {
    var endOfMonth = add(Duration(days: 32 - day));
    endOfMonth = endOfMonth.subtract(Duration(days: endOfMonth.day));
    if (endOfMonth.isAfter(now.endOfDay)) {
      return now.endOfDay;
    }
    return endOfMonth.endOfDay;
  }

  DateTime get startOfYear {
    return DateTime(year, 1, 1);
  }

  DateTime get endOfYear {
    return DateTime(year, 12, 31).endOfDay;
  }

  bool get isToday {
    final now = DateTime.now();

    bool result = year == now.year && month == now.month && day == now.day;

    return result;
  }

  bool get isTodayOrYesterday {
    return isToday || isYesterday;
  }

  bool get isTodayOrAfter {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return !isBefore(today);
  }

  bool get isTodayOrBefore {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return !isAfter(today);
  }

  bool get isYesterday {
    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(days: 1));
    return year == yesterday.year && month == yesterday.month && day == yesterday.day;
  }

  bool get isTomorrow {
    final now = DateTime.now();
    final tomorrow = now.add(const Duration(days: 1));
    return year == tomorrow.year && month == tomorrow.month && day == tomorrow.day;
  }

  bool get isFutureMonth {
    return year > DateTime.now().year || (year == DateTime.now().year && month > DateTime.now().month);
  }

  bool isSameWeekAs(DateTime other) {
    final startOfThisWeek = subtract(Duration(days: weekday - 1));
    final startOfOtherWeek = other.subtract(Duration(days: other.weekday - 1));
    return startOfThisWeek == startOfOtherWeek;
  }

  bool isThisWeek() {
    final now = DateTime.now();
    return isSameWeekAs(now);
  }

  bool isNextWeek() {
    final now = DateTime.now();
    final nextWeek = now.add(const Duration(days: 7));
    return isSameWeekAs(nextWeek);
  }

  bool isLastWeek() {
    final now = DateTime.now();
    final lastWeek = now.subtract(const Duration(days: 7));
    return isSameWeekAs(lastWeek);
  }

  bool isSameMonthAs(DateTime other) {
    return year == other.year && month == other.month;
  }

  bool isThisMonth() {
    final now = DateTime.now();
    return isSameMonthAs(now);
  }

  bool isAfterThisMonth() {
    final now = DateTime.now();
    final endOfMonth = DateTime(now.year, now.month + 1, 0, 23, 59, 59);
    return isAfter(endOfMonth);
  }

  bool isNextMonth() {
    final now = DateTime.now();
    var nextMonth = now.month == 12 ? now.year + 1 : now.year;
    nextMonth = now.month == 12 ? 1 : now.month + 1;
    final nextMonthDate = DateTime(nextMonth, now.month, now.day);
    return isSameMonthAs(nextMonthDate);
  }

  bool isLastMonth() {
    final now = DateTime.now();
    var lastMonth = now.month == 1 ? now.year - 1 : now.year;
    lastMonth = now.month == 1 ? 12 : now.month - 1;
    final lastMonthDate = DateTime(lastMonth, now.month, now.day);
    return isSameMonthAs(lastMonthDate);
  }

  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  bool isMonday() {
    return weekday == DateTime.monday;
  }

  bool isTuesday() {
    return weekday == DateTime.tuesday;
  }

  bool isWednesday() {
    return weekday == DateTime.wednesday;
  }

  bool isThursday() {
    return weekday == DateTime.thursday;
  }

  bool isFriday() {
    return weekday == DateTime.friday;
  }

  bool isSaturday() {
    return weekday == DateTime.saturday;
  }

  bool isSunday() {
    return weekday == DateTime.sunday;
  }

  bool get isValid {
    return year > 0 && month >= 1 && month <= 12 && day >= 1 && day <= daysInMonth(year, month);
  }

  int daysInMonth(int year, int month) {
    switch (month) {
      case 1:
      case 3:
      case 5:
      case 7:
      case 8:
      case 10:
      case 12:
        return 31;
      case 4:
      case 6:
      case 9:
      case 11:
        return 30;
      case 2:
        return isLeapYear(year) ? 29 : 28;
    }
    return 0;
  }

  bool isLeapYear(int year) {
    return year % 4 == 0 && (year % 100 != 0 || year % 400 == 0);
  }

  List<DateTime> datesOfMonth({bool maxNow = true}) {
    final DateTime firstDayOfMonth = DateTime(year, month, 1);
    final DateTime lastDayOfMonth = DateTime(year, month + 1, 0);
    final List<DateTime> dates = [];
    for (var i = firstDayOfMonth.day; i <= lastDayOfMonth.day; i++) {
      DateTime tmp = DateTime(year, month, i);
      if (maxNow) {
        if (tmp.isBefore(DateTime.now()) || tmp.isSameDay(DateTime.now())) {
          dates.add(tmp);
        }
      } else {
        dates.add(tmp);
      }
    }
    return dates;
  }

  bool isBetween(DateTime start, DateTime end) {
    bool res = true;
    res = res && isAfter(start) && isBefore(end);
    return res;
  }

  bool isBeforeOrSameday([DateTime? other]) {
    bool res = true;
    other = other ?? now;
    res = res && (isBefore(other) || isSameDay(other));
    return res;
  }

  bool isBetweenOrSame(DateTime start, DateTime end) {
    bool res = true;
    res = res && (isAfter(start) || isAtSameMomentAs(start));
    res = res && (isBefore(end) || isAtSameMomentAs(end));
    return res;
  }

  bool isAfterOrSame([DateTime? other]) {
    bool res = true;
    other = other ?? now;
    res = res && (isAfter(other) || isAtSameMomentAs(other));
    return res;
  }

  bool isAfterOrSameday([DateTime? other]) {
    bool res = true;
    other = other ?? now;
    res = res && (isAfter(other) || isSameDay(other));
    return res;
  }

  String toDateHuman([int? v]) {
    String res = "";
    switch (v) {
      case 0:
        res = DateFormat.yMMMMEEEEd('id').format(this);
        break;
      case 1:
        res = DateFormat.yMMMEd('id').format(this);
        break;
      case 2:
        res = DateFormat.yMEd('id').format(this);
        break;
      case 3:
        res = DateFormat.yMMMd('id').format(this);
        break;
      case 4:
        res = DateFormat.yMd('id').format(this);
        break;

      default:
        res = DateFormat.yMMMMEEEEd('id').format(this);
    }
    return res;
  }

  String toDateTimeHuman({int? v, String? space, String? prefix}) {
    String res = "";
    if (isToday) {
      res = 'Hari ini';
    } else if (isYesterday) {
      res = 'Kemarin';
    } else if (isTomorrow) {
      res = 'Besok';
    } else {
      switch (v) {
        case 0:
          res = DateFormat.yMMMMEEEEd('id').format(this);
          break;
        case 1:
          res = DateFormat.yMMMEd('id').format(this);
          break;
        case 2:
          res = DateFormat.yMEd('id').format(this);
          break;
        case 3:
          res = DateFormat.yMMMd('id').format(this);
          break;
        default:
          res = DateFormat.yMMMMEEEEd('id').format(this);
      }
    }
    res = "$res${space ?? ", "}${DateFormat.Hm('id').format(this)}";
    if (prefix != null) {
      res = prefix + res;
    }
    return res;
  }

  String toDateFilter(DateFilterMode mode) {
    String res = "NA";
    switch (mode) {
      case DateFilterMode.day:
        res = DateFormat.yMMMMEEEEd().format(this);
        break;
      case DateFilterMode.month:
        res = DateFormat.yMMMM().format(this);

        break;
      case DateFilterMode.year:
        res = DateFormat.y().format(this);

        break;
      default:
    }
    return res;
  }
}
