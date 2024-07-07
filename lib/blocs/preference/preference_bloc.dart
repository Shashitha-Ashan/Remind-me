import 'package:birth_daily/helpers/preference_helper.dart';
import 'package:birth_daily/repositories/preference/preferece_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'preference_event.dart';
part 'preference_state.dart';

class PreferenceBloc extends Bloc<PreferenceEvent, PreferenceState> {
  PrefereceRepo prefereceRepo;
  PreferenceBloc({required this.prefereceRepo})
      : super(PreferenceInitial(
            initialPrefernce: prefereceRepo.getInitialPreferences())) {
    on<PreferenceEvent>((event, emit) async {
      if (event is ThemeToggleEvent) {
        await prefereceRepo.setThemeStatus(themeStatus: event.themeStatus);
        emit(ThemeToggleState(themeStatus: event.themeStatus));
      }
      if (event is NotificationToggleEvent) {
        await prefereceRepo.setNotificationStatus(
            notificationStatus: event.notificationStatus);
        emit(NotificationToggleState(
            notificationStatus: event.notificationStatus));
      }
      if (event is FirstRunCompleteEvent) {
        emit(FirstRunCompleteState());
        await prefereceRepo.setFirstRunCompleted();
      }
    });
  }
}
