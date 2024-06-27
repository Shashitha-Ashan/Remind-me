part of 'theme_bloc.dart';

@immutable
sealed class ThemeState {}

final class ThemeInitialState extends ThemeState {
  final ThemeData themeData;

  ThemeInitialState({
    required this.themeData,
  });
}

class DarkThemeState extends ThemeState {
  final ThemeData themeData;

  DarkThemeState({required this.themeData});
}

class LightThemeState extends ThemeState {
  final ThemeData themeData;

  LightThemeState({required this.themeData});
}
