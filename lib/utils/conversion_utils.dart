import 'package:flutter/material.dart';

String combineTimeOfDayWithCurrentDate(TimeOfDay timeOfDay) {
  DateTime now = DateTime.now();
  String dateTimeString = DateTime(
    now.year,
    now.month,
    now.day,
    timeOfDay.hour,
    timeOfDay.minute,
  ).toUtc().toIso8601String();
  return dateTimeString;
}