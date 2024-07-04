part of 'theme_bloc.dart';

@immutable
sealed class ThemeState {}

final class ThemeInitialState extends ThemeState {
  final ThemeData themeData;

  ThemeInitialState({
    required this.themeData,
  });
}

class ToggleThemeState extends ThemeState {
  final ThemeData themeData;

  ToggleThemeState({required this.themeData});
}
