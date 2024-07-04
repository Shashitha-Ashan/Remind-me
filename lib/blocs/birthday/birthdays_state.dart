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

class BirthdayAdd extends BirthdayState {}

class BirthdayAddError extends BirthdayState {}

class BirthdayUpdated extends BirthdayState {}

class BirthdayUpdate extends BirthdayState {
  final String id;
  final String name;
  final DateTime date;
  final bool isLovingOne;
  final int avatarIndex;

  BirthdayUpdate(this.isLovingOne, this.avatarIndex,
      {required this.id, required this.name, required this.date});
}

class BirthdayUpdateError extends BirthdayState {}

class BirthdayDeleted extends BirthdayState {}

class BirthdayDeleteError extends BirthdayState {}
