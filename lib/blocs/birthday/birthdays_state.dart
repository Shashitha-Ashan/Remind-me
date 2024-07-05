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

class BirthdayUpdateState extends BirthdayState {
  final String? docId;
  final String name;
  final Timestamp date;
  final bool isLovingOne;
  final String imageURL;

  BirthdayUpdateState(
      {required this.isLovingOne,
      required this.imageURL,
      this.docId,
      required this.name,
      required this.date});
}

class BirthdayUpdateError extends BirthdayState {}

class BirthdayDeleted extends BirthdayState {}

class BirthdayDeleteError extends BirthdayState {}
