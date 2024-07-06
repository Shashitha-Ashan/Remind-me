part of 'birthday_form_bloc.dart';

@immutable
sealed class BirthdayFormState {}

final class BirthdayFormInitial extends BirthdayFormState {}

class BirthdayNameUpdatedState extends BirthdayFormState {
  final String name;

  BirthdayNameUpdatedState({required this.name});
}

class BirthdayDateUpdatedState extends BirthdayFormState {
  final DateTime date;

  BirthdayDateUpdatedState({required this.date});
}

class BirthdayLovingOneUpdatedState extends BirthdayFormState {
  final DateTime date;

  BirthdayLovingOneUpdatedState({required this.date});
}

class BirthdayImageUpdatedState extends BirthdayFormState {
  final String imageURL;

  BirthdayImageUpdatedState({required this.imageURL});
}
