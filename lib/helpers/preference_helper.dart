import 'package:shared_preferences/shared_preferences.dart';

class PreferenceHelper {
  final InitialPrefernce initialPrefernce;
  PreferenceHelper({required this.initialPrefernce});
  Future<bool?> getThemeStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('theme');
  }

  Future<bool?> setThemeStatus({required bool themeStatus}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool('theme', themeStatus);
  }

  Future<bool?> getNotificationStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('notification');
  }

  Future<bool?> setNotificationStatus(
      {required bool notificationStatus}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool('notification', notificationStatus);
  }

  static Future<InitialPrefernce> getInitialPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return InitialPrefernce(
        notificationStatus: prefs.getBool('notification'),
        themeStatus: prefs.getBool('theme'));
  }
}

class InitialPrefernce {
  final bool? notificationStatus;
  final bool? themeStatus;
  InitialPrefernce(
      {required this.notificationStatus, required this.themeStatus});
  InitialPrefernce.copyWith({bool? notificationStatus, bool? themeStatus})
      : this(
            notificationStatus: notificationStatus ?? true,
            themeStatus: themeStatus ?? false);
}
