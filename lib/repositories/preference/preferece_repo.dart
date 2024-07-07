import 'package:birth_daily/helpers/preference_helper.dart';

sealed class IPrefereceRepo {
  Future<bool?> getThemeStatus();

  Future<bool?> setThemeStatus({required bool themeStatus});

  Future<bool?> getNotificationStatus();

  Future<bool?> setNotificationStatus({required bool notificationStatus});
}

class PrefereceRepo extends IPrefereceRepo {
  final InitialPrefernce initialPrefernce;
  late PreferenceHelper preferenceHelper;
  PrefereceRepo({required this.initialPrefernce}) {
    preferenceHelper = PreferenceHelper(initialPrefernce: initialPrefernce);
  }
  @override
  Future<bool?> getNotificationStatus() async {
    return await preferenceHelper.getNotificationStatus();
  }

  @override
  Future<bool?> getThemeStatus() async {
    return await preferenceHelper.getThemeStatus();
  }

  @override
  Future<bool?> setNotificationStatus(
      {required bool notificationStatus}) async {
    return await preferenceHelper.setNotificationStatus(
        notificationStatus: notificationStatus);
  }

  @override
  Future<bool?> setThemeStatus({required bool themeStatus}) async {
    return await preferenceHelper.setThemeStatus(themeStatus: themeStatus);
  }

  InitialPrefernce getInitialPreferences() {
    return InitialPrefernce.copyWith(
        notificationStatus: initialPrefernce.notificationStatus,
        themeStatus: initialPrefernce.themeStatus);
  }
}
