part of 'birthdays_bloc.dart';

@immutable
sealed class BirthdayState {}

final class BirthdaysInitial extends BirthdayState {}

class BirthdaysLoadingState extends BirthdayState {}

class BirthdaysSuccessLoadState extends BirthdayState {
  final List<BirthdayModel> birthdays;

  BirthdaysSuccessLoadState({required this.birthdays});
}

class BirthdaysFailedLoadState extends BirthdayState {
  final String message;

  BirthdaysFailedLoadState({required this.message});
}

class BirthdayAdded extends BirthdayState {}

class BirthdayAddError extends BirthdayState {}

class BirthdayUpdated extends BirthdayState {}

class BirthdayUpdateError extends BirthdayState {}

class BirthdayDeleted extends BirthdayState {}

class BirthdayDeleteError extends BirthdayState {}
