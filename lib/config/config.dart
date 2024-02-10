class Config {
  // info form page
  static bool man = false;
  static bool woman = true;

  String getGenderText(bool gender) {
    return gender == Config.woman ? '여자' : '남자';
  }

  // comment form page
  static String enterTime = '시간 입력';

  static int maxImagesLength = 3;
}
