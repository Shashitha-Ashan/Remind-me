import 'package:birth_daily/utils/themes.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'theme_event.dart';
part 'theme_state.dart';

enum ThemeStatus { dark, light }

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeInitialState(themeData: darkTheme)) {
    on<ThemeEvent>((event, emit) {
      if (event is DarkThemeEvent) {
        emit(DarkThemeState(themeData: darkTheme));
      }
      if (event is LightThemeEvent) {
        emit(LightThemeState(themeData: lightTheme));
      }
    });
  }
}
