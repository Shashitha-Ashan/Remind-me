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
  ThemeToggleState({required this.themeStatus});
}

class NotificationToggleState extends PreferenceState {
  final bool notificationStatus;
  NotificationToggleState({required this.notificationStatus});
}

class FirstRunCompleteState extends PreferenceState {}
