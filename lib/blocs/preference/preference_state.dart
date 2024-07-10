part of 'preference_bloc.dart';

@immutable
sealed class PreferenceState {}

class PreferenceInitial extends PreferenceState {
  final InitialPrefernce initialPrefernce;
  PreferenceInitial({
    required this.initialPrefernce,
  });
}

class ThemeToggleState extends PreferenceState {
  final bool themeStatus;
  final bool notificationStatus;
  ThemeToggleState({
    required this.notificationStatus,
    required this.themeStatus,
  });
}

class NotificationToggleState extends PreferenceState {
  final bool notificationStatus;
  final bool themeStatus;
  NotificationToggleState({
    required this.notificationStatus,
    required this.themeStatus,
  });
}

class FirstRunCompleteState extends PreferenceState {}
