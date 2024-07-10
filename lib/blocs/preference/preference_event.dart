part of 'preference_bloc.dart';

@immutable
sealed class PreferenceEvent {}

class ThemeToggleEvent extends PreferenceEvent {
  final bool themeStatus;
  ThemeToggleEvent({required this.themeStatus});
}

class NotificationToggleEvent extends PreferenceEvent {
  final bool notificationStatus;

  NotificationToggleEvent({required this.notificationStatus});
}

class FirstRunCompleteEvent extends PreferenceEvent {}
