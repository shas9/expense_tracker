import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:system_date_time_format/system_date_time_format.dart';

enum DatePatternType { datePattern, mediumDatePattern, longDatePartern }

enum DateContentType { fullDate, onlyDate, onlyTime }

extension DatePatternTypeExtenstion on DatePatternType {
  String? getDatePattern(BuildContext context) {
    final patterns = SystemDateTimeFormat.of(context);
    switch (this) {
      case DatePatternType.datePattern:
        return patterns.datePattern;
      case DatePatternType.mediumDatePattern:
        return patterns.mediumDatePattern;
      case DatePatternType.longDatePartern:
        return patterns.longDatePattern;
    }
  }
}

extension LocalizedDateTime on DateTime {
  String formatLocalizedTime(
    BuildContext context,
    DatePatternType datePattern, {
    DateContentType dateContentType = DateContentType.fullDate,
  }) {
    String locale = Platform.localeName;

    // Fetch system date and time patterns
    final patterns = SystemDateTimeFormat.of(context);
    final requiredDatePattern = datePattern.getDatePattern(context);
    final timePattern = patterns.timePattern;

    DateTime localTime = toLocal();

    // Format the time using the retrieved time pattern
    String formattedTime = DateFormat(timePattern, locale).format(localTime);
    String formattedDate = DateFormat(requiredDatePattern, locale).format(localTime);

    if (localTime.isToday() ||
        localTime.isTomorrow() ||
        localTime.isYesterday()) {
      formattedDate = _getRelativeLabel(localTime, context);
    }

    switch (dateContentType) {
      case DateContentType.fullDate:
        return "$formattedDate $formattedTime";
      case DateContentType.onlyDate:
        return formattedDate;
      case DateContentType.onlyTime:
        return formattedTime;
    }
  }

  String formatLocalizedDateForWheeler(BuildContext context) {
    String locale = Platform.localeName;

    // Fetch system date pattern
    const datePattern = DatePatternType.mediumDatePattern;
    final requiredDatePattern = datePattern.getDatePattern(context);

    DateTime localTime = toLocal();

    if (localTime.isToday()) {
      return _getRelativeLabel(localTime, context);
    } else {
      return DateFormat(requiredDatePattern, locale).format(localTime);
    }
  }

  String _getRelativeLabel(DateTime date, BuildContext context) {
    if (date.isToday()) {
      return 'Today';
    } else if (date.isTomorrow()) {
      return 'Tomorrow';
    } else if (date.isYesterday()) {
      return 'Yesterday';
    }
    return "";
  }

  bool isToday() {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  bool isTomorrow() {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return year == tomorrow.year &&
        month == tomorrow.month &&
        day == tomorrow.day;
  }

  bool isYesterday() {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }

  bool isElapsedTime() {
    final now = DateTime.now().toUtc();
    final currentUtc = toUtc();
    final isBeforeNow = isBefore(now);
    final isExactMatch = currentUtc.year == now.year &&
        currentUtc.month == now.month &&
        currentUtc.day == now.day &&
        currentUtc.hour == now.hour &&
        currentUtc.minute == now.minute;

    return isBeforeNow && !isExactMatch;
  }
}
