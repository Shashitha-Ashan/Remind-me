part of 'birthdays_bloc.dart';

@immutable
sealed class BirthdaysState {}

final class BirthdaysInitial extends BirthdaysState {}

class InitialState extends BirthdaysState {}

class LoadingState extends BirthdaysState {}

class SuccessLoadState extends BirthdaysState {
  final BirthdayModel birthdayModel;

  SuccessLoadState({required this.birthdayModel});
}

class FailedLoadState extends BirthdaysState {
  final String error;

  FailedLoadState({required this.error});
}
