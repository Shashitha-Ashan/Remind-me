part of 'birthdays_bloc.dart';

@immutable
sealed class BirthdayState {}

final class BirthdaysInitial extends BirthdayState {}

class BirthdaysLoadingState extends BirthdayState {}

class BirthdaysSuccessLoadState extends BirthdayState {
  final BirthdayModel birthdayModel;

  BirthdaysSuccessLoadState({required this.birthdayModel});
}

class BirthdaysFailedLoadState extends BirthdayState {
  final String message;

  BirthdaysFailedLoadState({required this.message});
}

class BirthdayAdded extends BirthdayState {}

class BirthdayUpdated extends BirthdayState {}

class BirthdayDeleted extends BirthdayState {}
