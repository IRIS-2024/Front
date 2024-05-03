import 'package:intl/intl.dart';
import 'package:iris_flutter/utils/conversion_utils.dart';

String getTimeDifference(String createdAt) {
  // createdAt을 DateTime으로 파싱
  DateTime givenTime = DateTime.parse(createdAt); // -> Utc
  DateTime now = DateTime.now().toUtc();
  Duration difference = now.difference(givenTime);

  if (difference.inDays > 0) {
    // 차이가 24시간을 넘어가는 경우
    return convertDateString(createdAt);
  } else {
    // 차이가 1시간을 넘어가는 경우 (~24시간 전)
    if ((now.hour-givenTime.hour).abs() >= 1) {
      return '${now.hour-givenTime.hour}${Intl.message('hoursAgo')}';
    } else {
      // 차이가 1분을 넘어가는 경우 (~1시간 전)
      if ((now.minute-givenTime.minute).abs() >= 1) {
        return '${now.minute-givenTime.minute}${Intl.message('minutesAgo')}';
      } else {
        // 차이가 1분 이내
        return Intl.message('momentAgo');
      }
    }
  }
}
