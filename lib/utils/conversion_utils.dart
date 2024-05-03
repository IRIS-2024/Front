import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String combineTimeOfDayWithCurrentDate(TimeOfDay timeOfDay) {
  DateTime now = DateTime.now().toUtc();
  String dateTimeString = DateTime(
    now.year,
    now.month,
    now.day,
    timeOfDay.hour,
    timeOfDay.minute,
  ).toUtc().toIso8601String();
  return dateTimeString;
}

String convertDateString(String originalDateString) {
  // 2024-02-09T07:11:42.069Z
  // 2024-02-15T03:18:29.191338
  if (originalDateString.isNotEmpty) {
    DateTime dateTime = DateTime.parse(originalDateString).toLocal();
    String formattedDateString = DateFormat('yy-MM-dd HH:mm').format(dateTime);
    return formattedDateString;
  } else {
    return '';
  }
}

String convertRegionNameToShort(String originalRegion) {
  // 강원특별자치도->강원
  // 세종특별자치시->세종
  // 전라북도특별자치도->전북
  // 제주특별자치도->제주

  if (originalRegion.contains('전라북도특별자치도')) {
    return originalRegion.replaceAll('전라북도특별자치도', '전북');
  } else if (originalRegion.contains('특별자치도')) {
    return originalRegion.replaceAll('특별자치도', '');
  } else if (originalRegion.contains('특별자치시')) {
    return originalRegion.replaceAll('특별자치시', '');
  } else {
    return originalRegion; // 변경 대상이 아닌 경우 원래 값 반환
  }
}
