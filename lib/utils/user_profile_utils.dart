import 'package:iris_flutter/config/config.dart';

int getUserId() {
  return int.parse(userStorage.getItem(Config.id) ?? '');
}

String getUserDisplayName() {
  return userStorage.getItem(Config.displayName) ?? '';
}

String getUserEmail() {
  return userStorage.getItem(Config.email) ?? '';
}

Future<String> getAT() async {
  return await tokenStorage.read(key: 'AccessToken') ?? '';
}

Future<String> getRT() async {
  return await tokenStorage.read(key: 'RefreshToken') ?? '';
}
