part of 'theme_bloc.dart';

@immutable
sealed class ThemeEvent {}

class DarkThemeEvent extends ThemeEvent {}

class LightThemeEvent extends ThemeEvent {}
