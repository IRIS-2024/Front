import 'package:iris_flutter/utils/conversion_utils.dart';

String getTimeDiffText(String createdAt, String? updateAt) {
  if (updateAt != null) { // 수정한 적 있음
    return _getTimeDifference(updateAt);
  } else {
    return _getTimeDifference(createdAt);
  }
}

String _getTimeDifference(String dateTimeString) {
  DateTime givenTime = DateTime.parse(dateTimeString);

  DateTime now = DateTime.now();
  Duration difference = now.difference(givenTime);

  // 차이를 분 단위로 계산
  int minutesDifference = difference.inMinutes;

  if (minutesDifference < 1) { // 차이 1분 이내
    return '방금 전';
  } else if (minutesDifference < 60) { // 차이 60분 이내
    return '$minutesDifference분 전';
  } else {
    int hoursDifference = difference.inHours;

    // 차이가 24시간을 넘어가는 경우
    if (hoursDifference >= 24) {
      return convertDateString(dateTimeString);
    }

    // 차이 24시간 이내
    return '$hoursDifference시간 전';
  }
}