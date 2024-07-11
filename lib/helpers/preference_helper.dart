import 'package:firebase_messaging/firebase_messaging.dart';
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
    if (notificationStatus) {
      FirebaseMessaging.instance.getToken();
    } else {
      FirebaseMessaging.instance.deleteToken();
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool('notification', notificationStatus);
  }

  Future<bool?> setFirstRunCompleted() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('theme', false);
    await prefs.setBool('notification', true);
    return await prefs.setBool('firsRun', false);
  }

  static Future<InitialPrefernce> getInitialPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return InitialPrefernce(
        notificationStatus: prefs.getBool('notification'),
        themeStatus: prefs.getBool('theme'),
        isFirstRun: prefs.getBool('firsRun'));
  }
}

class InitialPrefernce {
  final bool? notificationStatus;
  final bool? themeStatus;
  final bool? isFirstRun;
  InitialPrefernce({
    required this.notificationStatus,
    required this.themeStatus,
    required this.isFirstRun,
  });
  InitialPrefernce.copyWith(
      {bool? notificationStatus, bool? themeStatus, bool? isFirstRun})
      : this(
          notificationStatus: notificationStatus ?? true,
          themeStatus: themeStatus ?? false,
          isFirstRun: isFirstRun ?? true,
        );
}
